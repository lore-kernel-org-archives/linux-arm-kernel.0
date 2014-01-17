From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 17 Jan 2014 12:46:23 -0500
Subject: [PATCH] usb: phy: msm: fix compilation errors when
 !CONFIG_PM_SLEEP
In-Reply-To: <1389979580-14812-1-git-send-email-joshc@codeaurora.org>
References: <20140117132232.GC15937@n2100.arm.linux.org.uk>
 <1389979580-14812-1-git-send-email-joshc@codeaurora.org>
Message-ID: <52D96C6F.7090608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On 01/17/2014 12:26 PM, Josh Cartwright wrote:

[...]

> @@ -440,7 +414,32 @@ static int msm_otg_reset(struct usb_phy *phy)
>  #define PHY_SUSPEND_TIMEOUT_USEC	(500 * 1000)
>  #define PHY_RESUME_TIMEOUT_USEC	(100 * 1000)
>  
> -#ifdef CONFIG_PM_SLEEP
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)

Why not #ifdef CONFIG_PM here?

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
