From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jun 2012 21:08:34 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <CAErSpo5dj99iHW0WNEABPR1OO2yS=BwNezOivu6_7Go8sKyjsQ@mail.gmail.com>
References: <4FDA2DDA.1030704@wwwdotorg.org> <201206221653.31817.arnd@arndb.de>
 <CAErSpo5dj99iHW0WNEABPR1OO2yS=BwNezOivu6_7Go8sKyjsQ@mail.gmail.com>
Message-ID: <201206222108.35094.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 June 2012, Bjorn Helgaas wrote:
> 
> On Fri, Jun 22, 2012 at 10:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 22 June 2012, Bjorn Helgaas wrote:
> >> The requirement (if there is one) isn't anything related to PC-ness.
> >> I just don't understand how things can actually work if two host
> >> bridges both claim the same bus number.  If we do a config read to
> >> that bus, both bridges should claim it and turn it into config cycles
> >> on their respective root buses, and we should get two responses.  I
> >> would expect the second response to cause an "unexpected response"
> >> machine check or similar.
> >
> > But each PCI domain has its own config space, so if you do a config
> > read for one bus, it's always relative to the domain.
> 
> Oh, I see!  I totally missed the fact that each host bridge was in its
> own domain.  If each has its own domain, then the bus number aperture
> can certainly be [bus 00-ff] and there's no problem.

Right. On my side, it took me a while to figure out that you can
actually have multiple root ports in one domain ;-)

	Arnd
