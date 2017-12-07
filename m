From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Dec 2017 10:10:29 +0100
Subject: [PATCH v5 00/11] add pinmuxing support for pins in AXP209 and
 AXP813 PMICs
In-Reply-To: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
References: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
Message-ID: <CACRpkdYWoi0MQagPZHD8arr1fv4ssorJqZDRnb0vmx2WFvqi3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 3:46 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:

> The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
> be used either as GPIOs or for other purposes (ADC or LDO here).
>
> We already have a GPIO driver for the GPIO use of those pins on the AXP209.
> Let's "upgrade" this driver to support all the functions these pins can have.
>
> Then we add support to this driver for the AXP813 which is slighlty different
> (basically a different offset in two registers and one less pin).
>
> I suggest patches 1 to 8 go through Linus's tree and 9 via Lee's.
>
> v5:
>   - add reference to pinctrl dt-bindings in driver's dt-binding,
>   - add statement that this driver employs per-pin muxing pattern,
>   - add a patch on top of the patch series to fix checkpatch warnings,
>   - add a few information to the Kconfig to make checkpatch happy,

I have applied patches 1-8 to an immutable branch in the GPIO
tree, then merged that into the GPIO "devel" branch as well as the
pinctrl "devel" branch so we can develop the driver in the pinctrl
tree henceforth.

Yours,
Linus Walleij
