From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 10:40:01 +0200
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803B766FD@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334714869-19282-9-git-send-email-marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803B766FD@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120418084001.GN3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 07:01:07AM +0000, Chen Peter-B29397 wrote:
> 
> 
>  
> > 
> > This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I tried to
> > keep
> > this separate from the MXC EHCI to avoid further polution of the MXC EHCI,
> > though eventually these two might be merged.
> > 
> As mxc and mxs platforms use the same USB controller (chipidea's), I wonder if
> you can use ehci-mxc, or change name from ehci-mxc to ehci-imx?
> Sascha, what's your opinion?

Maybe better ehci-imx. I think it's a good idea to not use the ehci-mxc
glue code but instead write a mxs specific glue code with having in
mind that later we want to drop ehci-mxc and use ehci-imx for all imx
including mxs. This assumes the USB folks are ok with this, I don't
know.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
