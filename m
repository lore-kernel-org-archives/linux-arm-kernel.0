From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 12 Jul 2016 09:07:25 +0800
Subject: [PATCH v2 15/22] usb: chipidea: msm: Mux over secondary phy at
 the right time
In-Reply-To: <CAJOFmgzxYutvxhBbmmYyuDd9PTgpDskzHTvCUGteATPEFTU31g@mail.gmail.com>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-16-stephen.boyd@linaro.org>
 <20160711044327.GG30448@shlinux2>
 <CAJOFmgzxYutvxhBbmmYyuDd9PTgpDskzHTvCUGteATPEFTU31g@mail.gmail.com>
Message-ID: <20160712010725.GK31647@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 03:03:37PM -0700, Stephen Boyd wrote:
> On 10 July 2016 at 21:43, Peter Chen <hzpeterchen@gmail.com> wrote:
> > On Thu, Jul 07, 2016 at 03:21:06PM -0700, Stephen Boyd wrote:
> >> diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> >> index 7e870a253f55..7708bee3ff3e 100644
> >> --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> >> +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> >> @@ -8,29 +8,44 @@
> >>  #include <linux/module.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_runtime.h>
> >> -#include <linux/usb/gadget.h>
> >>  #include <linux/usb/chipidea.h>
> >>  #include <linux/clk.h>
> >>  #include <linux/reset.h>
> >> +#include <linux/mfd/syscon.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/io.h>
> >>
> >>  #include "ci.h"
> >>
> >>  #define HS_PHY_AHB_MODE                      0x0098
> >>
> >> +/* Vendor base starts at 0x200 beyond CI base */
> >> +#define HS_PHY_SEC_CTRL				0x0078
> >> +#define HS_PHY_DIG_CLAMP_				BIT(16)
> >> +
> >
> > Keep alignment
> 
> It's aligned in my editor, tabs vs. spaces problem?
> 

You can always align with tab, I just see it does not align for each
line at both my mutt and web gmail.

-- 

Best Regards,
Peter Chen
