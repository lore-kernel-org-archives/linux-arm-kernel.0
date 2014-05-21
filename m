From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 15:44:54 +0300
Subject: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
In-Reply-To: <20140513213205.GB18001@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com>
 <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com>
Message-ID: <537C9FC6.8020104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/14 00:32, Tony Lindgren wrote:

> +&dss {
> +	status = "ok";
> +	vdds_dsi-supply = <&vpll2>;
> +	port {
> +		dpi_out: endpoint {
> +			remote-endpoint = <&lcd_in>;
> +			data-lines = <18>;
> +		};
> +	};
> +};

I just noticed the vdds_dsi-supply there. While the driver currently
uses that if available, I think it should be removed, and done the same
way Florian did with his overo patches:

/* Needed to power the DPI pins */
&vpll2 {
	regulator-always-on;
};

That supply is not DSS's supply, but it's used to power up the pins. If
the pins were used as GPIOs, that power should be enabled.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/611db154/attachment.sig>
