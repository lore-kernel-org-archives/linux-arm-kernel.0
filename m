From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 9 Apr 2013 17:21:07 +0530
Subject: [PATCH v9 1/2] ARM: davinci: dm365: add support for v4l2 video
 display
In-Reply-To: <51640004.6020604@ti.com>
References: <1365412636-3468-1-git-send-email-prabhakar.csengg@gmail.com>
 <1365412636-3468-2-git-send-email-prabhakar.csengg@gmail.com>
 <51640004.6020604@ti.com>
Message-ID: <CA+V-a8tRuMdauvpjj0ekUsGZgvJhgJbnA-tjgOYgR1Eg09zRLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar,

On Tue, Apr 9, 2013 at 5:18 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On 4/8/2013 2:47 PM, Prabhakar lad wrote:
>> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>
>> Create platform devices for various video modules like venc,osd,
>> vpbe and v4l2 driver for dm365.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>> ---
>
>> diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
>> index 12d544b..a9de512 100644
>> --- a/arch/arm/mach-davinci/davinci.h
>> +++ b/arch/arm/mach-davinci/davinci.h
>> @@ -36,8 +36,13 @@
>>  #include <media/davinci/vpbe_osd.h>
>>
>>  #define DAVINCI_SYSTEM_MODULE_BASE   0x01c40000
>> +#define SYSMOD_VDAC_CONFIG           0x2c
>>  #define SYSMOD_VIDCLKCTL             0x38
>>  #define SYSMOD_VPSS_CLKCTL           0x44
>> +#define VPSS_VENCCLKEN_ENABLE                BIT(3)
>> +#define VPSS_DACCLKEN_ENABLE         BIT(4)
>> +#define VPSS_PLLC2SYSCLK5_ENABLE     BIT(5)
>> +
>
> Prabhakar, I noticed it only after I applied these patches, but these
> bit definitions in between list of register offsets is distracting. Can
> you please move them down after the register offsets when you send the
> pull request? You can add a comment /* VPSS CLKCTL bit definitions */
> before you start the bit definitions.
>
OK, I'll fix it while issuing the pull request.

Regards,
--Prabhakar

>>  #define SYSMOD_VDD3P3VPWDN           0x48
>>  #define SYSMOD_VSCLKDIS                      0x6c
>>  #define SYSMOD_PUPDCTL1                      0x7c
>
> Thanks,
> Sekhar
