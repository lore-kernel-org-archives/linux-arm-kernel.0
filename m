From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 13:01:24 +0200
Subject: [PATCH] gpio: zynq: Fix problem with unbalanced pm_runtime_enable
In-Reply-To: <b4b2bb2d7747f8c9223fb50fd2868f77a7c7f63a.1435220957.git.michal.simek@xilinx.com>
References: <b4b2bb2d7747f8c9223fb50fd2868f77a7c7f63a.1435220957.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdYZ8JMrjSknLGERU2Z-0HvKT-fBpC04QMBF-W+nfbxJeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 10:29 AM, Michal Simek <michal.simek@xilinx.com> wrote:

> Add missing pm_runtime_disabled to remove().
>
> Error log:
> root at zynqmp:~# modprobe gpio_zynq
> root at zynqmp:~# lsmod
>     Not tainted
> gpio_zynq 7086 0 - Live 0xffffffbffc00a000
> root at zynqmp:~# rmmod gpio_zynq
> root at zynqmp:~# lsmod
>     Not tainted
> root at zynqmp:~# modprobe gpio_zynq
> [  246.924438] zynq-gpio ff0a0000.gpio: Unbalanced pm_runtime_enable!
> root at zynqmp:~# rmmod gpio_zynq
> root at zynqmp:~# lsmod
>     Not tainted
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Patch applied with Alex' ACK.

Yours,
Linus Walleij
