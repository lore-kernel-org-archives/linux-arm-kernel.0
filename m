From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Aug 2013 21:26:07 +0200
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <20130805221631.f740b0d39de0e14e641f477c@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <201308042257.58707.arnd@arndb.de>
 <20130805221631.f740b0d39de0e14e641f477c@mail.ru>
Message-ID: <201308052126.08078.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013, Alexander Shiyan wrote:
> On Sun, 4 Aug 2013 22:57:58 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Handling them in the irqchip driver probably seemed like a logical solution
> > when the code was initially written, but if you move that access into the
> > device drivers, you can probably remove the irqchip driver entirely and just
> > use the generic irqchip implementation.
> 
> ioremap for a whole set of CPU registers is called from map_io, so ioremap
> returns already mapped address, that is, it's just converting physical to
> virtual addresses.

I see, that does make things better at least.

It would be nice to change the DT binding in some way so the register
ranges are non-overlapping, but I'm not going to insist if the other
reviewers are ok with the small inconsistency here.

Do you have any reason for not using the syscon driver for these
registers?

	Arnd
