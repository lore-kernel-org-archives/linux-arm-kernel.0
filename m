From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jan 2018 02:01:36 +0100
Subject: [PATCH 01/14] mmc: mmci: Don't pretend all variants to have
 MMCIMASK1 register
In-Reply-To: <1515759368-16946-2-git-send-email-patrice.chotard@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-2-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdb3iS7FuGbC3n9xpazvtEW7AjbLKNZ5vKpJAv2D8c4sbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 1:15 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> Two mask registers are used in order to select which events have to
> actually generate an interrupt on each IRQ line.
>
> It seems that in the single-IRQ case it's assumed that the IRQs lines
> are simply OR-ed, while the two mask registers are still present. The
> driver still programs the two mask registers separately.
>
> However the STM32 variant has only one IRQ, and also has only one mask
> register.
>
> This patch prepares for STM32 variant support by making the driver using
> only one mask register.
>
> This patch also optimize the MMCIMASK1 mask usage by caching it into
> host->mask1_reg which avoid to read it into mmci_irq().
>
> Tested only on STM32 variant. RFT for variants other than STM32
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
