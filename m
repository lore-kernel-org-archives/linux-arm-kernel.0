From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 13 Mar 2013 17:44:10 -0700 (PDT)
Subject: [PATCH 1/7] ARM: shmobile: marzen: add USB phy support
In-Reply-To: <5140FBB1.50401@mvista.com>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-2-git-send-email-horms@verge.net.au>
 <5140FBB1.50401@mvista.com>
Message-ID: <87k3pa4xpk.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> > +/* USB PHY */
> > +static struct resource usb_phy_resources[] = {
> > +	[0] = {
> > +		.start		= 0xffe70000,
> 
>     Why not 0xffe70800? 0xffe70000 is where the EHCI registers start.
> I don't see why they should be overlapped like this.

Current rcar-phy try to access 0xffe7009x

> > +	[1] = {
> > +		.start		= 0xfff70000,
> > +		.end		= 0xfff70900 - 1,
> 
>     Hm, this PHY register range doesn't seem to be documented?

0xffe70000 is for port0/1
0xfff70000 is for port2

But this 0xfff70000 is only for 0xfff7009x access

Best regards
---
Kuninori Morimoto
