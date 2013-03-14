From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 13 Mar 2013 18:09:55 -0700 (PDT)
Subject: [PATCH 2/7] ARM: shmobile: marzen: add USB EHCI driver support
In-Reply-To: <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-3-git-send-email-horms@verge.net.au>
 <5140F35F.3090702@cogentembedded.com>
 <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87fvzy4win.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> >     Morimoto-san, I don't understand why this SoC specific platform device
> > ended up in the board file? Could you explain your reasons please?
> >     I think this is generally a bad practice as this approach scales badly.
> 
> Do you mean it should exist in setup-r8a7779.c ?
> 
> I forgot detail of it, but these usb is using callback function,
> and it is using *phy*.
> This phy came from marzen_init_late() with usb_get_phy(USB_PHY_TYPE_USB2);
> This usb_get_phy() is not needed if board doesn't have USB.
> 
> You can modify it if you want

And, as you pointed in USB ML,
This rcar_usb_phy driver will need board specific initialization.
(it is not implemented at this point...)


Best regards
---
Kuninori Morimoto
