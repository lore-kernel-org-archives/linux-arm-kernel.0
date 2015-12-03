From: leoli@freescale.com (Li Yang)
Date: Thu, 3 Dec 2015 14:44:34 -0600
Subject: [PATCH] ARM64: dts: ls2080a: fix eSDHC endianness
In-Reply-To: <BLUPR0301MB2065FE8A1FB9F462CF44EF5AF20D0@BLUPR0301MB2065.namprd03.prod.outlook.com>
References: <1446788617-35736-1-git-send-email-yangbo.lu@freescale.com>
 <BLUPR0301MB2065FE8A1FB9F462CF44EF5AF20D0@BLUPR0301MB2065.namprd03.prod.outlook.com>
Message-ID: <CADRPPNSaJ+0vQs8s5c6d0+dj=NMi7q-uDu_8ERJdB5UFv_06gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 2, 2015 at 9:54 PM, Lu Y.B. <yangbo.lu@freescale.com> wrote:
> Hi Catalin,
>
> Could you help to review and merge this patch, since it has had no response for a month.
> Thanks.

This is a platform/soc change instead of a core ARM64 change.  I will
help to collect the pending platform patches and send to the soc
maintainers to review and accept.

>
>
> Best regards,
> Yangbo Lu
>
>> -----Original Message-----
>> From: Lu Yangbo-B47093
>> Sent: Thursday, November 26, 2015 10:05 AM
>> To: linux-arm-kernel at lists.infradead.org; Catalin Marinas
>> Subject: RE: [PATCH] ARM64: dts: ls2080a: fix eSDHC endianness
>>
>> Any comments?
>> Thanks.
>>
>>
>> - Yangbo Lu
>>
>> > -----Original Message-----
>> > From: Yangbo Lu [mailto:yangbo.lu at freescale.com]
>> > Sent: Friday, November 06, 2015 1:44 PM
>> > To: linux-arm-kernel at lists.infradead.org; Catalin Marinas
>> > Cc: Lu Yangbo-B47093
>> > Subject: [PATCH] ARM64: dts: ls2080a: fix eSDHC endianness
>> >
>> > Add the "little-endian" property to fix the issue that eSDHC is not
>> > working and dumping out "mmc0: Controller never released inhibit
>> bit(s)."
>> > error messages constantly.
>> >
>> > Fixes: 5461597f6ce0 ("dts/ls2080a: Update DTSI to add support of
>> > various
>> > peripherals")
>> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>> > b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>> > index e81cd48..ed45e25 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
>> > @@ -269,6 +269,7 @@
>> >                     clock-frequency = <0>;  /* Updated by bootloader */
>> >                     voltage-ranges = <1800 1800 3300 3300>;
>> >                     sdhci,auto-cmd12;
>> > +                   little-endian;
>> >                     bus-width = <4>;
>> >             };
>> >
>> > --
>> > 2.1.0.27.g96db324
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
- Leo
