From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jun 2018 16:29:45 +0200
Subject: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: add gpio-ranges,
 gpio-reserved-ranges
In-Reply-To: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
References: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
Message-ID: <CACRpkdaZfeEQyqK9UXWnm1_5ihc7abbVGbUmJQU8Z6SzpObM6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 1:06 PM Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch adds the gpio-ranges and gpio-reserved-ranges property
> definitions to the binding text files supported by the pinctrl-msm
> driver framework.
>
> gpio-ranges:
> For DT-based platforms the pinctrl-msm framework currently relies
> on the deprecated-for-DT gpiochip_add_pin_range() function to add
> the range of GPIOs to be handled by the pin controller. Due to
> interactions within gpiolib code, this causes the pinctrl-msm
> driver to bail out (-517) during boot when a gpio-hog is declared.
> This can be fatal and cause the system to not boot or reset
> (for a detailed explanation and call-trace, refer to patch:
> "pinctrl: msm: fix gpio-hog related boot issues" in this series).
>
> gpio-reserved-ranges:
> The binding has been added as a precaution since the TrustZone
> firmware (aka QSEE), which is running as the hypervisor, might
> have reserved certain, but undisclosed pins. Hence reading or
> writing to the registers for those pins will cause an
> XPU violation and this subsequently crashes the kernel.
>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Patch applied with Rob's review tag.
I assume Bjorn is in on this as well as he's ACKed the main
DTS changes.

Yours,
Linus Walleij
