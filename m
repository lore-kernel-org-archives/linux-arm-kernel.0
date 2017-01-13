From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Jan 2017 15:04:59 +0100
Subject: [PATCH net-next v2 08/10] net: dsa: Add support for platform data
In-Reply-To: <20170112034121.27697-9-f.fainelli@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
 <20170112034121.27697-9-f.fainelli@gmail.com>
Message-ID: <20170113140459.GH10203@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> index cd91070b5467..d326fc4afad7 100644
> --- a/net/dsa/dsa2.c
> +++ b/net/dsa/dsa2.c
> @@ -81,17 +81,23 @@ static void dsa_dst_del_ds(struct dsa_switch_tree *dst,
>  
>  static bool dsa_port_is_valid(struct dsa_port *port)
>  {
> -	return !!port->dn;
> +	return !!(port->dn || port->name);
>  }
  
Does this clash with Viviens recent change to make names optional and
have the kernel assign it?

I suppose you could use an name of "eth%d"? Is it worth adding a
comment to the platform data structure?

	Andrew
