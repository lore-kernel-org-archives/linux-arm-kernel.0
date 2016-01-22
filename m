From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jan 2016 21:39:27 +0100
Subject: [PATCH RFC 09/15] ARM: dts: sun6i: sina31s: Switch to mmc3 for
 onboard eMMC
In-Reply-To: <1453354002-28366-10-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-10-git-send-email-wens@csie.org>
Message-ID: <20160122203927.GC3682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 21, 2016 at 01:26:36PM +0800, Chen-Yu Tsai wrote:
> According to Allwinner, only mmc3 supports 8 bit DDR transfers for eMMC.
> Switch to mmc3 for the onboard eMMC, and also assign vqmmc for signal
> voltage sensing/switching, and "cap-mmc-hw-reset" to denote this
> instance can use eMMC hardware reset.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> index ea69fb8ad4d8..4ec0c8679b2e 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
> @@ -61,12 +61,14 @@
>  };
>  
>  /* eMMC on core board */
> -&mmc2 {
> +&mmc3 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
> +	pinctrl-0 = <&mmc3_8bit_emmc_pins>;
>  	vmmc-supply = <&reg_dcdc1>;
> +	vqmmc-supply = <&reg_dcdc1>;

That seems odd. IIRC the VCC was supposed to be fixed and VCCQ could
be either at 1.8 or 3V. Having the same regulator on both would make
VCCQ forced to 3.3V, which seems to go against your commit log.

What's the catch ? :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160122/29e9c238/attachment.sig>
