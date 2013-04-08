From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 8 Apr 2013 10:41:35 +0530
Subject: [PATCH v8 1/2] ARM: davinci: dm365: add support for v4l2 video
 display
In-Reply-To: <515D48E5.1060700@ti.com>
References: <1364903681-13914-1-git-send-email-prabhakar.csengg@gmail.com>
 <1364903681-13914-2-git-send-email-prabhakar.csengg@gmail.com>
 <515D48E5.1060700@ti.com>
Message-ID: <CA+V-a8siF1HSRbpA=Oe-OMwtr_HuNP3scf3Qochb7He2Y+zwKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar,

On Thu, Apr 4, 2013 at 3:03 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On 4/2/2013 5:24 PM, Prabhakar lad wrote:
>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>
>> Create platform devices for various video modules like venc,osd,
>> vpbe and v4l2 driver for dm365.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>
> Minor nits below:
>
>> diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
>> index c61dd94..786c860 100644
>> --- a/arch/arm/mach-davinci/dm365.c
>> +++ b/arch/arm/mach-davinci/dm365.c
>> @@ -40,10 +40,14 @@
>>
>>  #define DM365_REF_FREQ               24000000        /* 24 MHz on the DM365 EVM */
>>
>> +#define DM365_RTC_BASE                       0x01c69000
>> +
>>  /* Base of key scan register bank */
>>  #define DM365_KEYSCAN_BASE           0x01c69400
>>
>> -#define DM365_RTC_BASE                       0x01c69000
>> +#define DM365_OSD_BASE                       0x01c71c00
>> +
>> +#define DM365_VENC_BASE                      0x01c71e00
>>
>>  #define DAVINCI_DM365_VC_BASE                0x01d0c000
>
> No need of empty lines between these definitions. While at it you can
> also remove the useless comment "/* Base of key scan register bank */"
>
OK

>> +static int dm365_vpbe_setup_pinmux(enum v4l2_mbus_pixelcode if_type,
>> +                         int field)
>> +{
>> +     switch (if_type) {
>> +     case V4L2_MBUS_FMT_SGRBG8_1X8:
>> +             davinci_cfg_reg(DM365_VOUT_FIELD_G81);
>> +             davinci_cfg_reg(DM365_VOUT_COUTL_EN);
>> +             davinci_cfg_reg(DM365_VOUT_COUTH_EN);
>> +             break;
>> +
>
> No need of these empty lines after 'break'. Here and other places below.
>
OK

> The patch looks good overall though so you can fix the nits and add:
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks.

Regards,
--Prabhakar

>
> Thanks,
> Sekhar
