From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Jul 2014 15:01:04 +0800
Subject: [PATCH V2] ARM: dts: Restructure imx6qdl-wandboard.dtsi for new
 rev C1 board.
In-Reply-To: <1404845297-13751-1-git-send-email-george.joseph@fairview5.com>
References: <1404845297-13751-1-git-send-email-george.joseph@fairview5.com>
Message-ID: <20140710070103.GA2542@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 12:48:16PM -0600, George Joseph wrote:
> The rev C1 Wandboard uses the Broadcom 4330 for WiFi and Bluetooth instead of
> the 4329.  This changes the PADS assigned for the control lines.  Another
> side effect of the change is that on the rev C1 board, usdhc driver can't
> detect the chip presence correctly so usdhc2 now needs its 'non-removeable'
> property removed.
> 
> So that rev B1 and earlier can continue to work, this patch splits the
> board-specific definitions from imx6qdl-wandboard.dtsi into
> imx6qdl-wandboard-revb1.dtsi and imx6qdl-wandboard-revc1.dtsi.  The new files
> include the original base imx6qdl-wandboard.dtsi which retains the common
> definitions.
> 
> The existing imx6dl-wandboard.dts includes imx6qdl-wandboard-revc1.dtsi and
> imx6dl-wandboard-revb1.dts (new) includes imx6qdl-wandboard-revb1.dtsi.
> This makes the rev C1 board the new default.  The same pattern is used for
> imx6q-wandboard.dts.
> 
> So, from U-Boot on a WB-Quad you use imxq-wandboard-revb1.dtb for the older B1
> board and imxq-wandboard.dtb for the current rev C1 board.
> 
> Signed-off-by: George Joseph <george.joseph@fairview5.com>
> ---
>  arch/arm/boot/dts/imx6dl-wandboard-revb1.dts   | 22 ++++++++++++++
>  arch/arm/boot/dts/imx6dl-wandboard.dts         |  2 +-
>  arch/arm/boot/dts/imx6q-wandboard-revb1.dts    | 26 ++++++++++++++++
>  arch/arm/boot/dts/imx6q-wandboard.dts          |  2 +-
>  arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi | 42 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi | 41 +++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-wandboard.dtsi       | 21 -------------
>  7 files changed, 133 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-wandboard-revb1.dts

These two should be added into arch/arm/boot/dts/Makefile as build
target.

I fixed it up and applied the patch.

Shawn
