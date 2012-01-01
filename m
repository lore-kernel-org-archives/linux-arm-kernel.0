From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Jan 2012 15:15:51 +0100
Subject: [PATCH v3 1/3] pinctrl: enable pinmux for mmp series
In-Reply-To: <1324541855-19911-2-git-send-email-haojian.zhuang@marvell.com>
References: <1324541855-19911-1-git-send-email-haojian.zhuang@marvell.com>
 <1324541855-19911-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdbvta3chYeMS=J94ehaOcEXp1OBnU74qSSCAO--PbehLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 9:17 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> Support PXA168/PXA910/MMP2 pinmux. Now only support function switch.

(...)

> +config PINCTRL_PXA3xx
> + ? ? ? bool
> + ? ? ? select PINMUX
> +

Good,

> +config PINMUX_MMP2
> + ? ? ? bool "MMP2 pinmux driver"
> + ? ? ? depends on ARCH_MMP
> + ? ? ? select PINCTRL_PXA3xx
> + ? ? ? select PINCONF
> +
> +config PINMUX_PXA168
> + ? ? ? bool "PXA168 pinmux driver"
> + ? ? ? depends on ARCH_MMP
> + ? ? ? select PINCTRL_PXA3xx
> + ? ? ? select PINCONF
> +
> +config PINMUX_PXA910
> + ? ? ? bool "PXA910 pinmux driver"
> + ? ? ? depends on ARCH_MMP
> + ? ? ? select PINCTRL_PXA3xx
> + ? ? ? select PINCONF
> +

Please rename these PINCTRL_* too.

Thanks,
Linus Walleij
