From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Nov 2017 09:46:17 -0800
Subject: [PATCH 3/4] [v6] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <dff45d26-e9df-6a4f-00a9-7d9ec5cbdf49@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <1510096056-13765-4-git-send-email-timur@codeaurora.org>
 <20171117024332.GU11955@codeaurora.org>
 <dff45d26-e9df-6a4f-00a9-7d9ec5cbdf49@codeaurora.org>
Message-ID: <20171117174617.GA29777@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16, Timur Tabi wrote:
> On 11/16/17 8:43 PM, Stephen Boyd wrote:
> >>Most access to unavailable GPIOs can be blocked via the gpio_chip.request
> >>function.  The one exception is when gpiochip_add_data() scans all of
> 
> >If patch 1 is applied is this statement still true?
> 
> Nope.
> 

Ok. So what's the point of this patch then? Put another way, is
there some path that doesn't request the gpio still even with
patch 1 applied?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
