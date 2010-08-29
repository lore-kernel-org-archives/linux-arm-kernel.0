From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 29 Aug 2010 18:43:25 +0900
Subject: [GIT PULL] Samsung fixes for 2.6.36-rc3
In-Reply-To: <AANLkTi=+XnCQu6Cz0P+A=qhaeN2HKJ9gYdTx2jWe7sfH@mail.gmail.com>
References: <006d01cb45cd$0e4e3610$2aeaa230$%kim@samsung.com>
	<AANLkTi=+XnCQu6Cz0P+A=qhaeN2HKJ9gYdTx2jWe7sfH@mail.gmail.com>
Message-ID: <000101cb475e$a364eef0$ea2eccd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Fri, Aug 27, 2010 at 6:48 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Hi Linus,
> >
> > Please pull Samsung fixes from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > s5p-fixes-for-linus
> >
> > These things are for bug fix on 2.6.36-rc3.
> > If any problems, please let me know.
> 
> Well nothing changed. only LSI codes and required things from LSI side
> are merged.

At this point, focus on getting the critical portions of S5PV310/S5PC210
into
the mainline. Once that is done, other features can be merged as required.

> And still need more patches for booting at s5pc210 (aka s5pv310).
> 
Thanks for your concern.
But I think it's enough just only one patch about following...
I know the problem that we cannot get the proper clock 'id' from clk_get()
in
the console_initcall(). This problem occurs when only defined 'uclk1' as
uart
clock. And to solve that will be submitted soon.

> Several thins are missed.
> 1. gpio_to_irq patch not included. it's basic gpiolib feature. Without
> this patch, it can't use the generic gpiolib based drivers. e.g.,
> gpio-keys.
> http://marc.info/?l=linux-arm-kernel&m=128202435823832&w=2
> 
I don't think so, 'gpio_to_irq' is a new feature not a bug fix.
So if required, will be merged at the merge window after review.

> 2. Wrong UART level triggers.
> At least s5pc110/s5pc210 has wrong UART trigger values compare to macro
name.
> http://marc.info/?l=linux-arm-kernel&m=128218476209330&w=2
> 
I couldn't find anywhere used it in the mainline. So I'm not sure we really
need it.

> 3. set correct gpio config at GPIO I at s5pc110
> http://marc.info/?l=linux-arm-kernel&m=128202423923745&w=2
> 
mm...I will sort this out.

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
