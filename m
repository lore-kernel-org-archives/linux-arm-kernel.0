From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:49:42 +0900
Subject: [PATCH v2 5/5] ARM: Exynos: Add basic dts file for Samsung Trats
 board
In-Reply-To: <7700294.NPoOn06yTZ@flatron>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <3039444.Ol4zGlGWJ2@flatron> <24dd01cd8d6c$41586970$c4093c50$%kim@samsung.com>
 <7700294.NPoOn06yTZ@flatron>
Message-ID: <09a401cd96c1$70df2860$529d7920$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kgene,
> 
> On Saturday 08 of September 2012 11:47:15 Kukjin Kim wrote:
> > > > > +       memory {
> > > > > +               reg =  <0x40000000 0x20000000
> > > > > +                       0x60000000 0x20000000>;
> > > > > +       };
> > > >
> > > > Why does this have to be split. Why not have a single entry with the
> > > > size as 0x40000000?
> > >
> > > The memory node corresponds to struct meminfo and each entry (with two
> > > values) makes one struct membank defining a memory bank.
> >
> > Well...
> >
> > > I've been talking with Kyungmin about this. Originally bootloaders
> used
> > > to report 4 banks of 256 MiB, but it turned out that real bank
> > > configuration on Trats is 2 banks of 512 MiB.
> >
> > I think, following should ok here.
> >
> > memory {
> > 	reg = <0x40000000 0x40000000>;
> > };
> 
> This will not boot with CONFIG_SPARSEMEM, unless maximum section size is
> increased to 1024MiB.
> 
Well, see other Origen board. As I know, it works well under environment you
said but I'm not sure about its boot-loader environment. Anyway, please
check one more and let me know. Then, if you still have same problem, let's
use double entries for memory temporary.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
