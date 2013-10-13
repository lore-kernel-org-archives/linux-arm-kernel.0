From: olof@lixom.net (Olof Johansson)
Date: Sun, 13 Oct 2013 16:02:41 -0700
Subject: [GIT PULL] Samsung fixes-1 for v3.12
In-Reply-To: <525B1722.5060001@samsung.com>
References: <525B1722.5060001@samsung.com>
Message-ID: <CAOesGMirL+uR0xL9o0oqhfVa4KKsDeaCjkJyarAJr5vmZPg4Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 13, 2013 at 2:56 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Alexander Shiyan (1):
>       ARM: SAMSUNG: Fix switching FIFO in arch_enable_uart_fifo function

What's the regression that this is fixing? As far as I can tell, the
code has been the same since 2008. Or did something surrounding it
change?

>
> Bartlomiej Zolnierkiewicz (1):
>       ARM: dts: fix PL330 MDMA1 address in DT for Universal C210 board
>
> Jingoo Han (1):
>       ARM: dts: Remove DP PHY node from exynos5250.dtsi

You are sending this in pretty late. Please be careful about conflicts
due to this late revert, in particular if you plan on re-introducing
something in 3.13.

> Tomasz Figa (1):
>       ARM: dts: Work around lack of cpufreq regulator lookup for
> exynos4210-origen and trats boards
>
> Youngmin Nam (1):
>       ARM: dts: Fix a typo on Exynos5440 DTS files

This is a bad patch subject, it can be way more specific. Also, this
is a good reason not to have these elaborate bootargs in the DTS, in
particular for modern platforms -- the bootargs should come from
firmware for your platform.


-Olof
