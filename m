From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 01 Apr 2013 17:27:13 -0700 (PDT)
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
Message-ID: <87wqsl6ale.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei again

> +void __init r8a7779_add_ether_device(void *pdata)
> +{
> +	ether_device.dev.platform_data = pdata;
> +
> +	platform_device_register(&ether_device);
> +}

We didn't use this style of registration before,
but, it is OK.
Then, this (void *pdata) should be
(struct sh_eth_plat_data *pdata) IMO

Best regards
---
Kuninori Morimoto
