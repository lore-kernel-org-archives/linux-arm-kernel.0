From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 13 Jul 2015 15:59:57 -0700
Subject: [PATCH] pinctrl: qcom: Hook pm_power_down for shutdown support
In-Reply-To: <1436231370-18301-1-git-send-email-sboyd@codeaurora.org>
References: <1436231370-18301-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150713225957.GF15178@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 06 Jul 18:09 PDT 2015, Stephen Boyd wrote:

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


I do find it odd that there's generic handling for restart but only the
crude way pm_power_off to shut the system down... But this seems to be
the way it should be done...

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
