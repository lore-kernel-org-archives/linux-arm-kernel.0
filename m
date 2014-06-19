From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Jun 2014 16:19:13 +0100
Subject: [PATCH] gpio: crystalcove: Fix implicit declaration of function
 'seq_printf' error
In-Reply-To: <CAAVeFuKppwDusknaJg88m6r8KwWPJ=BJRuLsZavQL_JZTHTd+A@mail.gmail.com>
References: <1403190228-14344-1-git-send-email-lee.jones@linaro.org>
 <CAAVeFuKppwDusknaJg88m6r8KwWPJ=BJRuLsZavQL_JZTHTd+A@mail.gmail.com>
Message-ID: <20140619151913.GD26560@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Jun 2014, Alexandre Courbot wrote:

> On Fri, Jun 20, 2014 at 12:03 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > drivers/gpio/gpio-crystalcove.c: In function 'crystalcove_gpio_dbg_show':
> > drivers/gpio/gpio-crystalcove.c:286:3: error: implicit declaration of function 'seq_printf'
> >    seq_printf(s, " gpio-%-2d %s %s %s %s ctlo=%2x,%s %s %s\n",
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > I'm looking for a quick Ack on this patch.  It's a fix to an immutable
> > branch that I'm carrying which is shared between GPIO and MFD.  Stephen
> > reported it when the MFD tree was sucked into -next.
> >
> > Alexandre,
> >   I believe Linus is out on vacation this week, so if you could take a
> > quick look at this, I'd be much obliged.
> 
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks Alexandre.

> Hope that's fast enough. ;)

~4 mins.  Not too bad! ;)

> > Linus,
> >   Once I've acquired the aforementioned Ack I'll fix this patch up into
> > our immutable branch and send another pull-request.
> > ---
> >  drivers/gpio/gpio-crystalcove.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
> > index 5a98499..934462f 100644
> > --- a/drivers/gpio/gpio-crystalcove.c
> > +++ b/drivers/gpio/gpio-crystalcove.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/gpio.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/bitops.h>
> >  #include <linux/regmap.h>
> >  #include <linux/mfd/intel_soc_pmic.h>
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
