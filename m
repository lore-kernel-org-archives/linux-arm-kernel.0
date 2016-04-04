From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Apr 2016 00:16:50 -0500
Subject: [PATCH v2 13/16] arm64: dts: add LED nodes for hi6220-hikey
In-Reply-To: <1459589383-16914-14-git-send-email-guodong.xu@linaro.org>
References: <1459589383-16914-1-git-send-email-guodong.xu@linaro.org>
 <1459589383-16914-14-git-send-email-guodong.xu@linaro.org>
Message-ID: <20160404051650.GT17806@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2016 at 05:29:40PM +0800, Guodong Xu wrote:
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index c4f560a..28bc646 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -63,6 +63,47 @@
>  			status = "ok";
>  		};
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		user_led4 {

Don't use underscores in node names: user-led4

> +			label = "user_led4";

We need to make sure the node names and labels are aligned with other 
boards. There's some discussion about this for the new db600 board.

This looks closer to what we should have than what we have for 
db410c currently.

Rob
