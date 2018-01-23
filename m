From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Jan 2018 10:20:41 +0100
Subject: [GIT PULL] dts fixes for omaps for v4.16 merge window
In-Reply-To: <pull-1516642112-325806@atomide.com>
References: <pull-1516642112-325806@atomide.com>
Message-ID: <CAK8P3a145v7Ot7h082ARTDGREE1GbLySdriYN7C7v6afyZsVeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 6:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 1cadb0c341079785182a8d00d12ecb0bbef935fb:
>
>   Revert "ARM: dts: dra7: Add properties to enable PCIe x2 lane mode" (2017-12-23 08:18:15 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-pt3-signed
>
> for you to fetch changes up to 0e6e6dcce8d578516ef3aea2c9f9b4d0a0d53194:
>
>   ARM: dts: Nokia N9: add support for up/down keys in the dts (2018-01-19 07:40:13 -0800)
>
> ----------------------------------------------------------------
> Few omap dts fixes and n9 volume keys update for v4.16 merge window
>
> For now, we need to rely on dts alias for n900 lcd and tvout order
> to prevent occasional blank lcd. And we need to reduce the shut down
> temperature for dra7 for non-cpu thermal cases.
>
> And looks like we're missing the n9 volume key mappings and there is
> active work going happening for n9 at least for postmarketos. So let's
> make sure the keys can be actually used as they are the only buttons
> on n9 in addition to the power key.

Pulled into next/dt with a trivial conflict resolution. Thanks,

     Arnd

diff --cc arch/arm/boot/dts/dra7.dtsi
index 700080a948a3,b4ef814c556c..daa37a85dbf0
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@@ -2150,4 -2114,20 +2150,20 @@@
        temperature = <120000>; /* milli Celsius */
  };

 +#include "dra7xx-clocks.dtsi"
++
+ &core_crit {
+       temperature = <120000>; /* milli Celsius */
+ };
+
+ &gpu_crit {
+       temperature = <120000>; /* milli Celsius */
+ };
+
+ &dspeve_crit {
+       temperature = <120000>; /* milli Celsius */
+ };
+
+ &iva_crit {
+       temperature = <120000>; /* milli Celsius */
+ };
 -
 -/include/ "dra7xx-clocks.dtsi"
