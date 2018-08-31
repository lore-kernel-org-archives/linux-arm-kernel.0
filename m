From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Aug 2018 16:18:51 +0200
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180831133651.GB32574@kwain>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
Message-ID: <20180831141851.GA19733@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -4691,6 +4685,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
>  		port->flags |= MVPP2_F_LOOPBACK;
>  
> +	if (fwnode_property_present(port_fwnode, "fixed-link"))
> +		port->flags |= MVPP2_F_FIXED_LINK;
> +

Hi Antoine

There is no need to go look in device tree. When phylink calls
mac_config() it passes mode == MLO_AN_FIXED, when it is using a fixed
link.

	Andrew
