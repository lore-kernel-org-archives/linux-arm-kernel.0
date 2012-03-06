From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Mar 2012 11:08:25 +0100
Subject: [PATCH V2 3/3] gpio: tegra: Hide tegra_gpio_enable/disable()
In-Reply-To: <1330993336-9538-3-git-send-email-swarren@nvidia.com>
References: <1330993336-9538-1-git-send-email-swarren@nvidia.com>
 <1330993336-9538-3-git-send-email-swarren@nvidia.com>
Message-ID: <CACRpkdaZ8EBBwGis4Odh1EZS=waB0nCSZ-mtUHx48ywE81T5Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 1:22 AM, Stephen Warren <swarren@nvidia.com> wrote:

> Recent pinctrl discussions concluded that gpiolib APIs should in fact do
> whatever is required to mux a GPIO onto pins, by calling pinctrl APIs if
> required. This change implements this for the Tegra GPIO driver, and removes
> calls to the Tegra-specific APIs from drivers and board files.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Merging note: The first two (or at least the 2nd) patches can go through
> the pinctrl susbsystem without issue.

I will give Grant a chance to comment on the GPIO interaction
doc atleast, then I'll apply them.

> This patch should probably be taken
> through the Tegra tree. Once patch 2 is in pinctrl, and considered stable,
> I can just use that as a dependency for the branch containing this Tegra
> patch. I assume that this series will go into 3.5 not 3.4, but I'm willing
> to be surprised:-)

Should be possible if my pinctrl-tegra-for-next-diet branch is considered
stable and could be pulled into the Tegra tree for further augmenting
by this and other patches!

But I guess you'd need to merge some stable development base
for the rest of the pinctrl stuff as well, shall I freeze the for-next
branch with tegra diet stuff merged on top now? I can promise
to just add new patches on top of that if it helps you.

Is Olof the one to ask?

Yours,
Linus Walleij
