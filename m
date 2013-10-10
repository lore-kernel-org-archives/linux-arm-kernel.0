From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 10 Oct 2013 13:18:05 +0900
Subject: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
In-Reply-To: <20131009182905.GY21581@sirena.org.uk>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380670860-17621-4-git-send-email-seanpaul@chromium.org>
 <CAAQKjZN_r-=-sj=Vb-o-KUS4ab5=cjCq1ni3VZeMeVc3NL=MMg@mail.gmail.com>
 <CAOw6vbLiJLLKn=gb1=j5TBeM0ijEK13+goG-=mw7MZTyNT1kpQ@mail.gmail.com>
 <CAAQKjZPwyKCpju4Ndd+MB_aN24-zA5xTHFsFsun2617h7YT6dw@mail.gmail.com>
 <CAOesGMgKastzdFHYQzyL8gxkBN=86wFZ4jbgP8BHxfkOuZvJxg@mail.gmail.com>
 <CAAQKjZMhovKLxNfnXnbF-6diM2zF1cWyi+xHGyL3v83vBh4p6g@mail.gmail.com>
 <20131009182905.GY21581@sirena.org.uk>
Message-ID: <05c701cec56f$b79eea50$26dcbef0$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, October 10, 2013 3:29 AM
> To: Inki Dae
> Cc: Olof Johansson; Sean Paul; devicetree at vger.kernel.org; linux-samsung-
> soc at vger.kernel.org; linux-doc at vger.kernel.org; linux-
> kernel at vger.kernel.org; DRI mailing list; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
> 
> On Fri, Oct 04, 2013 at 11:05:48AM +0900, Inki Dae wrote:
> > 2013/10/4 Olof Johansson <olof@lixom.net>:
> 
> > > "If PD_N is LOW, then the device is in Deep power-down completely,
> > > even if supply rail is ON; for the device to be able to operate, the
> > > PD_N pin must be HIGH."
> 
> > I still think the pin could be replaced with a regulator. But
> > lvds-bridge node has "powerdown-gpio" property - it say this board
> > will use gpio pin - specific to board.  So it seems no problem.
> 
> No, don't model things that aren't regulators as regulators - it's just
> confusing from a usability standpoint and causes breakage when the pins
> don't behave like regulators.

It seems that there was your missing point. That _is not_ what I mentioned.
I mean that other boards can use a regulator instead of gpio pin.
