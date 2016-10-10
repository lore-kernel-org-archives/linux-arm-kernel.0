From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Oct 2016 14:31:51 +0200
Subject: [PATCH v4 04/10] ARM: dts: sun8i-h3: Add dt node for the syscon
 control module
In-Reply-To: <1475828757-926-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
 <1475828757-926-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20161010123151.GI3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 07, 2016 at 10:25:51AM +0200, Corentin Labbe wrote:
> This patch add the dt node for the syscon register present on the
> Allwinner H3.
> 
> Only two register are present in this syscon and the only one useful is
> the one dedicated to EMAC clock.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 8a95e36..1101d2f 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -140,6 +140,11 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		syscon: syscon at 01c00000 {
> +			compatible = "syscon";

It would be great to have a more specific compatible here in addition
to the syscon, like "allwinner,sun8i-h3-system-controller".

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161010/11087e9d/attachment-0001.sig>
