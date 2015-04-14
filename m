From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Apr 2015 13:50:47 +0200
Subject: [PATCH v7 1/4] ARM: sun7i: dt: Add Security System to A20 SoC DTS
In-Reply-To: <1429010461-9243-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1429010461-9243-1-git-send-email-clabbe.montjoie@gmail.com>
 <1429010461-9243-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150414115047.GB27280@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 14, 2015 at 01:20:58PM +0200, LABBE Corentin wrote:
> The Security System is a hardware cryptographic accelerator that support
> AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> It could be found on many Allwinner SoC.
> 
> This patch enable the Security System on the Allwinner A20 SoC Device-tree.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index fdd1817..27b5701 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -679,6 +679,14 @@
>  			status = "disabled";
>  		};
>  
> +		crypto: crypto-engine at 01c15000 {
> +			compatible = "allwinner,sun7i-a20-crypto";
> +			reg = <0x01c15000 0x1000>;
> +			interrupts = <0 86 4>;

Please use the GIC's define here.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150414/f78b632e/attachment.sig>
