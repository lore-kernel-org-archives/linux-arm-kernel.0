From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 May 2015 09:31:14 +0200
Subject: [PATCH v9 1/4] ARM: sun7i: dt: Add Security System to A20 SoC DTS
In-Reply-To: <1431608341-10936-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150515073114.GO4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:58:58PM +0200, LABBE Corentin wrote:
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
> index fdd1817..9a823ce 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -679,6 +679,14 @@
>  			status = "disabled";
>  		};
>  
> +		crypto: crypto-engine at 01c15000 {
> +			compatible = "allwinner,sun4i-a20-crypto";

This looks wrong. It's either sun4i-a10 or sun7i-a20.

It looks good otherwise.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150515/e7197bdc/attachment.sig>
