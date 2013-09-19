From: linux.melwyn@gmail.com (melwyn lobo)
Date: Thu, 19 Sep 2013 23:28:45 +0900
Subject: Vexpress config
In-Reply-To: <1379323515.3998.12.camel@hornet>
References: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
 <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
 <1379323515.3998.12.camel@hornet>
Message-ID: <CAHSGOusEZtdVwnKo7fxLKQKnVVde1FRHtruRYG9BkBpNB6r3ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> The Cortex-A9 RTSM is not an equivalent of the V2P-CA9 CoreTile, so you
> have to boot your kernel with a relevant Device Tree. You'll find them
> here: http://linux-arm.org/git?p=arm-dts.git;a=tree;f=fast_models
>

You are right. I have a coretile V2P-CA9 with PERIHPBASE at 0x2c000000
whch does not match that of the kernel.
Also other addresses in the Model's memory map also seem to be way off
from the kernel defintions. (like the timer, wtachdog, clcd etc)
The model is downloaded from ARM Fast model suite, should be 2013
release version .
Where do I find patches to boot ARM's fast model (either of Coretile
V2p CA9x4 or CA15x4). I tried looking at linaro's releases site  :
http://releases.linaro.org/13.08/android/vexpress

Even Linaro's released kernel sources have a memory map similar to the
open source one.
CC: Peter Maydell <peter.maydell@linaro.org>
Any pointers ?

> Now, the question is how do you actually boot the kernel? Can you cope
> with the DTB? Linaro's boot wrapper
> https://git.linaro.org/gitweb?p=arm/models/boot-wrapper.git can handle
> DTBs, however you'll need some extra patches to get it working on A9.
> Contact its maintainer (peter.maydel at linaro.org) if you were planning to
> use it.
>
> Good luck!
>
> Pawel
>
>
