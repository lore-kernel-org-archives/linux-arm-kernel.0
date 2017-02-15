From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 15 Feb 2017 15:01:40 -0800
Subject: [PATCH v9 2/3] fpga manager: Add cyclone-ps-spi driver for Altera
 FPGAs
In-Reply-To: <CANk1AXQy1nLjZAEpy0CDpS7GqvL+0y7f7Q5EuOZ1AqjBOPDwEw@mail.gmail.com>
References: <cover.1485295905.git.stillcompiling@gmail.com>
 <94f1d92f502b64669467c467038c3aa766b312ad.1485295905.git.stillcompiling@gmail.com>
 <20170215162641.5bc50cf3@crub>
 <CANk1AXQy1nLjZAEpy0CDpS7GqvL+0y7f7Q5EuOZ1AqjBOPDwEw@mail.gmail.com>
Message-ID: <347abcac-6f3c-29db-ed68-26d07831a04b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/15/2017 09:14 AM, Alan Tull wrote:
> On Wed, Feb 15, 2017 at 9:26 AM, Anatolij Gustschin <agust@denx.de> wrote:
>> Hi Joshua,
>>
>> On Tue, 24 Jan 2017 14:19:33 -0800
>> Joshua Clayton stillcompiling at gmail.com wrote:
>> ...
>>> +static int cyclonespi_write(struct fpga_manager *mgr, const char *buf,
>>> +                          size_t count)
>>> +{
>>> +      struct cyclonespi_conf *conf = (struct cyclonespi_conf *)mgr->priv;
>>> +      const char *fw_data = buf;
>>> +      const char *fw_data_end = fw_data + count;
>>> +
>>> +      while (fw_data < fw_data_end) {
>>> +              int ret;
>>> +              size_t stride = min(fw_data_end - fw_data, SZ_4K);
>>> +
>>> +              rev_buf(fw_data, stride);
>> Can we make rev_buf() optional here? I've tested this driver with
>> Stratix-V FPGA using orion_spi driver. It works without swapping
>> the data.
Thanks for testing!
I'd be happy to make it an optional feature, rather than integral.
> I replied earlier, but something in my email settings bounced.
>
> The way to make it optional is to add a bit to the flags of the
> fpga_image_info struct.
>
> Alan
OK.
>
>> Thanks,
>> Anatolij
