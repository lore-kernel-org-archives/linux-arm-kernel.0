From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jul 2017 15:36:55 +0200
Subject: [PATCH 2/3] [v3] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1501179565-26466-3-git-send-email-timur@codeaurora.org>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-3-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdZj+tnMcEpic6PrQS-qMJDodmc_uFJVudxc=USCTXpyKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 8:19 PM, Timur Tabi <timur@codeaurora.org> wrote:

> To support sparse GPIO maps, pinctrl-msm client drivers can specify
> that a given GPIO has a pin count of zero.  These GPIOs will be
> considered "hidden".  Any attempt to claim the GPIO will fail, and they
> will not be listed in debugfs.
>
> During a kexec shutdown, machine_kexec_mask_interrupts() will attempt
> to disable all IRQs, even those that aren't enabled.  This includes
> GPIOs that are unavailable (npins == 0), so add a check to the irq mask
> and unmask functions.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

I'm waiting for Bj?rn's review of the two remaining patches.

Yours,
Linus Walleij
