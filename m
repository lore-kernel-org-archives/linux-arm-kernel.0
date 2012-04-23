From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2012 15:13:39 +0200
Subject: [PATCH 03/15] ARM: ux500: Use correct format for dynamic IRQ
 assignment
In-Reply-To: <1334867804-31942-4-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZM2m_T5T-96wrXKG=oru8sh9PS9O+z20eEvc97566uzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch applies the correct format requested by the irq
> domain. For chained IRQs which use GPIO lines as IRQs, we
> stipulate that a two cell request is required. The first cell
> contains the requested IRQ and the second can contain flags
> pertaining to edge detection and level sensitive values. The
> zeroth cell specifies the GPIO controller by use of a phandle.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?arch/arm/boot/dts/db8500.dtsi ?| ? 22 ++++++++++++++++++++--
> ?arch/arm/boot/dts/snowball.dts | ? 20 +++++++++-----------
> ?2 files changed, 29 insertions(+), 13 deletions(-)

So I created a separate ux500-devicetree branch and split off
the changes under arch/arm/boot/dts/* here. For example
I have split the patch:
"drivers/gpio: gpio-nomadik: Apply Device Tree bindings"

Into one changing code and one changing the device tree
itself. Else this won't be possible to keep separate topic
branches, and we want that.

Then applied this on top.

I hope you're OK with this?

Yours,
Linus Walleij
