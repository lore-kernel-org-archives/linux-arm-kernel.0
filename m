From: dsd@laptop.org (Daniel Drake)
Date: Mon, 12 Aug 2013 16:53:48 -0600
Subject: [PATCH v6 02/11] irqchip: mmp: support irqchip
In-Reply-To: <1374833133-21119-3-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAMLZHHTsYqSB-dPGZvAZT+aJ70sbV679CyJgm-V6-Q7NFtgVbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 4:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Support IRQCHIP on irq-mmp driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-mmp/mmp-dt.c  |   8 +-
>  arch/arm/mach-mmp/mmp2-dt.c |   8 +-
>  drivers/irqchip/irq-mmp.c   | 238 +++++++++++++++++++++++---------------------
>  3 files changed, 126 insertions(+), 128 deletions(-)

This patch causes boot to fail, tested on OLPC XO-1.75 (MMP2).

Calibrating delay loop... irq 13, desc: db804740, depth: 1, count: 0,
unhandled: 0
->handle_irq():  c00704f4, handle_bad_irq+0x0/0x214
->irq_data.chip(): c05aa2e8, 0xc05aa2e8
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 13, desc: db804740, depth: 1, count: 0, unhandled: 0
->handle_irq():  c00704f4, handle_bad_irq+0x0/0x214
->irq_data.chip(): c05aa2e8, 0xc05aa2e8
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 13, desc: db804740, depth: 1, count: 0, unhandled: 0
->handle_irq():  c00704f4, handle_bad_irq+0x0/0x214
->irq_data.chip(): c05aa2e8, 0xc05aa2e8
->action():   (null)
   IRQ_NOPROBE set
 IRQ_NOREQUEST set

continues as infinite loop.

I had a poke, trying to figure out what would have caused this,
without much luck. I tried to go back to irq_domain_add_legacy() and
sprinkled some icu_mask_irq() calls around, nothing changed. Any
ideas?

Thanks
Daniel
