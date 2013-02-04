From: davem@davemloft.net (David Miller)
Date: Mon, 04 Feb 2013 13:09:51 -0500 (EST)
Subject: [PATCH v3 2/2] drivers: net:ethernet: cpsw: add support for VLAN
In-Reply-To: <1359659000-25995-3-git-send-email-mugunthanvnm@ti.com>
References: <1359659000-25995-1-git-send-email-mugunthanvnm@ti.com>
 <1359659000-25995-3-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20130204.130951.535741806527607249.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Fri, 1 Feb 2013 00:33:20 +0530

> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> index 6ddd028..99696bf 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -24,6 +24,8 @@ Required properties:
>  Optional properties:
>  - ti,hwmods		: Must be "cpgmac0"
>  - no_bd_ram		: Must be 0 or 1
> +- default_vlan		: Specifies Default VLAN for non tagged packets
> +			  ALE processing
>  
>  Note: "ti,hwmods" field is used to fetch the base address and irq
>  resources from TI, omap hwmod data base during device registration.

You guys have to get away from this idea that you can basically pepper
devicetree bindings with all sorts of random behavioral knobs like
this, it's terrible.

Make this an ethtool configurable entity or similar, and don't even
think about adding a module parameter.
