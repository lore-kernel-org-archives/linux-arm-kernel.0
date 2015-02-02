From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Feb 2015 11:03:57 +0000
Subject: [PATCH] ARM: shmobile: silk: initial device tree
In-Reply-To: <20150202001910.GA29383@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1608366.HtA9yBksdO@wasted.cogentembedded.com>
 <20150131042143.GB7605@verge.net.au>
 <54CD1E79.6090700@cogentembedded.com>
 <20150202001910.GA29383@verge.net.au>
Message-ID: <20150202110356.GB7459@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 12:19:12AM +0000, Simon Horman wrote:
> Hi Sergei,
> 
> On Sat, Jan 31, 2015 at 09:27:05PM +0300, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 1/31/2015 7:21 AM, Simon Horman wrote:
> > 
> > >>Add the initial device tree for the R8A7794 SoC based SILK low cost board.
> > >>SCIF2 serial port support is included, so that the serial console can work.
> > 
> > >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > >>---
> > >>This patch is against the 'renesas-devel-20150129-v3.19-rc6' tag of Simon
> > >>Horman's 'renesas.git' repo.
> > 
> > >>  arch/arm/boot/dts/Makefile         |    1
> > >>  arch/arm/boot/dts/r8a7794-silk.dts |   41 +++++++++++++++++++++++++++++++++++++
> > >>  2 files changed, 42 insertions(+)
> > 
> > [...]
> > >>Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
> > >>===================================================================
> > >>--- /dev/null
> > >>+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
> > >>@@ -0,0 +1,41 @@
> > >>+/*
> > >>+ * Device Tree Source for the SILK board
> > >>+ *
> > >>+ * Copyright (C) 2014 Renesas Electronics Corporation
> > >>+ * Copyright (C) 2014-2015 Renesas Solutions Corp.
> > >>+ * Copyright (C) 2014-2015 Cogent Embedded, Inc.
> > >>+ *
> > >>+ * This file is licensed under the terms of the GNU General Public License
> > >>+ * version 2.  This program is licensed "as is" without any warranty of any
> > >>+ * kind, whether express or implied.
> > >>+ */
> > >>+
> > >>+/dts-v1/;
> > >>+#include "r8a7794.dtsi"
> > >>+
> > >>+/ {
> > >>+	model = "SILK";
> > >>+	compatible = "renesas,silk", "renesas,r8a7794";
> > >>+
> > >>+	aliases {
> > >>+		serial0 = &scif2;
> > >>+	};
> > >>+
> > >>+	chosen {
> > >>+		bootargs = "console=ttySC0,38400 ignore_loglevel";
> > 
> > >Please remove console= for consistency with other boards
> > >based on Renesas SoCs.
> > 
> >    I can't, there will be no console at all.
> 
> Its not clear to me why that should be the case when you also have:
> 
> 		stdout-path = &scif2;
> 
> Is this a baud issue? If so is it possible to set uboot to 115200 bps?
> This would be consistent with the way other boards are handled in mainline.

If it's not possible to update the bootloader, the other option is to
use the console parametuers in stdout-path, e.g.

	stdout-path = "serial0:38400n8";

That way all the console stuff should get set up as expected without a
command line being required. As far as I am aware, an explicit command
line should then override this if necessary.

Mark.
