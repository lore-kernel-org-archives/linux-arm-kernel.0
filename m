From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Sep 2014 10:30:20 +0200
Subject: [PATCH v3 3/4] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <1409763935-5713-4-git-send-email-grygorii.strashko@ti.com>
References: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
 <1409763935-5713-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkdbz3zXjVSRXtyE1A5-QjJ3dTiuCO=r=sFY1UZe+VnORgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 3, 2014 at 7:05 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> On Keystone SOCs, ARM host can send interrupts to DSP cores using the
> DSP GPIO controller IP. Each DSP GPIO controller provides 28 IRQ signals for
> each DSP core. This is one of the component used by the IPC mechanism used
> on Keystone SOCs.
>
> Keystone 2 DSP GPIO controller has specific features:
> - each GPIO can be configured only as output pin;
> - setting GPIO value to 1 causes IRQ generation on target DSP core;
> - reading pin value returns 0 - if IRQ was handled or 1 - IRQ is still
>   pending.
>
> This patch updates gpio-syscon driver to be reused by Keystone 2 SoCs,
> because the Keystone 2 DSP GPIO controller is controlled through Syscon
> devices and, as requested by Linus Walleij, such kind of GPIO controllers
> should be integrated with drivers/gpio/gpio-syscon.c driver.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  .../devicetree/bindings/gpio/gpio-dsp-keystone.txt | 39 ++++++++++++++++++++++

Rob, can you look at these bindings?

I suspect they may fall under your category of "not a real device, but
leaking Linux implementation internals".

Yours,
Linus Walleij
