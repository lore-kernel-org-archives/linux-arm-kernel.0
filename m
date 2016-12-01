From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Dec 2016 10:13:43 -0600
Subject: [PATCH 1/2] Documentation: sample averaging for imx6ul_tsc
In-Reply-To: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <20161201161343.g7p2maxiatp4m5di@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 09:44:57AM +0200, Guy Shapiro wrote:
> The i.MX6UL internal touchscreen controller contains an option to
> average upon samples. This feature reduces noise from the produced
> touch locations.
> 
> This patch introduces a new device tree optional property for this
> feature. It provides control over the amount of averaged samples per
> touch event.
> 
> The property was inspired by a similar property on the
> "brcm,iproc-touchscreen" binding.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> ---
>  .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> index 853dff9..a66069f 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
> @@ -17,6 +17,13 @@ Optional properties:
>    This value depends on the touch screen.
>  - pre-charge-time: the touch screen need some time to precharge.
>    This value depends on the touch screen.
> +- average-samples: Number of data samples which are averaged for each read.
> +	Valid values 0-4
> +	0 =  1 sample
> +	1 =  4 samples
> +	2 =  8 samples
> +	3 = 16 samples
> +	4 = 32 samples

Either this needs a vendor prefix or should be documented as a generic 
property. In the latter case, you should use actual number of samples 
(1-32) for the values.

>  
>  Example:
>  	tsc: tsc at 02040000 {
> @@ -32,5 +39,6 @@ Example:
>  		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
>  		measure-delay-time = <0xfff>;
>  		pre-charge-time = <0xffff>;
> +		average-samples = <4>;
>  		status = "okay";
>  	};
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
