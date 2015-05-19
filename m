From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue, 19 May 2015 08:50:14 -0700
Subject: [PATCH V2 0/2] ARM: dts: use simple-panel for nitrogen6x and sabrelite
In-Reply-To: <20150518075844.7e1b5916@ipc1.ka-ro>
References: <20150518075844.7e1b5916@ipc1.ka-ro>
Message-ID: <1432050616-11465-1-git-send-email-eric.nelson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch originated with informal submission by Philipp Zabel:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/337115.html

Update the LVDS0 configuration for imx6qdl-nitrogen6x and imx6qdl-sabrelite
to use simple panel to allow the connection of backlights and simplify the
process of (re)configuring displays.

A U-Boot script to configure the displays based on detection of the
touch controller is available for reference here:

	https://github.com/boundarydevices/u-boot-imx6/blob/staging/board/boundary/nitrogen6x/6x_bootscript-mainline.txt

Addition of panel hannstar,hsd100pxn1 is queued for 4.2:
	https://patchwork.kernel.org/patch/6212451/

Eric Nelson (2):
  ARM: dts: nitrogen6x: use simple-panel instead of display-timings for
    LVDS0
  ARM: dts: sabrelite: use simple-panel instead of display-timings for
    LVDS0

V2 changes commit messages to use proper name of 'label' instead of 'alias'

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 30 +++++++++++++++++-------------
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 30 +++++++++++++++++-------------
 2 files changed, 34 insertions(+), 26 deletions(-)

-- 
2.1.4
