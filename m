From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 14:12:46 -0600
Subject: [PATCH v4 01/11] drm/hisilicon: Add device tree binding for
 hi6220 display subsystem
In-Reply-To: <1454729098-79807-2-git-send-email-xinliang.liu@linaro.org>
References: <1454729098-79807-1-git-send-email-xinliang.liu@linaro.org>
 <1454729098-79807-2-git-send-email-xinliang.liu@linaro.org>
Message-ID: <20160208201246.GA17459@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2016 at 11:24:48AM +0800, Xinliang Liu wrote:
> Add ADE display controller binding doc.
> Add DesignWare DSI Host Controller v1.20a binding doc.

One comment, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> +Board specific:
> +	&dsi {
> +		status = "ok";
> +
> +		ports {
> +			/* 1 for output port */
> +			port at 1 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1>;
> +
> +				/* 0 for bridge, other value for panel */

The endpoint address would not change based on bridge or panel. So you 
can drop the unit address here.

> +				dsi_out0: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&adv7533_in>;
> +				};
> +			};
> +		};
> +	};
