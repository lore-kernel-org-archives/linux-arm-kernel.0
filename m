From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Dec 2017 14:37:00 -0800
Subject: [PATCH 1/3] [v2] Revert "gpio: set up initial state from
 .get_direction()"
In-Reply-To: <1513189818-7384-2-git-send-email-timur@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-2-git-send-email-timur@codeaurora.org>
Message-ID: <20171213223700.GQ7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13, Timur Tabi wrote:
> This reverts commit 72d3200061776264941be1b5a9bb8e926b3b30a5.
> 
> We cannot blindly query the direction of all GPIOs when the pins are
> first registered.  The get_direction callback normally triggers a
> read/write to hardware, but we shouldn't be touching the hardware for
> an individual GPIO until after it's been properly claimed.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
