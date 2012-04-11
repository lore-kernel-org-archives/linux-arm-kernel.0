From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2012 01:07:43 +0200
Subject: [PATCH 1/3] integrator: fix the IRQ masks on the Integrator/CP
In-Reply-To: <20120411225651.GD24211@n2100.arm.linux.org.uk>
References: <1334184223-18864-1-git-send-email-linus.walleij@linaro.org>
 <20120411225651.GD24211@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZxXiaPSkP7eiamNaWLWNepFHfPNu=-uZbk8h4n7jwCKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 12:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> - ? ? pic_mask = ~((~0u) << (11 - IRQ_PIC_START));
>> - ? ? pic_mask |= (~((~0u) << (29 - 22))) << 22;
>> + ? ? pic_mask = ~((~0u) << (1 + IRQ_PIC_END - IRQ_PIC_START));
>
> Err no, the original is correct.
>
> Integrator/CP only has IRQs 29-22 and IRQs 11-0. ?IRQs 21-12 are
> reserved. ?Integrator/AP on the other hand has IRQs 21-0.

Ahhh like that, now I finally see. Thanks! I'll fix.
The "hole" in the mask creates some obstacles in the hwirq map too, will
sort it out.

Yours,
Linus Walleij
