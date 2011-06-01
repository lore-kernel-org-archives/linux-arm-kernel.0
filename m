From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 01 Jun 2011 10:42:46 +0300
Subject: [PATCH v6 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <BANLkTim0xrx+33BeoSbXbQcu2Ab6Oin=Wg@mail.gmail.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
	<1305637877-24436-2-git-send-email-marc.zyngier@arm.com>
	<4DE53D52.4040508@ru.mvista.com>
	<20110531224428.6636e283@taxman.wild-wind.fr.eu.org>
	<BANLkTim0xrx+33BeoSbXbQcu2Ab6Oin=Wg@mail.gmail.com>
Message-ID: <1306914166.4405.47.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-31 at 22:20 -0400, Mike Frysinger wrote:
> On Tue, May 31, 2011 at 17:44, Marc Zyngier wrote:
> > On Tue, 31 May 2011 23:11:14 +0400 Sergei Shtylyov wrote:
> >> Marc Zyngier wrote:
> >> > In the process of moving platforms away from integrator-flash
> >> > (aka armflash), add to physmap the few features that make
> >> > armflash unique:
> >>
> >> > - optionnal probing for the AFS partition type
> >> > - init() and exit() methods, used by Integrator to control
> >> >   write access to the various onboard programmable components
> >>
> >> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >> > Cc: David Woodhouse <dwmw2@infradead.org>
> >> [...]
> >>
> >> > diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
> >> > index bcfd9f7..d37cca0 100644
> >> > --- a/include/linux/mtd/physmap.h
> >> > +++ b/include/linux/mtd/physmap.h
> >> > @@ -22,6 +22,8 @@ struct map_info;
> >> >
> >> >  struct physmap_flash_data {
> >> >     unsigned int            width;
> >> > +   int                     (*init)(struct platform_device *);
> >> > +   void                    (*exit)(struct platform_device *);
> >>
> >>     How about a declaration for 'struct platform_device' beforehand? This breaks
> >> build on other platforms at least...
> >
> > Sure. Please send a patch.
> 
> uhh, what ?  you broke things, so you fix them.  i already pointed out
> this breakage to you over a week ago.
> -mike

The change went in via Russell's tree, I sent him a fix. It looks like
he did not merge it. Now I'm not sure who should merge this patch. I'll
ping dwmw2.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
