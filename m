From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Aug 2017 14:07:24 +0200
Subject: [PATCH] arm64: dts: marvell: armada-3720-espressobin: Add vqmmc
 regulator for SD slot
In-Reply-To: <20170803081011.101dcccd@xps13> (Miquel RAYNAL's message of "Thu,
 3 Aug 2017 08:10:11 +0200")
References: <20170729104411.3602-1-sean@nyekjaer.dk>
 <20170802193440.21226c2a@xps13>
 <CAKv0xJx-Jrr8gh30SeFb3A3zRXo2YDG8KtNp7vp25qTqtMfd9g@mail.gmail.com>
 <20170803081011.101dcccd@xps13>
Message-ID: <87a83gam83.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,
 
 On jeu., ao?t 03 2017, Miquel RAYNAL <miquel.raynal@free-electrons.com> wrote:

> Hi,
>
> On Thu, 3 Aug 2017 08:03:24 +0200
> Sean Nyekj?r <sean@nyekjaer.dk> wrote:
>
>> On 2 August 2017 at 19:34, Miquel RAYNAL
>> <miquel.raynal@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Sat, 29 Jul 2017 12:44:11 +0200
>> > Sean Nyekjaer <sean@nyekjaer.dk> wrote:
>> >  
>> >> By adding this regulator, the SD cards are usable at higher speed
>> >> protocols such as SDR104.
>> >>
>> >> This patch was tested with an SDHC card compatible with UHS-I.
>> >>
>> >> Signed-off-by: Sean Nyekjaer <sean@nyekjaer.dk>  
>> >
>> > The patch does the job, but does not apply as is.  
>> Try applying  "[PATCH] arm64: dts: marvell: Add microsd card
>> definition for the ESPRESSObin" first :-)
>
> I know, but I was pointing the dependency again because there is at
> least one other patch that does the same uSD addition in ESPRESSObin DT
> and I do not know which one will be selected by the maintainer.

As you didn't copy any of the mvebu maintainer I missed your patch. And
I saw this one only thanks to the patch "ARM64: dts: marvell:
armada-37xx: Enable uSD on ESPRESSObin", because I thought your patch
was a follow-up of this one.

I will still apply ""ARM64: dts: marvell: armada-37xx: Enable uSD on
ESPRESSObin" which is already well formatted and enables everything in a
single patch, I will just have to remove the "no-1-8-v" that Marcin
should have let by mistake.

Next time please don't forget to CC the maintainers.

Thanks,

Gregory

>
> BR,
> Miqu?l
>
>> 
>> Br
>> Sean
>> >
>> > Tested-by: Miquel Raynal <miquel.raynal@free-electrons.com>
>> >
>> > Regards,
>> > Miqu?l
>> >  
>> >> ---
>> >>
>> >> This patch depends on "[PATCH] arm64: dts: marvell: Add microsd
>> >> card definition for the ESPRESSObin"
>> >>
>> >>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 15
>> >> ++++++++++++++- 1 file changed, 14 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git
>> >> a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
>> >> b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts index
>> >> 2dadd77e08eb..d5ab5b47f8d4 100644 ---
>> >> a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts +++
>> >> b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts @@ -60,6
>> >> +60,19 @@ device_type = "memory"; reg = <0x00000000 0x00000000
>> >> 0x00000000 0x20000000>; };
>> >> +
>> >> +     vcc_sd_reg1: regulator {
>> >> +             compatible = "regulator-gpio";
>> >> +             regulator-name= "vcc_sd1";
>> >> +             regulator-min-microvolt = <1800000>;
>> >> +             regulator-max-microvolt = <3300000>;
>> >> +
>> >> +             gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
>> >> +             gpios-states = <0>;
>> >> +             states = <1800000 0x1
>> >> +                       3300000 0x0>;
>> >> +             enable-active-high;
>> >> +     };
>> >>  };
>> >>
>> >>  /* J9 */
>> >> @@ -82,7 +95,7 @@
>> >>       wp-inverted;
>> >>       bus-width = <4>;
>> >>       cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
>> >> -     no-1-8-v;
>> >> +     vqmmc-supply = <&vcc_sd_reg1>;
>> >>       marvell,pad-type = "sd";
>> >>       status = "okay";
>> >>  };  
>> >
>> >
>> >
>> > --
>> > Miquel Raynal, Free Electrons
>> > Embedded Linux and Kernel engineering
>> > http://free-electrons.com  
>
>
>
> -- 
> Miquel Raynal, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
