From: green@linuxhacker.ru (Oleg Drokin)
Date: Wed, 27 Apr 2011 00:23:18 -0400
Subject: [PATCH 4/4] omap: musb: introduce default baord config
In-Reply-To: <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il>
	<c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il>
Message-ID: <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On Apr 24, 2011, at 6:09 PM, Mike Rapoport wrote:
> -void __init usb_musb_init(struct omap_musb_board_data *board_data)
> +static struct omap_musb_board_data musb_default_board_data = {
> +	.interface_type		= MUSB_INTERFACE_ULPI,
> +	.mode			= MUSB_OTG,

In fact can you make it more generic with ifdefs like this?
(since there are tons of boards taht are client only or would like to be compiled in some other way):

+#ifdef CONFIG_USB_MUSB_OTG
+       .mode                   = MUSB_OTG,
+#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
+       .mode                   = MUSB_HOST,
+#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
+       .mode                   = MUSB_PERIPHERAL,
+#endif

> +	.power			= 100,
> +};
> +

Thanks!

Bye,
    Oleg
