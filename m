From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 Aug 2013 08:18:43 +0100
Subject: [PATCH 05/13] ARM: ux500: Apply a ste-* prefix onto snowball.dts
In-Reply-To: <CAOesGMgZYFgwAhVCc-ObnxcmGTLTM-Zk27Dh7r1_p646ULWHeg@mail.gmail.com>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
 <1374243229-8585-6-git-send-email-lee.jones@linaro.org>
 <CAOesGMgd51g7WAkQu+ckT-=skKuMyj19nJkHxh+YmGSBhSL+Vg@mail.gmail.com>
 <CACRpkdasMSCfdhzrW+7kHM8UUxxQ5UMAcc5bOogc-9RwXE9RVg@mail.gmail.com>
 <CAOesGMgZYFgwAhVCc-ObnxcmGTLTM-Zk27Dh7r1_p646ULWHeg@mail.gmail.com>
Message-ID: <20130822071843.GA22023@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Aug 2013, Olof Johansson wrote:

> On Wed, Aug 21, 2013 at 3:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Aug 21, 2013 at 2:31 AM, Olof Johansson <olof@lixom.net> wrote:
> >
> >>> diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> >>> similarity index 100%
> >>> rename from arch/arm/boot/dts/snowball.dts
> >>> rename to arch/arm/boot/dts/ste-snowball.dts
> >>
> >> Grmbl, grmbl, grmbl. This now breaks any script that knows to use
> >> snowball.dtb. :(
> >>
> >> It's good to get the prefixes added, but it's annoying to have to deal
> >> with both during an overlap period. Maybe generate both dtb filenames
> >> for a while but rename the source?
> >
> > Hm I had the same problem but changed my Makefile
> > (scripts are too simple for me) like this:
> >
> >  dtb            := $(build_dir)/arch/arm/boot/dts/ste-hrefv60plus.dtb
> > +fallbackdtb    := $(build_dir)/arch/arm/boot/dts/hrefv60plus.dtb
> > (...)
> > -       cat $(dtb) >> $(output_dir)/zImage
> > +       if [ -f arch/arm/boot/dts/hrefv60plus.dts ] ; then \
> > +           cat $(fallbackdtb) >> $(output_dir)/zImage ; echo "fallback" ; \
> > +       else \
> > +           cat $(dtb) >> $(output_dir)/zImage ; \
> > +       fi
> 
> Sure, working around it is trivial. I just did a:
>    - at cp $</arch/arm/boot/dts/ste-snowball.dtb $</arch/arm/boot/dts/snowball.dtb
> 
> But the point is that everybody needs to do something like that now,
> which is unfortunate.

Well with only ~5 active users it's probably not that much of a big
deal anyway, but I'm still interested to know what the alternative is?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
