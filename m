From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Mon, 07 Sep 2009 11:00:00 +0900
Subject: [PATCH 07/12] [ARM][S3C6410] Add definition of keypad
	platform	data
In-Reply-To: <9c9fda240909061708v5fa6e280wc764f037e3f8e51a@mail.gmail.com>
References: <00a901ca2e2d$004e7bf0$00eb73d0$%yang@samsung.com>
	<9c9fda240909061708v5fa6e280wc764f037e3f8e51a@mail.gmail.com>
Message-ID: <000f01ca2f5e$e87e40e0$b97ac2a0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Kyungmin Park
> Sent: Monday, September 07, 2009 9:08 AM
> To: ???
> Cc: linux-arm-kernel at lists.infradead.org; ???/AP???/E3/????; ben-
> linux at fluff.org
> Subject: Re: [PATCH 07/12] [ARM][S3C6410] Add definition of keypad
> platform data
> 
> 2009/9/5 ??? <jsgood.yang@samsung.com>:
> > This patch includes platform data header of keypad driver and
> > extern definition of function to set platform data.
> >
> > Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
> > Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
> > ---
> >  arch/arm/plat-s3c/include/plat/keypad.h |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-s3c/include/plat/keypad.h
> >
> > diff --git a/arch/arm/plat-s3c/include/plat/keypad.h b/arch/arm/plat-
> s3c/include/plat/keypad.h
> > new file mode 100644
> > index 0000000..caf2417
> > --- /dev/null
> > +++ b/arch/arm/plat-s3c/include/plat/keypad.h
> > @@ -0,0 +1,14 @@
> > +#ifndef __ASM_PLAT_S3C_KEYPAD_H
> > +#define __ASM_PLAT_S3C_KEYPAD_H
> 
> Also you missed the copyright here.
> 
> > +
> > +struct s3c_platform_keypad {
> > +       int nr_rows;
> > +       int nr_cols;
> > +       int max_keys;
> > +       int max_masks;
> > +       int delay;
> > +};
> 
> Don't you need the keymap at here?
> And please consider s5pc1xx series. you already aware the s5pc1xx
> series keypad.
> Also add the cfg_gpio at here.

We got some recommendations about gpio function that the cfg_gpio() calls in the driver source code is not good idea.
Harald, could you explain the details again about gpio function call?

> 
> Thank you,
> Kyungmin Park
> 
> > +
> > +extern void s3c_keypad_set_platdata(struct s3c_platform_keypad *pd);
> > +
> > +#endif /* __ASM_PLAT_S3C_KEYPAD_H */
> > --
> > 1.6.2.5
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
