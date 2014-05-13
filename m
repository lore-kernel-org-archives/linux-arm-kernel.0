From: pavel@denx.de (Pavel Machek)
Date: Tue, 13 May 2014 13:29:39 +0200
Subject: [PATCHv3] C_CAN: Add 32-bit accesses
In-Reply-To: <5370ED11.4000002@pengutronix.de>
References: <1398716449.836.4.camel@dinh-ubuntu>
 <20140428211505.GA28242@amd.pavel.ucw.cz>
 <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
 <20140506135702.GA9879@amd.pavel.ucw.cz>
 <5370ED11.4000002@pengutronix.de>
Message-ID: <20140513112939.GA8635@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Add helpers for 32-bit accesses and replace open-coded 32-bit access
> > with calls to helpers. Minimum changes are done to the pci case, as I
> > don't have access to that hardware.
> 
> I'll ask David Miller to merge net/master into net-next/master so that I
> can apply this patch.
> 
> For now, I've applied the patch to can-next testing-c_can
> (git://gitorious.org/linux-can/linux-can-next.git testing-c_can)
> 
> Can you make other patches based on that tree, please.

Yes, give me few minutes.

> > --- a/drivers/net/can/c_can/c_can_pci.c
> > +++ b/drivers/net/can/c_can/c_can_pci.c
> > +static void c_can_plat_write_reg32(struct c_can_priv *priv, enum reg index,
> > +		u32 val)
> > +{
> > +	priv->write_reg(priv, index + 1, val>>16);
> 
> spaces around >>, I'll fix this while applying.

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
