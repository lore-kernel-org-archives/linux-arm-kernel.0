From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 6 Aug 2017 21:57:21 +0300
Subject: [PATCH v2 0/2] OMAP3+/4+ PRM: fix of_irq_get() result checks
In-Reply-To: <20170806151420.104225294@cogentembedded.com>
References: <20170806151420.104225294@cogentembedded.com>
Message-ID: <CAHp75VfdGkac6PUMSJLydR9GcZ8UAmqRR6zq2xNhYL8mMe3iUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 6, 2017 at 6:14 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello!
>
> Here's the set of 2 patches against the 'omap-for-v4.13/fixes' branch of Tony
> Lingren's 'linux-omap.git' repo.  I'm  fixing of_irq_get() DT API result
> checks.
>
> [1/2] ARM: OMAP3+: PRM: fix of_irq_get() result check
> [2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks

What IRQ domain did you consider? In case of STRICT the mapping will
be 1:1 and 0 is _valid_ IRQ number for hwirq.
0 in Linux kernel IRQ numbering often means NO_IRQ. But there might be
exceptions.

So, it would be nice to see if there is a problem on certain platform
if the patch is not applied, or is it problem on OF IRQ code, or
wrong interpratation of 0?

-- 
With Best Regards,
Andy Shevchenko
