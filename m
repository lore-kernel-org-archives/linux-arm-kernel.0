From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 09:37:19 +0100
Subject: [PATCH] pinctrl: mvebu: add suspend/resume support to Armada XP
 pinctrl driver
In-Reply-To: <1426761047-3103-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1426761047-3103-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdZ_2FJLJJaDuqw=9cxxJwacz06KssfSK_HVg2jZ6E-6eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 11:30 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit adds suspend/resume support to the Armada XP pinctrl
> driver, by simply saving and restoring the MPP registers.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Patch applied, but:

>  static void __iomem *mpp_base;
> +static u32 *mpp_saved_regs;

I didn't notice this singleton design pattern in this driver before :(
I see the legacy Dove driver have a few more.

Can we have a mvebu refactoring patch bringing these things into a state
container? Like a per-subdriver kmalloc:ed struct foo_state {}?

Yours,
Linus Walleij
