From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 21 Aug 2014 10:42:37 +0200
Subject: [PATCH 1/3] ARM: zynq: DT: Fix Ethernet phy modes
In-Reply-To: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <9d406f69-6022-4e61-84df-20eee5d9cd1b@BL2FFO11FD024.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 05:56 PM, Soren Brinkmann wrote:
> The used PHYs should be qualified as 'rgmii-id' instead of just 'rgmii'.
> For the Zed board this seems to make a difference between working and
> broken Ethernet.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-zc702.dts | 2 +-
>  arch/arm/boot/dts/zynq-zc706.dts | 2 +-
>  arch/arm/boot/dts/zynq-zed.dts   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 835c3089c61c..30bcfe20f0bc 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -35,7 +35,7 @@
>  
>  &gem0 {
>  	status = "okay";
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  };
>  
>  &i2c0 {
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index 4cc9913078cd..3d9cb023e158 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -32,7 +32,7 @@
>  
>  &gem0 {
>  	status = "okay";
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  };
>  
>  &i2c0 {
> diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
> index 82d7ef1a9a9c..42deb1b7dbc8 100644
> --- a/arch/arm/boot/dts/zynq-zed.dts
> +++ b/arch/arm/boot/dts/zynq-zed.dts
> @@ -32,7 +32,7 @@
>  
>  &gem0 {
>  	status = "okay";
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  };
>  
>  &sdhci0 {
> 

Applied.

M


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/b67e637b/attachment.sig>
