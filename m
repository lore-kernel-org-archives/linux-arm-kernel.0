From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 12:45:20 +0200
Subject: [PATCH 5/6] arm64, defconfig: Enable PCI
In-Reply-To: <20140925093545.GE10390@e104818-lin.cambridge.arm.com>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <3120493.DIoQFCi5Am@wuerfel>
 <20140925093545.GE10390@e104818-lin.cambridge.arm.com>
Message-ID: <21218217.YUcdQIZ4A8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 10:35:45 Catalin Marinas wrote:
> On Wed, Sep 24, 2014 at 07:40:18PM +0100, Arnd Bergmann wrote:
> > On Wednesday 24 September 2014 18:10:48 Catalin Marinas wrote:
> > > > The intention is not to have a second definition, instead this should
> > > > enable the default value just for arm64. Thus I put it to
> > > > arch/arm64/Kconfig. Otherwise it would be enabled per default on all
> > > > archs.
> > 
> > I don't think other architectures actually see the PCI symbol that is
> > defined in the arm64 Kconfig file, but I might be wrong.
> 
> Other archs wouldn't see the symbols in arch/arm64/Kconfig.

Ok.

> > > > We could have used select in config ARM64, but I tried to avoid using
> > > > select due to the dependency issue and instead implement this with
> > > > default-y/depends-on. Doing so it can be manually disabled too.
> > 
> > How about adding a new symbol like
> > 
> > config ARM64_PCI
> >       def_bool PCI
> >       select PCI_MSI
> 
> How is this different from just selecting PCI_MSI in config PCI in
> arch/arm64/Kconfig? I don't see what another symbol brings.

That suggestion was just in case I was wrong above. If the symbol
is indeed hidden elsewhere, we don't need it.

	Arnd
