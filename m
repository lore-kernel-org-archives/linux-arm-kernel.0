From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Mar 2016 13:05:49 +0100
Subject: [PATCH] pinctrl: sunxi: Fix A33 external interrupts not working
In-Reply-To: <1457808297-12300-1-git-send-email-hdegoede@redhat.com>
References: <1457808297-12300-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZF-hiwGaHdyORzdj06vqmceZ_5ko1LDYJoCMXC216hTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2016 at 7:44 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> pinctrl-sun8i-a33.c (and the dts) declare only 2 interrupt banks,
> where as the closely related a23 has 3 banks. This matches with the
> datasheet for the A33 where only interrupt banks B and G are specified
> where as the A23 has banks A, B and G.
>
> However the A33 being the A23 derative it is means that the interrupt
> configure/status io-addresses for the 2 banks it has are not changed
> from the A23, iow they have the same address as if bank A was still
> present. Where as the sunxi pinctrl currently tries to use the A23 bank
> A addresses for bank B, since the pinctrl code does not know about the
> removed bank A.
>
> Add a irq_bank_base parameter and use this where appropriate to take
> the missing bank A into account.
>
> This fixes external interrupts not working on the A33 (tested with
> an i2c touchscreen controller which uses an external interrupt).
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied, tagged for stable.

Yours,
Linus Walleij
