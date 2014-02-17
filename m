From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Feb 2014 11:22:48 +0000
Subject: [PATCH v3 14/15] charger: max14577: Configure battery-dependent
 settings from DTS
In-Reply-To: <1392633657.11078.4.camel@AMDC1943>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
 <1392627950-26927-15-git-send-email-k.kozlowski@samsung.com>
 <20140217100735.GA20218@lee--X1>
 <1392633657.11078.4.camel@AMDC1943>
Message-ID: <20140217112248.GB20218@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > diff --git a/include/linux/mfd/max14577-private.h b/include/linux/mfd/max14577-private.h
> > > index a8cd7de3526a..fc69d7beb1aa 100644
> > > --- a/include/linux/mfd/max14577-private.h
> > > +++ b/include/linux/mfd/max14577-private.h
> > > @@ -269,6 +269,20 @@ enum maxim_muic_charger_type {
> > >  #define MAX77836_CHARGER_CURRENT_LIMIT_HIGH_STEP	 25000U
> > >  #define MAX77836_CHARGER_CURRENT_LIMIT_MAX		475000U
> > >  
> > > +/* MAX14577 charger End-Of-Charge current limits
> > > + * (as in MAXIM_CHGCTRL5 register), uA
> > > + */
> > > +#define MAX14577_CHARGER_EOC_CURRENT_LIMIT_MIN		50000U
> > > +#define MAX14577_CHARGER_EOC_CURRENT_LIMIT_STEP		10000U
> > > +#define MAX14577_CHARGER_EOC_CURRENT_LIMIT_MAX		200000U
> > > +
> > > +/* MAX14577/MAX77836 Battery Constant Voltage
> > > + * (as in MAXIM_CHGCTRL3 register), uV
> > > + */
> > 
> > These are not proper multi-line comments.
> > 
> > Documentation/CodingSytle:
> > 
> >  The preferred style for long (multi-line) comments is:
> >  
> >          /*
> >           * This is the preferred style for multi-line
> >           * comments in the Linux kernel source code.
> >           * Please use it consistently.
> >           *
> >           * Description:  A column of asterisks on the left side,
> >           * with beginning and ending almost-blank lines.
> >           */
> 
> Sure. Sorry for bugging with such trivial mistakes.

That's okay.

Just fix it up and apply my:
  Acked-by: Lee Jones <lee.jones@linaro.org>

No need to resubmit over this. Concentrate on the other Acks now.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
