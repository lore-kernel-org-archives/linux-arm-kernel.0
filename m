From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 17:03:29 +0100
Subject: [PATCH 1/3] DT binding: gpio-zynq: Document interrupt-controller
In-Reply-To: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1445617532-10228-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdan7oFcTWSF-fE-BiOsk4Pji7DgimfMji_eb3RGjdA4RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 6:25 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> HW and driver support the GPIO as interrupt-controller. Document that in
> the DT binding.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch subject augmented and applied.

> +- interrupt-controller : Marks the device node as an interrupt controller.
> +- #interrupt-cells     : Should be 2.  The first cell is the GPIO number.
> +                         The second cell bits[3:0] is used to specify trigger type and level flags:
> +                             1 = low-to-high edge triggered.
> +                             2 = high-to-low edge triggered.
> +                             4 = active high level-sensitive.
> +                             8 = active low level-sensitive.

If these can be or:ed together, e.g 3 = both edges, that needs to be
documented. If they can't the current patch is fine I guess.

Yours,
Linus Walleij
