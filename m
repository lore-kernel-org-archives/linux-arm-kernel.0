From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Fri, 19 Sep 2014 17:58:15 +0530
Subject: [PATCH] pinctrl: qcom: use restart_notifier mechanism for ps_hold
In-Reply-To: <1411079579-10172-1-git-send-email-joshc@codeaurora.org>
References: <1411079579-10172-1-git-send-email-joshc@codeaurora.org>
Message-ID: <541C215F.5050009@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

Tested this on IFC6410.
Tested-by: pramod.gurav at smartplayin.com

On Friday 19 September 2014 04:02 AM, Josh Cartwright wrote:
> By converting to the restart_notifier mechanism for restart, we allow
> for other mechanisms, like the watchdog, to be used for restart in the
> case where PS_HOLD has failed to reset the chip.
> 
> Choose priority 128, as according to documentation, this mechanism "is
> sufficient to restart the entire system".
> 
> Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
