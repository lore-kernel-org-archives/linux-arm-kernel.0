From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 16 Nov 2017 20:58:57 -0600
Subject: [PATCH 3/4] [v6] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <20171117024332.GU11955@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <1510096056-13765-4-git-send-email-timur@codeaurora.org>
 <20171117024332.GU11955@codeaurora.org>
Message-ID: <dff45d26-e9df-6a4f-00a9-7d9ec5cbdf49@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/17 8:43 PM, Stephen Boyd wrote:
>> Most access to unavailable GPIOs can be blocked via the gpio_chip.request
>> function.  The one exception is when gpiochip_add_data() scans all of

> If patch 1 is applied is this statement still true?

Nope.

>> the GPIOs without "requesting" them.  To cover this case,
> s/GPIOs/GPIOs for their direction/ perhaps?

Ok.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
