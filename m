From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 14:45:26 +0100
Subject: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
In-Reply-To: <20140108133958.GA15182@katana>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <52CD4CBE.6010902@free-electrons.com> <20140108133958.GA15182@katana>
Message-ID: <3195222.U7OZJLz9Y4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 14:39:59 Wolfram Sang wrote:
> > >>>> However, when I first read this I thought it should be a -a0 specific
> > >>>> compatible string, not a 'offload-broken' property - any idea what the
> > >>>> DT consensus is here? I've seen both approach in use ..
> > >>>
> > >>> I prefer the replacement of the compatible string. If it should really
> > >>> be a seperate property, then it should be a vendor specific property. It
> > >>> is not generic, at all.
> > >>
> > >> Something like "marvell,offload-broken" would be acceptable?
> > > 
> > > A tad more, yes. Still, since this is a feature/quirk of the IP core
> > > revision, it should be deduced from the compatible property IMO. It
> > > cannot be configured anywhere, so it doesn't change on board level.
> > 
> > So you would prefer using the "marvell,mv78230-a0-i2c" comaptible string and
> > updating it with the follwing piece of code?
> 
> This is the approach I favour, yes. Can't say much about the
> implementation. Looks OK, but dunno if this is minimal...
> 

I would prefer the separate property in this case, but only because it's
easier to add in the quirk than to change the compatible string, but it's
not a strong preference and I don't mind getting overruled if you all
favor the alternative.

	Arnd
