From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 9 May 2016 09:53:11 +0100
Subject: Reverting ARCH_SUNXI arm64 support(?)
Message-ID: <57304FF7.3080909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Catalin,

Suzuki reported a build failure with certain (non-defconfig) .configs
due to the new ARCH_SUNXI support in 4.6-rc [1].
As unfortunately we couldn't agree on a solution and also the support
for the A64/Pine64 is partial in 4.6 anyway, can you please revert:
ce3dd55b99b151a90ac1701c6825f2ae2d49b54e ("arm64: Introduce Allwinner
SoC config option")
So with this revert we have the arm64 defconfig now selecting useless
symbols, it didn't complain, but I was wondering if we should revert the
defconfig patch as well then? But this looks like pain :-(

If all this reverting is too much due to conflicts, we might think about
going with Suzuki's original one-liner [1], which would be an easy fix -
though Olof opposed it back then (in favour of a more involved solution,
which is no option for 4.6 anymore).

Regardless of this the plan for the future would be:
1) Send a patch to properly express the dependencies for the sunxi IRQ
controllers - this is independent from the arm64 support. I will do this
ASAP in hope that it still reaches 4.7.
2) Investigate whether Maxime's new sunxi clock architecture[2] would be
a fit for the A64 support.
3) Use the next weeks to rework the support patches and aim for a 4.8-rc
merge - depending on the outcome and merge status of 2)

Thoughts?

Cheers,
Andre.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/418175.html
   with the thread continuing here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/420326.html

[2]
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/427839.html
