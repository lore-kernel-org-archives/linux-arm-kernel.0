From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 3 Oct 2017 18:59:51 -0700
Subject: [PATCH 3/7] gpio: brcmstb: switch to handle_level_irq flow
In-Reply-To: <20170930034057.15166-4-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-4-opendmb@gmail.com>
Message-ID: <CADtm3G5VBDZd9Z-QFCEJnUvprVB2coub0u2OjNg9qMh-B-Zt7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
> Reading and writing the gpio bank status register each time a pending
> interrupt bit is serviced could cause new pending bits to be cleared
> without servicing the associated interrupts.
>
> By using the handle_level_irq flow instead of the handle_simple_irq
> flow we get proper handling of interrupt masking as well as acking
> of interrupts.  The irq_ack method is added to support this.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
