From: dsd@laptop.org (Daniel Drake)
Date: Wed, 14 Aug 2013 11:47:23 -0600
Subject: [PATCH v6 02/11] irqchip: mmp: support irqchip
In-Reply-To: <CAMLZHHQF2xAC8McNyH_8Ln-yVAUegHKk9wJqQd7LY9KhMRciuA@mail.gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-3-git-send-email-haojian.zhuang@gmail.com>
 <CAMLZHHTsYqSB-dPGZvAZT+aJ70sbV679CyJgm-V6-Q7NFtgVbQ@mail.gmail.com>
 <CAMLZHHQF2xAC8McNyH_8Ln-yVAUegHKk9wJqQd7LY9KhMRciuA@mail.gmail.com>
Message-ID: <CAMLZHHTavPi2xZc0VuxcLE4rO0XR-QKv3wsfrBaT7qhKdnAK7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 4:53 PM, Daniel Drake <dsd@laptop.org> wrote:
> generic_handle_irq() above looks up the descriptor for IRQ 13, but it
> does it without considering the mapping. So it picks up the descriptor
> for "legacy" interrupt 13 and passes that to icu_mask_ack_irq() -
> rather than passing the descriptor for the hwirq 13 that irq-mmp.c
> registered and was expecting (i.e. no translation was performed).
>
> How is this supposed to work?

All the users of irq_domain_add_linear() that I have looked at supply
a custom IRQ handler routine (via set_handle_irq) that does the
translation.

So this patch needs to be merged with patch 3 in the series (which
does just that), or the conversion from legacy to linear needs to
happen in patch 3, not this one. Personally I would just merge the 2
patches.

With patch 3 also applied, there is no more crash.

Thanks,
Daniel
