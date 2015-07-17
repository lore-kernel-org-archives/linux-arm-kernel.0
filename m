From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jul 2015 14:41:21 +0200
Subject: [PATCH] [v2] pinctrl: add support for Qualcomm Technologies
 QDF2xxx ARM64 SoCs
In-Reply-To: <1436978834-7271-1-git-send-email-timur@codeaurora.org>
References: <1436978834-7271-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkda-bhOUUTN314Z_T02Mwsr6DmpeAnNspcc1eFvZ6BBn8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 6:47 PM, Timur Tabi <timur@codeaurora.org> wrote:

> Add the pinctrl driver for the Qualcomm Technologies QDF2xxx ARM64 SoCs,
> which uses the Qualcomm Technologies TLMM pinctrl/gpio device.  This
> driver is probed via ACPI and uses the pinctrl-msm.c backend driver.
>
> This driver is intended to be used only an ACPI-enabled system.  As such,
> UEFI will handle all pin control configuration, so this driver does not
> provide pin control functions.  It is effectively a GPIO-only driver.

In my experience, you will come back and add pin control to it if
it ever sees any practical power-aware use cases.

For the same reason that Intel is doing it to their pin controllers,
that also run on systems that are ACPI-enabled.

>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

This version applied with Bj?rn's review tag.


Yours,
Linus Walleij
