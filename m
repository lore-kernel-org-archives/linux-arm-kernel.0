From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 19:37:35 +0200
Subject: [PATCH 1/6] mfd: ab8500-core: Remove unused ab8500-gpio IRQ ranges
In-Reply-To: <1351089926-32161-2-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
 <1351089926-32161-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZbTeaa4dQJ1Nxs38_gM+yUS=FxA-Fgie-ZbtKne51C3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 4:45 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The IRQ ranges provided in ab8500-core to be passed on to the
> ab8500-gpio driver are not only redundant, but they are also
> causing a warning in the boot log. These IRQ ranges, like any
> other MFD related IRQ resource are passed though MFD core for
> automatic conversion to virtual IRQs; however, MFD core does
> not support IRQ mapping of IRQ ranges. Let's just remove them.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Hey! That riddes the pesky boot warning.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Sam, please pick this into the MFD tree for the -rc series!

Yours,
Linus Walleij
