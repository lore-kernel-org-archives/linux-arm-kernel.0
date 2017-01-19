From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Jan 2017 15:13:35 +0100
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 12:02:46PM -0200, Fabio Estevam wrote:
> Commit 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi") causes boot
> issues when the bootloader does not create a 'chosen' node if such node
> is not present in the dtb.
> 
> The reason for the boot failure is well explained by Javier Martinez
> Canillas: "the decompressor relies on a pre-existing chosen node to be
> available to insert the command line and merge other ATAGS info."
> 
> , so pass an empty 'chosen' node to fix the boot problem.
> 
> This issue has been seen in the kernelci reports with Barebox as
> bootloader.
> 
> Also pass the 'memory' node in order to fix boot issues on the SolidRun
> iMX6 platforms.
> 
> Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Also pass the memory node.
> 
>  arch/arm/boot/dts/imx1.dtsi    | 2 ++
>  arch/arm/boot/dts/imx23.dtsi   | 2 ++
>  arch/arm/boot/dts/imx25.dtsi   | 2 ++
>  arch/arm/boot/dts/imx27.dtsi   | 2 ++
>  arch/arm/boot/dts/imx28.dtsi   | 2 ++
>  arch/arm/boot/dts/imx31.dtsi   | 2 ++
>  arch/arm/boot/dts/imx35.dtsi   | 2 ++
>  arch/arm/boot/dts/imx50.dtsi   | 2 ++
>  arch/arm/boot/dts/imx51.dtsi   | 2 ++
>  arch/arm/boot/dts/imx53.dtsi   | 2 ++
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
>  arch/arm/boot/dts/imx6sl.dtsi  | 2 ++
>  arch/arm/boot/dts/imx6sx.dtsi  | 2 ++
>  arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
>  arch/arm/boot/dts/imx7s.dtsi   | 2 ++
>  15 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
> index dd3de38..7ef0d36 100644
> --- a/arch/arm/boot/dts/imx1.dtsi
> +++ b/arch/arm/boot/dts/imx1.dtsi
> @@ -18,6 +18,8 @@
>  / {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> +	chosen {};
> +	memory { device_type = "memory"; reg = <0 0>; };

Would it be nice to add a comment about why this was added? Something to
prevent a cleanup like "remove empty nodes and invalid memory
configurations".

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
