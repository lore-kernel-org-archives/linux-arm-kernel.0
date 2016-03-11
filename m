From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Mar 2016 23:04:10 +0700
Subject: [PATCH 1/3] pinctrl: single: Use a separate lockdep class
In-Reply-To: <1454351299-27440-2-git-send-email-sudeep.holla@arm.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
 <1454351299-27440-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <CACRpkdbwYx2uA4k1XzW861ig+S0uP0D1K3Mv5G6dcG-rNPn6wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 1:28 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> The single pinmux controller can be cascaded to the other interrupt
> controllers. Hence when propagating wake-up settings to its parent
> interrupt controller, there's possiblity of detecting possible recursive
> locking and getting lockdep warning.
>
> This patch avoids this false positive by using a separate lockdep class
> for this single pinctrl interrupts.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio at vger.kernel.org
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Patch applied with Grygorii's review tag.

Yours,
Linus Walleij
