From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 13 Mar 2013 17:57:08 -0700 (PDT)
Subject: [PATCH 03/10] ARM: shmobile: r8a7779: add USB EHCI clock support
In-Reply-To: <5141156C.4010909@cogentembedded.com>
References: <1352446165-19298-1-git-send-email-horms@verge.net.au>
 <1352446165-19298-4-git-send-email-horms@verge.net.au>
 <5141156C.4010909@cogentembedded.com>
Message-ID: <87hake4x3y.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> >   	/* MSTP32 clocks */
> > +	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
> > +	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
> 
>     But how are those used? I don't see clk API support in ehci-platform.c.
> Are they used via runtime PM? I'm just not familiar enough with it...

Yes exactry

    - board-marzen.c :: usb_power_on()
    - clock-r8a7779.c :: mstp_clks[]

Best regards
---
Kuninori Morimoto
