From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Dec 2017 14:37:38 -0800
Subject: [PATCH 2/3] [v8] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1513189818-7384-3-git-send-email-timur@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-3-git-send-email-timur@codeaurora.org>
Message-ID: <20171213223738.GR7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, Timur Tabi wrote:
> pinctrl-msm only accepts an array of GPIOs from 0 to n-1, and it expects
> each group to support have only one pin (npins == 1).
> 
> We can support "sparse" GPIO maps if we allow for some groups to have zero
> pins (npins == 0).  These pins are "hidden" from the rest of the driver
> and gpiolib.
> 
> Access to unavailable GPIOs is blocked via a request callback.  If the
> requested GPIO is unavailable, -EACCES is returned, which prevents
> further access to that GPIO.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
