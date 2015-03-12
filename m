From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 12 Mar 2015 20:15:28 +0900
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
In-Reply-To: <20150305123358.GC25728@developer.hsd1.ca.comcast.net>
References: <54F4B33E.3070803@kernel.org> <2064108.qlOP0oDx90@wuerfel>
 <02cd01d057f6$ab1a8e40$014faac0$@kernel.org>
 <20150305123358.GC25728@developer.hsd1.ca.comcast.net>
Message-ID: <025d01d05cb5$d8c6d650$8a5482f0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eduardo Valentin wrote:
> 
Hi Eduardo,

> On Fri, Mar 06, 2015 at 07:16:53PM +0900, Kukjin Kim wrote:
> > Arnd Bergmann wrote:
> > >
> > + Eduardo
> >
> > Hi Arnd,
> >
> > > On Tuesday 03 March 2015 04:00:14 Kukjin Kim wrote:
> > > > Please pull Samsung tmu and hdmi regression fixes for v4.0 and I know
> > > > this is quite big for fixes but I couldn't handle this series for
> > > > previous merge window because of dependency with driver side...sorry for
> > > > that and please pull so that we could support them in v4.0 on exynos
> > > > platforms.
> > >
> > > What kind of dependency do you have there? It really should not be
> > > necessary to wait for driver changes, unless you do an incompatible
> > > DT binding change, which you should avoid.
> > >
> > For TMU patches, I've asked Eduardo to provide topic branch for
> > 'include/dt-bindings/thermal/thermal_exynos.h' has been added via thermal tree
> > because if I can't apply the patch in Samsung tree for arm-soc, kernel build
> > breakage will be happened. But I couldn't get Eduardo's topic branch.
> 
> 
> Specifically, the developer, while migrating the driver to support DT
> and OF thermal, decided to create a header with constants. The header is
> used by DT files and the driver code. The header was the dependency.
> 
Yes, sometimes we can't avoid the situation so it can be a kind of dependency...


Arnd,
Do you have any updates on this?

Thanks,
Kukjin

> 
> BR,
> 
> Eduardo Valentin
> 
> >
> > http://www.spinics.net/lists/linux-samsung-soc/msg41877.html
> >
> >
> > For HDMI patches, I thought the DT changes have a dependency with "drm/exynos:
> > add support for 'hdmi' clock" so waited for its applying then in drm tree. But
> > I couldn't send it to arm-soc after that...
> >
> > http://www.spinics.net/lists/linux-samsung-soc/msg42173.html
> >
> >
> > I asked about the situation (late DT changes?) when I sent a pull-request, then
> > I couldn't get a access my kernel.org because of biz. trip to China :(
> >
> > http://www.spinics.net/lists/linux-samsung-soc/msg42235.html
> >
> >
> > > I've pulled it into fixes, but won't forward it until I hear a
> > > good explanation.
> > >
> > As you know, basically I tried to make a clear branch for pull-request but in
> > that case, I couldn't find a solution. Sorry for the inconvenience.
> >
> > I hope v4.0 can support them properly.
> >
> > Thanks,
> > Kukjin
