From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 5 Jan 2016 10:59:32 -0500
Subject: [PATCH] drivers/bus: make uniphier-system-bus.c explicitly
 non-modular
In-Reply-To: <CAK7LNARdg5UCU99mL6Jhz_rHgyOkQ=pugdSMz_BmFRxH-eYSsA@mail.gmail.com>
References: <1451935379-14107-1-git-send-email-paul.gortmaker@windriver.com>
 <CAK7LNASK5GCQ-Jk7ApmSinnW2PAaSmD-k2X9BbGg66-_b5kASg@mail.gmail.com>
 <CAK7LNASDdpt0zVHUe=EMdKCH6N25CwBLtR0A4jXP=P8zAaaqRA@mail.gmail.com>
 <CAK7LNASU3OMhhPTQvEUKEX_5RNiCeaF-QUBgvuSVpEvd4awWww@mail.gmail.com>
 <CAK7LNARdg5UCU99mL6Jhz_rHgyOkQ=pugdSMz_BmFRxH-eYSsA@mail.gmail.com>
Message-ID: <20160105155932.GT12458@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH] drivers/bus: make uniphier-system-bus.c explicitly non-modular] On 05/01/2016 (Tue 11:31) Masahiro Yamada wrote:

> 2016-01-05 11:26 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > Hi Paul,
> >

[...]

> >
> >
> > I assume commit 326ea45aa827 ("bus: uniphier: allow only built-in driver")
> > is a temporary fix.
> >
> > I'd like to revive the tristate for this driver
> > by hook or by crook.
> >
> >
> > I've sent the following to fix the build error.
> > http://www.thefreedictionary.com/
> 
> Sorry, I mean this one:
> https://patchwork.kernel.org/patch/7952361/

Sure, I'll shelf it and assume it will get back to tristate.

Note however that the patch I was looking at was not 326ea. It was

commit 6c741c74092c61465af206672ba567940a23d709
Author: Daniel Kurtz <djkurtz@chromium.org>
Date:   Tue Dec 22 21:46:37 2015 +0800

    pinctrl: mediatek: convert to arch_initcall

..and if you make it tristate again, you defeat the above change,
since if you look at module.h, you will see for the =m config:

 #define arch_initcall(fn)               module_init(fn)

...meaning that the change in 6c741c does nothing if =m is set.
I don't know if that is an issue or not, perhaps Daniel can comment.

Paul.
--

> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
