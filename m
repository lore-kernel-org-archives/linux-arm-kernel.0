From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 2 Feb 2010 20:44:47 -0500
Subject: [PATCH 1/4] mfd: update i2c driver for max8925
In-Reply-To: <20100202151554.GC28139@sortiz.org>
References: <771cded01001250307o7e340a0dsf7e02762dad8c953@mail.gmail.com>
	<20100129195405.GB23130@sortiz.org>
	<771cded01002020622v7fa47689je2a5b1c11e2bb0c7@mail.gmail.com>
	<20100202151554.GC28139@sortiz.org>
Message-ID: <771cded01002021744y52574cdl3baf36999909d210@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2010 at 10:15 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
>> Yes, the code is not very clear. Now I use i2c_new_dummy() now. Now I
>> attache new patches now.
>>
>> Updates are in below.
>> 1. use i2c_new_dummy() to replace i2c_new_probed_device().
>> 2. add onkey driver
>> 3. remove unused i2c pointer in rtc driver
> Very good, I just have one last comment:
>
>
>> @@ -142,27 +138,28 @@ static int __devinit max8925_probe(struct i2c_client *client,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?const struct i2c_device_id *id)
>> ?{
>> ? ? ? struct max8925_platform_data *pdata = client->dev.platform_data;
>> - ? ? struct max8925_chip *chip;
>> + ? ? static struct max8925_chip *chip;
> That no longer needs to be static.
> The rest of the code looks fine to me. Once you remove that static
> definition, and you add some comments explaining why you need those 3 i2c
> pointers, I'll merge it.
>

Thanks a lot. I update the patch. Now the fix is in below.
1. Remove static on max8925_chip.
2. Add more comments on using 3 i2c pointers.

Best Regards
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mfd-update-i2c-driver-for-max8925.patch
Type: text/x-patch
Size: 3590 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/363c745d/attachment.bin>
