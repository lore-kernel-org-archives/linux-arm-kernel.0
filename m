From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 May 2015 22:19:53 +0100
Subject: [PATCH v2 2/9] ARM: add secondary_startup_arm prototype in
 header file
In-Reply-To: <CABuKBe+8VHnHbMA4gMzzReUNUf3LiL6JnPhehkxWtzrYAhBBZg@mail.gmail.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-3-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBe+8VHnHbMA4gMzzReUNUf3LiL6JnPhehkxWtzrYAhBBZg@mail.gmail.com>
Message-ID: <20150516211953.GQ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 16, 2015 at 11:02:40AM +0200, Matthias Brugger wrote:
> 2015-05-16 9:58 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> > Put secondary_startup_arm() prototype in arch/arm/include/asm/smp.h
> > so users doesn't have to add extern prototype in their code.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >  arch/arm/include/asm/smp.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> > index 18f5a55..f5cffb7 100644
> > --- a/arch/arm/include/asm/smp.h
> > +++ b/arch/arm/include/asm/smp.h
> > @@ -69,6 +69,7 @@ struct secondary_data {
> >  extern struct secondary_data secondary_data;
> >  extern volatile int pen_release;
> >  extern void secondary_startup(void);
> > +extern void secondary_startup_arm(void);
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

This change should also end up in the patch system as its core ARM stuff,
especially if it's not scheduled for merging through arm-soc.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
