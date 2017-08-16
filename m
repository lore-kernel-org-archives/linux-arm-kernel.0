From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Aug 2017 23:00:12 +0200
Subject: [PATCH] ARM: dts: stm32: use right compatible for stm32f469
In-Reply-To: <1501172847-31323-1-git-send-email-alexandre.torgue@st.com>
References: <1501172847-31323-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <CAK8P3a17b3viT=TduBXzV5LCpNO5-=vopq6u_nX7syHzyGsvAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 6:27 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> Currently, same stm32f429-pinctrl driver is used for stm32f429 and
> stm32f469. As pin map is different between those 2 MCUs,
> a stm32f469-pinctrl driver has been recently added.
> This patch
>  -allows to use stm32f469-pinctrl driver for stm32f469 boards
>  -reworks stm32 devicetree files to fit with stm32f429 / stm32f469
>
> In the same time it fixes an issue when only MACH_STM32F469 flag is
> selected in menuconfig.
>
> Fixes: d28bcd53fa90 ("ARM: stm32: Introduce MACH_STM32F469 flag")
> Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> ---
>
> Hi Arnd, Kevin and Olof,
>
> I send this series in 4.13-rcx cycle to fix d28bcd53fa90
> ("ARM: stm32: Introduce MACH_STM32F469 flag").
> This patch could look "huge" to fix the issue but I prefer to send
> a clean patch now that send a quick fix first and a DT rework in 4.14
> cycle.
> Let me know, if tou disagree with that.

Unfortunately I did not have this one on my radar for the 4.13 fixes,
as the subject looked rather innocent. My feeling is that we could have
done it earlier, but by now it's a bit late, and I'd rather have a quick
fix to merge for 4.13.

Doing this without merge conflicts unfortunately means that you have
to send two pull requests, with the 4.14 one based on the quick fix
for 4.13.

        Arnd
