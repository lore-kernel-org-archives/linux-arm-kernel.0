From: joe@perches.com (Joe Perches)
Date: Fri, 28 Sep 2018 14:50:59 -0700
Subject: Bad MAINTAINERS pattern in section 'ARM/ACTIONS SEMI ARCHITECTURE'
Message-ID: <20180928215059.28636-1-joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	1185	ARM/ACTIONS SEMI ARCHITECTURE
	1186	M:	Andreas F?rber <afaerber@suse.de>
	1187	R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
	1188	L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
	1189	S:	Maintained
	1190	N:	owl
	1191	F:	arch/arm/mach-actions/
	1192	F:	arch/arm/boot/dts/owl-*
	1193	F:	arch/arm64/boot/dts/actions/
	1194	F:	drivers/clk/actions/
	1195	F:	drivers/clocksource/owl-*
	1196	F:	drivers/pinctrl/actions/*
	1197	F:	drivers/soc/actions/
	1198	F:	include/dt-bindings/power/owl-*
	1199	F:	include/linux/soc/actions/
	1200	F:	Documentation/devicetree/bindings/arm/actions.txt
-->	1201	F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
	1202	F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
	1203	F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
	1204	F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt

Commit that introduced this:

commit 81aa283c692401ce82795fb0da68ead413055360
 Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 Date:   Thu May 31 15:17:34 2018 +0530
 
     MAINTAINERS: Add Actions Semi S900 clk entries
     
     Add S900 clk entries under ARCH_ACTIONS.
     
     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
     Acked-by: Stephen Boyd <sboyd@kernel.org>
     Signed-off-by: Andreas F?rber <afaerber@suse.de>
 
  MAINTAINERS | 2 ++
  1 file changed, 2 insertions(+)

Last commit with Documentation/devicetree/bindings/clock/actions,s900-cmu.txt

commit d0e45d686a3ef18a20d4eac6675b76d3656c4727
Author: Saravanan Sekar <sravanhome@gmail.com>
Date:   Thu Jul 19 11:06:46 2018 +0200

    dt-bindings: clock: Add S700 support for Actions Semi Soc's
    
    Add clock bindings constants for action S700
    Maintain common clock dt-bindings for Actions Semi SoC's
    S700 and S900.
    
    Signed-off-by: Parthiban Nallathambi <pn@denx.de>
    Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Stephen Boyd <sboyd@kernel.org>

 .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |  20 ++--
 include/dt-bindings/clock/actions,s700-cmu.h       | 118 +++++++++++++++++++++
 2 files changed, 129 insertions(+), 9 deletions(-)
