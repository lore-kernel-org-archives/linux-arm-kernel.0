From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Jun 2017 14:33:26 +0200
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 10:54 PM, Timur Tabi <timur@codeaurora.org> wrote:

> On Qualcomm Technologies QDF2xxx platforms, only a subset of the GPIOs
> are actually available to the HLOS.  The others are blocked by the XPU,
> and any attempt to access them will cause an XPU violation that halts
> the system.

That's a bummer. Looking for Bj?rn's review on this patch.

> Instead, the ACPI table now lists only specific GPIOs that are exposed
> externally as generic GPIO pins.

The ACPI table or the device tree property "gpios" right?

(But maybe this system is only using ACPI.)

> To maintain consistency, the GPIOs are
> enumerated 0 .. (N-1) as before, so that "gpio0" is really whatever is
> the first GPIO listed in ACPI.  The actual mapping is available via
> /sys/kernel/debug/gpio.

I think using "lsgpio" fron tools/gpio/lsgpio.c is better to inspect
the available GPIOs.

If you haven't tested the GPIO tools, please try it out.

Yours,
Linus Walleij
