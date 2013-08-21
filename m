From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Aug 2013 09:04:07 +0200
Subject: [PATCHv2 2/2] clocksource: dw_apb_timer_of: Fix read_sched_clock
In-Reply-To: <1376522956-14960-2-git-send-email-dinguyen@altera.com>
References: <1376522956-14960-1-git-send-email-dinguyen@altera.com>
 <1376522956-14960-2-git-send-email-dinguyen@altera.com>
Message-ID: <CACRpkda9oyb2mr6PR1dfMpoxbzj3vUp7hKiQtN1oWH6aG_N96w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 1:29 AM,  <dinguyen@altera.com> wrote:

> -       sched_io_base = iobase + 0x04;
> +       sched_io_base = iobase;
>         sched_rate = rate;
>  }
>
>  static u32 read_sched_clock(void)
>  {
> -       return __raw_readl(sched_io_base);
> +       return ~__raw_readl(sched_io_base + 0x4);

So what about #define what 0x04 is?

#define MY_FOO_REGISTER_OFFSET 0x04

raw_readl(sched_io_base + MY_FOO_REGISTER_OFFSET);

You get the idea.

Yours,
Linus Walleij
