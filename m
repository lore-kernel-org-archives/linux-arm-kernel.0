From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Sep 2017 00:05:41 +0100
Subject: [PATCH] ARM: Remove leftover of fixmap_page_table
In-Reply-To: <0a7e5d42-de9a-6424-7976-e2240da182de@arm.com>
References: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
 <0a7e5d42-de9a-6424-7976-e2240da182de@arm.com>
Message-ID: <20170901230541.GV20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 11:34:23AM +0100, Vladimir Murzin wrote:
> On 14/08/17 09:44, Vladimir Murzin wrote:
> > fixmap_page_table was removed by commit 836a24183273 (ARM: expand
> > fixmap region to 3MB), but some traces are still there - get rid of
> > them.
> >
> > Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > ---
> >  arch/arm/include/asm/highmem.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
> > index 0a0e2d1..61736fd 100644
> > --- a/arch/arm/include/asm/highmem.h
> > +++ b/arch/arm/include/asm/highmem.h
> > @@ -18,7 +18,6 @@
> >       } while (0)
> >
> >  extern pte_t *pkmap_page_table;
> > -extern pte_t *fixmap_page_table;
> >
> >  extern void *kmap_high(struct page *page);
> >  extern void kunmap_high(struct page *page);
> >
> 
> Ok for patch tracker?

Yep.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
