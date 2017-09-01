From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Sep 2017 00:05:51 +0100
Subject: [PATCH] ARM: entry: Remove dead code in sys_mmap2
In-Reply-To: <76c18ba8-081f-f842-8dd3-2d6fbffc2e26@arm.com>
References: <1502700269-24384-1-git-send-email-vladimir.murzin@arm.com>
 <1502700269-24384-2-git-send-email-vladimir.murzin@arm.com>
 <76c18ba8-081f-f842-8dd3-2d6fbffc2e26@arm.com>
Message-ID: <20170901230551.GW20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 11:35:00AM +0100, Vladimir Murzin wrote:
> On 14/08/17 09:44, Vladimir Murzin wrote:
> > We support page size of 4K only, remove dead code.
> >
> > Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > ---
> >  arch/arm/kernel/entry-common.S | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> > index eb5cd77..52237ce 100644
> > --- a/arch/arm/kernel/entry-common.S
> > +++ b/arch/arm/kernel/entry-common.S
> > @@ -371,17 +371,8 @@ ENDPROC(sys_fstatfs64_wrapper)
> >   * offset, we return EINVAL.
> >   */
> >  sys_mmap2:
> > -#if PAGE_SHIFT > 12
> > -             tst     r5, #PGOFF_MASK
> > -             moveq   r5, r5, lsr #PAGE_SHIFT - 12
> > -             streq   r5, [sp, #4]
> > -             beq     sys_mmap_pgoff
> > -             mov     r0, #-EINVAL
> > -             ret     lr
> > -#else
> >               str     r5, [sp, #4]
> >               b       sys_mmap_pgoff
> > -#endif
> >  ENDPROC(sys_mmap2)
> >
> >  #ifdef CONFIG_OABI_COMPAT
> >
> 
> Ok for patch tracker?

Yep.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
