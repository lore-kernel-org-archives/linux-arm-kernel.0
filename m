From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 18 May 2015 16:56:45 +0800
Subject: [PATCH v2 2/9] ARM: add secondary_startup_arm prototype in
 header file
In-Reply-To: <20150516211953.GQ2067@n2100.arm.linux.org.uk>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-3-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBe+8VHnHbMA4gMzzReUNUf3LiL6JnPhehkxWtzrYAhBBZg@mail.gmail.com>
 <20150516211953.GQ2067@n2100.arm.linux.org.uk>
Message-ID: <1431939405.8312.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-05-16 at 22:19 +0100, Russell King - ARM Linux wrote:
> On Sat, May 16, 2015 at 11:02:40AM +0200, Matthias Brugger wrote:
> > 2015-05-16 9:58 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> > > Put secondary_startup_arm() prototype in arch/arm/include/asm/smp.h
> > > so users doesn't have to add extern prototype in their code.
> > >
> > > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > > ---
> > >  arch/arm/include/asm/smp.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> > > index 18f5a55..f5cffb7 100644
> > > --- a/arch/arm/include/asm/smp.h
> > > +++ b/arch/arm/include/asm/smp.h
> > > @@ -69,6 +69,7 @@ struct secondary_data {
> > >  extern struct secondary_data secondary_data;
> > >  extern volatile int pen_release;
> > >  extern void secondary_startup(void);
> > > +extern void secondary_startup_arm(void);
> > 
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> This change should also end up in the patch system as its core ARM stuff,
> especially if it's not scheduled for merging through arm-soc.
> 

Russell,

Thanks. I just put these 2 patches into the patch system.
Since patch 7/9 depends on this patch, I think we should merge this
patch(2/9) through arm-soc tree to prevent build fail.

Joe.C
