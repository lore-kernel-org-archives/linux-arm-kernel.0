From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jul 2015 10:00:21 +0200
Subject: [PATCH] pinctrl: qcom: Hook pm_power_down for shutdown support
In-Reply-To: <1436231370-18301-1-git-send-email-sboyd@codeaurora.org>
References: <1436231370-18301-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CACRpkdbci5=1mUEsfs79TJ7W5tS=pDAg_u=He0_5bP7ooyrVNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 7, 2015 at 3:09 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Assign pm_power_off() if we have the PS_HOLD functionality so
> that we can properly shutdown the SoC. Otherwise, shutdown won't
> do anything besides put the CPU into a tight loop. Unfortunately,
> we have to use a singleton here because pm_power_off() doesn't
> take any arguments. Fortunately there's only one instance of the
> pinctrl device on a running system so this isn't a problem.
>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Patch applied with Bj?rn's ACK.

Yours,
Linus Walleij
