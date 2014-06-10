From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Tue, 10 Jun 2014 15:23:20 +0530
Subject: [PATCH 2/3] spi: s3c64xx: remove a compilation warning with an
 assignment
In-Reply-To: <CAK5sBcGfE0fsZ1wZX79GOhXBXkSAn3YFt2MsuMcbFnvV_Cw=wA@mail.gmail.com>
References: <1402390859-28287-1-git-send-email-ch.naveen@samsung.com>
 <1402390859-28287-3-git-send-email-ch.naveen@samsung.com>
 <CAK5sBcGfE0fsZ1wZX79GOhXBXkSAn3YFt2MsuMcbFnvV_Cw=wA@mail.gmail.com>
Message-ID: <CAHfPSqA-8UK0gFxdB_NHDL+HeRoK3Yrm_2kwp71e0oSL6u=wSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sachin,

On 10 June 2014 15:15, Sachin Kamat <spk.linux@gmail.com> wrote:
> Hi Naveen,
>
> On Tue, Jun 10, 2014 at 2:30 PM, Naveen Krishna Chatradhi
> <ch.naveen@samsung.com> wrote:
>> This patch returns an integer error value instead of the
>> pointer.
>>
>> "warning: return makes integer from pointer without a cast"
>>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Cc: Doug Anderson <dianders@chromium.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 0c6013f..4594dde 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -817,7 +817,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>>
>>         if (!spi->dev.of_node) {
>>                 dev_err(&spi->dev, "device node not found\n");
>> -               return ERR_PTR(-EINVAL);
>> +               return -EINVAL;
>
> Isn't this warning introduced by the previous patch (patch1/3)?
> If so then this patch should be squashed into that.
You are right, I've introduced this warning in the 1st patch.
But, realized it only latter. Will spin along with the documentation.
>
> --
> Regards,
> Sachin.



-- 
Shine bright,
(: Nav :)
