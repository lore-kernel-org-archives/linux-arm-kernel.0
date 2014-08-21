From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 21 Aug 2014 10:41:39 +0200
Subject: [PATCH 3/3] ARM: zynq: DT: Add Ethernet phys
In-Reply-To: <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
 <1408550219-19825-3-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5a7b6f57-b6c0-4fb3-af0d-d403277c0207@BN1AFFO11FD045.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2014 05:56 PM, Soren Brinkmann wrote:
> Add missing Ethernet phys to Zynq DTs.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  arch/arm/boot/dts/zynq-zc702.dts | 6 ++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 6 ++++++
>  arch/arm/boot/dts/zynq-zed.dts   | 6 ++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 30bcfe20f0bc..fa810505ab8f 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -36,6 +36,12 @@
>  &gem0 {
>  	status = "okay";
>  	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +
> +	ethernet_phy: ethernet-phy at 7 {
> +		compatible = "marvell,88e1116r", "ethernet-phy-ieee802.3-c22";

c22 is completely unused by the kernel and also c22 is default option anyway.
Any advantage to have c22 specified here?

Thanks,
Michal

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/ab428838/attachment.sig>
