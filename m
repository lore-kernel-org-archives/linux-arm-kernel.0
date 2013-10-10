From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 10 Oct 2013 20:40:38 +0900
Subject: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
In-Reply-To: <20131010093708.GC21581@sirena.org.uk>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380670860-17621-4-git-send-email-seanpaul@chromium.org>
 <CAAQKjZN_r-=-sj=Vb-o-KUS4ab5=cjCq1ni3VZeMeVc3NL=MMg@mail.gmail.com>
 <CAOw6vbLiJLLKn=gb1=j5TBeM0ijEK13+goG-=mw7MZTyNT1kpQ@mail.gmail.com>
 <CAAQKjZPwyKCpju4Ndd+MB_aN24-zA5xTHFsFsun2617h7YT6dw@mail.gmail.com>
 <CAOesGMgKastzdFHYQzyL8gxkBN=86wFZ4jbgP8BHxfkOuZvJxg@mail.gmail.com>
 <CAAQKjZMhovKLxNfnXnbF-6diM2zF1cWyi+xHGyL3v83vBh4p6g@mail.gmail.com>
 <20131009182905.GY21581@sirena.org.uk>
 <05c701cec56f$b79eea50$26dcbef0$%dae@samsung.com>
 <20131010093708.GC21581@sirena.org.uk>
Message-ID: <063a01cec5ad$8afd1920$a0f74b60$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, October 10, 2013 6:37 PM
> To: Inki Dae
> Cc: 'Olof Johansson'; 'Sean Paul'; devicetree at vger.kernel.org; linux-
> samsung-soc at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> kernel at vger.kernel.org; 'DRI mailing list'; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
> 
> On Thu, Oct 10, 2013 at 01:18:05PM +0900, Inki Dae wrote:
> 
> > > > I still think the pin could be replaced with a regulator. But
> > > > lvds-bridge node has "powerdown-gpio" property - it say this board
> > > > will use gpio pin - specific to board.  So it seems no problem.
> 
> > > No, don't model things that aren't regulators as regulators - it's
> > > just confusing from a usability standpoint and causes breakage when
> > > the pins don't behave like regulators.
> 
> > It seems that there was your missing point. That _is not_ what I
> mentioned.
> > I mean that other boards can use a regulator instead of gpio pin.
> 
> What I'm saying is no boards should use a regulator to control that GPIO
> pin, obviously if they're controlling the actual regulators that's fine

That is what I mentioned. Some boards _could control_ the actual regulator
for lvds-bridge, and that would be depended on how HW engineer designs the
board. 

> but the reset signal should not be controlled via the regulator API (there
> are some unfortunate cases where people have done that already but let's
> not have any more).
