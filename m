From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 Sep 2013 15:38:32 +0100
Subject: Vexpress config
In-Reply-To: <CAHSGOusEZtdVwnKo7fxLKQKnVVde1FRHtruRYG9BkBpNB6r3ag@mail.gmail.com>
References: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
 <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
 <1379323515.3998.12.camel@hornet>
 <CAHSGOusEZtdVwnKo7fxLKQKnVVde1FRHtruRYG9BkBpNB6r3ag@mail.gmail.com>
Message-ID: <1379601512.3347.26.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 15:28 +0100, melwyn lobo wrote:
> You are right. I have a coretile V2P-CA9 with PERIHPBASE at 0x2c000000
> whch does not match that of the kernel.
> Also other addresses in the Model's memory map also seem to be way off
> from the kernel defintions. (like the timer, wtachdog, clcd etc)
> The model is downloaded from ARM Fast model suite, should be 2013
> release version .
> Where do I find patches to boot ARM's fast model (either of Coretile
> V2p CA9x4 or CA15x4). I tried looking at linaro's releases site  :
> http://releases.linaro.org/13.08/android/vexpress

You won't find any extra patches. The addresses you see in
arch/arm/mach-vexpress are not used for anything else but the V2P-CA9.
All new core tiles (I'm talking real hardware here, an I can assure you
it works) are defined in relevant device trees. You'll find a collection
of those for *hardware* platforms in the kernel as well, look at
arch/arm/boot/dts/vexpress*

If you want to boot RTSM_VE_Cortex-A15x4, you should be able to simply
use the boot wrapper I've mentioned without any change. The extra
patches are required only for A5 & A9 models. All you need is to get
yourself a correct DTB:

http://linux-arm.org/git?p=arm-dts.git;a=blob_plain;f=fast_models/rtsm_ve-cortex_a15x4.dts

compile it:

dtc -I dts -O dtb rtsm_ve-cortex_a15x4.dts -o rtsm_ve-cortex_a15x4.dtb

and pass it to the boot wrapper, following its README file.

Pawe?
