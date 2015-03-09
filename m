From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 09 Mar 2015 17:19:20 +0900
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
In-Reply-To: <20150309084418.227b3e16@amdc2363>
References: <54F4B33E.3070803@kernel.org> <2064108.qlOP0oDx90@wuerfel>
 <02cd01d057f6$ab1a8e40$014faac0$@kernel.org>
 <20150305123358.GC25728@developer.hsd1.ca.comcast.net>
 <20150309084418.227b3e16@amdc2363>
Message-ID: <076f01d05a41$be568660$3b039320$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lukasz Majewski wrote:
> 
> Hi Eduardo,
> 
> > On Fri, Mar 06, 2015 at 07:16:53PM +0900, Kukjin Kim wrote:
> > > Arnd Bergmann wrote:
> > > >
> > > + Eduardo
> > >
> > > Hi Arnd,
> > >
> > > > On Tuesday 03 March 2015 04:00:14 Kukjin Kim wrote:
> > > > > Please pull Samsung tmu and hdmi regression fixes for v4.0 and
> > > > > I know this is quite big for fixes but I couldn't handle this
> > > > > series for previous merge window because of dependency with
> > > > > driver side...sorry for that and please pull so that we could
> > > > > support them in v4.0 on exynos platforms.
> > > >
> > > > What kind of dependency do you have there? It really should not be
> > > > necessary to wait for driver changes, unless you do an
> > > > incompatible DT binding change, which you should avoid.
> > > >
> > > For TMU patches, I've asked Eduardo to provide topic branch for
> > > 'include/dt-bindings/thermal/thermal_exynos.h' has been added via
> > > thermal tree because if I can't apply the patch in Samsung tree for
> > > arm-soc, kernel build breakage will be happened. But I couldn't get
> > > Eduardo's topic branch.
> >
> >
> > Specifically, the developer, while migrating the driver to support DT
> > and OF thermal, decided to create a header with constants. The header
> > is used by DT files and the driver code. The header was the
> > dependency.
> 
> Just my 2 cents :-).
> 
> The above situation is the justification for adding the whole patch set
> to one repository when all ACKs are collected for it.
> 
I don't think so, even your series can be upstreamed though, other useless
merge conflicts would be happened so we decided all of DT should be handled
in arch side not driver side. So please don't argue about that.

- Kukjin
