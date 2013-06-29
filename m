From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 29 Jun 2013 09:05:29 +0200
Subject: [PATCHv3 5/8] ARM: mxs: dt: cfa10037: make hogpins grabbed by
 respective drivers
In-Reply-To: <1372424577-8279-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372424577-8279-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20130629070529.GD2593@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre

On Fri, Jun 28, 2013 at 03:02:54PM +0200, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
With one minor comment, that applies to your other patches as well.

> ---
>  arch/arm/boot/dts/imx28-cfa10037.dts | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
> index c2ef3a3..182b99f 100644
> --- a/arch/arm/boot/dts/imx28-cfa10037.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10037.dts
> @@ -22,13 +22,19 @@
>  	apb at 80000000 {
>  		apbh at 80000000 {
>  			pinctrl at 80018000 {
> -				pinctrl-names = "default", "default";
> -				pinctrl-1 = <&hog_pins_cfa10037>;

The pinctrl-name property isn't relevant since the 10036 patch. You
should probably have ordered them the other way around: first the
breakout board, then the 10036.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130629/8403a88c/attachment.sig>
