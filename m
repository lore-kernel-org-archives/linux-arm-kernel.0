From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Sep 2016 09:28:12 +0200
Subject: [PATCH v3 4/9] ARM: dts: sun8i-h3: Add dt node for the syscon
 control module
In-Reply-To: <1473425117-18645-5-git-send-email-clabbe.montjoie@gmail.com>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-5-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160912072812.GB9449@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 02:45:12PM +0200, Corentin Labbe wrote:
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
> index fdf9fdb..a39da6f 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -140,6 +140,11 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		syscon: syscon at 01c00000 {
> +			compatible = "syscon";

Having our compatible would be nice here. syscon doesn't mean anything
by itself.

> +			reg = <0x01c00000 0x34>;

And the size of our system controller is 0x1000

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160912/b888ced4/attachment.sig>
