From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 07:53:14 +0200
Subject: [PATCH 3/4] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <1407946582-20927-4-git-send-email-grygorii.strashko@ti.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
 <1407946582-20927-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkdb-JYAu39wE9_Byeh4FUgitB_TJmr+HrNOGFSAu82wk7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 6:16 PM, Grygorii Strashko
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

OK overall I'm getting used to the idea of merging this.

> +#ifdef CONFIG_ARCH_KEYSTONE
(...)
> +#endif

Can you please remove the ifdefs. I don't mind the minimal growth
in footprint, and it makes the code simpler to read.

Yours,
Linus Walleij
