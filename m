From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 18 Sep 2014 15:47:20 -0700
Subject: [PATCH] pinctrl: qcom: use restart_notifier mechanism for ps_hold
In-Reply-To: <1411079579-10172-1-git-send-email-joshc@codeaurora.org>
References: <1411079579-10172-1-git-send-email-joshc@codeaurora.org>
Message-ID: <11F1E440-6BD4-46F1-A399-4334FBA2C3B6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 18, 2014, at 3:32 PM, Josh Cartwright <joshc@codeaurora.org> wrote:

> By converting to the restart_notifier mechanism for restart, we allow
> for other mechanisms, like the watchdog, to be used for restart in the
> case where PS_HOLD has failed to reset the chip.
> 
> Choose priority 128, as according to documentation, this mechanism "is
> sufficient to restart the entire system?.

Will we use a higher priority for watchdog?  or how would we fail over to watchdog?

> 
> Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
> drivers/pinctrl/qcom/pinctrl-msm.c | 38 ++++++++++++++++++++++++++------------
> 1 file changed, 26 insertions(+), 12 deletions(-)
> 

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
