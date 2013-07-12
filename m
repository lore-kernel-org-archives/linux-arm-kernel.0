From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 12 Jul 2013 13:58:35 -0600
Subject: Sharing *.dtsi between Linux architectures?
Message-ID: <51E05FEB.1090308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there a (possibly just proposed) mechanism in place to allow *.dts
from multiple Linux architectures to share common *.dtsi files?

As an example, consider two SoCs that are identical except for the CPU
complex. One uses an ARMv7 CPU (DTs in arch/arm/boot/dts/) and the other
uses some ARMv8 CPU (DTs in arch/am64/boot/dts/). It'd be useful to
define all the SoC components in some common .dtsi file to avoid
duplication, and have both arch/arm/boot/dts/tegraXXX.dtsi and
arch/arm64/boot/dts/tegraYYY.dtsi include that and add the relevant
CPU-related nodes.

I could imagine creating one of the following paths for this purpose:

arch/common/dts/
include/dt-common/
include/dtsi/

... or perhaps re-using the existing:

include/dt-bindings/

... although my original intent for that last location was just to house
header files that define constants that are part of binding definitions,
rather than actual structural content.
