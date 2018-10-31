From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 1 Nov 2018 00:33:04 +0900
Subject: [PATCH 5/9] powerpc: PCI_MSI needs PCI
In-Reply-To: <20181019151019.GA5618@localhost>
References: <20181019120952.32763-1-hch@lst.de>
 <20181019120952.32763-6-hch@lst.de>
 <20181019151019.GA5618@localhost>
Message-ID: <CAK7LNARa7xqG1iyQb9PE271L8QTC7nsaVXSAofm0hzku8T5Xvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2018 at 12:10 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> On Fri, Oct 19, 2018 at 02:09:48PM +0200, Christoph Hellwig wrote:
> > Various powerpc boards select the PCI_MSI config option without selecting
> > PCI, resulting in potentially not compilable configurations if the by
> > default enabled PCI option is disabled.  Explicitly select PCI to ensure
> > we always have valid configs.
> [...]
> > --- a/arch/powerpc/platforms/44x/Kconfig
> > +++ b/arch/powerpc/platforms/44x/Kconfig
> > @@ -24,6 +24,7 @@ config BLUESTONE
> >       default n
> >       select PPC44x_SIMPLE
> >       select APM821xx
> > +     select PCI
> >       select PCI_MSI
> >       select PPC4xx_MSI
> >       select PPC4xx_PCI_EXPRESS
> > @@ -78,6 +79,7 @@ config KATMAI
> >       select 440SPe
> >       select PCI
> >       select PPC4xx_PCI_EXPRESS
> > +     select PCI
> >       select PCI_MSI
>
> This case already had PCI selected a couple of lines above.


Good catch!

I dropped this hunk,
and applied to linux-kbuild.





> >       select PPC4xx_MSI
> >       help
> > @@ -219,6 +221,7 @@ config AKEBONO
> >       select SWIOTLB
> >       select 476FPE
> >       select PPC4xx_PCI_EXPRESS
> > +     select PCI
> >       select PCI_MSI
> >       select PPC4xx_HSTA_MSI
> >       select I2C
> > --
> > 2.19.1
> >



-- 
Best Regards
Masahiro Yamada
