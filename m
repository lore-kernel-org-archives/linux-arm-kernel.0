From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Sep 2012 10:21:35 +0200
Subject: [PATCH v2 5/5] ARM: Exynos: Add basic dts file for Samsung Trats
 board
In-Reply-To: <24dd01cd8d6c$41586970$c4093c50$%kim@samsung.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <3039444.Ol4zGlGWJ2@flatron>
 <24dd01cd8d6c$41586970$c4093c50$%kim@samsung.com>
Message-ID: <7700294.NPoOn06yTZ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Saturday 08 of September 2012 11:47:15 Kukjin Kim wrote:
> > > > +       memory {
> > > > +               reg =  <0x40000000 0x20000000
> > > > +                       0x60000000 0x20000000>;
> > > > +       };
> > > 
> > > Why does this have to be split. Why not have a single entry with the
> > > size as 0x40000000?
> > 
> > The memory node corresponds to struct meminfo and each entry (with two
> > values) makes one struct membank defining a memory bank.
> 
> Well...
> 
> > I've been talking with Kyungmin about this. Originally bootloaders used
> > to report 4 banks of 256 MiB, but it turned out that real bank
> > configuration on Trats is 2 banks of 512 MiB.
> 
> I think, following should ok here.
> 
> memory {
> 	reg = <0x40000000 0x40000000>;
> };

This will not boot with CONFIG_SPARSEMEM, unless maximum section size is 
increased to 1024MiB.

> > > Probably, the interrupts can be listed when we have pinctrl driver
> > > merged in Samsung tree.
> > 
> > Right.
> 
> Note, you can do it on top of samsung tree :-)

OK.

--
Best regards,
Tomasz Figa
