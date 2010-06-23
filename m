From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Jun 2010 08:59:14 +0200
Subject: [PATCH V2 1/2] mxc: add common debug board for 3-stack platforms
In-Reply-To: <1277216851-15782-2-git-send-email-jason77.wang@gmail.com>
References: <1277216851-15782-1-git-send-email-jason77.wang@gmail.com>
	<1277216851-15782-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <20100623065914.GO12115@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 22, 2010 at 10:27:30PM +0800, Jason Wang wrote:
> The debug board is little different for all mxc 3-stack(PDK)
> platforms, it is possible here to add a common implementation to
> support this board.
> 
> +
> +void __init mxc_expio_lan_init(void)
> +{
> +	platform_device_register(&smsc_lan9217_device);
> +}

What do we need this for? Can't we just call this from
mxc_expio_init()?


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
