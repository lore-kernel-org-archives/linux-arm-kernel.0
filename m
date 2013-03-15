From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 14 Mar 2013 17:52:38 -0700 (PDT)
Subject: [PATCH 2/7] ARM: shmobile: marzen: add USB EHCI driver support
In-Reply-To: <5141D3C6.4090806@cogentembedded.com>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-3-git-send-email-horms@verge.net.au>
 <5140F35F.3090702@cogentembedded.com>
 <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
 <5141D3C6.4090806@cogentembedded.com>
Message-ID: <87boal32nh.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> > I forgot detail of it, but these usb is using callback function,
> > and it is using *phy*.
> 
>    But this PHY also belongs to SoC.
> 
> > This phy came from marzen_init_late() with usb_get_phy(USB_PHY_TYPE_USB2);
> > This usb_get_phy() is not needed if board doesn't have USB.
> 
>     Anyway, there should be ways to separate the board specific platform code 
> and the SoC specific one. That's what other subarches do.
>
> > You can modify it if you want
> 
>     Yes, I definitely would like to try.

I checked CPG :: MSTP for USB0/1/2 and USB Host/Function,
and GIC number for it.
It seems no conflict each other
I guess EHCI/OHCI goes to setup seems no problem.

But, as you pointed on USB ML,
USB-PHY :: USBPCTRL0 depends on platform
(Host/Function selection, and OVC pin setting)

rcar_usb_phy driver belongs to platform


Best regards
---
Kuninori Morimoto
