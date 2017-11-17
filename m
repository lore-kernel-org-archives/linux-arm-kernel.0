From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Nov 2017 13:42:07 -0800
Subject: [PATCH 3/4] [v6] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <2671cc63-6c8b-987d-ceb3-bd158bb9d1c3@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <1510096056-13765-4-git-send-email-timur@codeaurora.org>
 <20171117024332.GU11955@codeaurora.org>
 <dff45d26-e9df-6a4f-00a9-7d9ec5cbdf49@codeaurora.org>
 <20171117174617.GA29777@codeaurora.org>
 <2671cc63-6c8b-987d-ceb3-bd158bb9d1c3@codeaurora.org>
Message-ID: <20171117214207.GA18379@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17, Timur Tabi wrote:
> On 11/17/2017 11:46 AM, Stephen Boyd wrote:
> >On 11/16, Timur Tabi wrote:
> >>On 11/16/17 8:43 PM, Stephen Boyd wrote:
> >>>>Most access to unavailable GPIOs can be blocked via the gpio_chip.request
> >>>>function.  The one exception is when gpiochip_add_data() scans all of
> >>
> >>>If patch 1 is applied is this statement still true?
> >>
> >>Nope.
> >>
> >
> >Ok. So what's the point of this patch then? Put another way, is
> >there some path that doesn't request the gpio still even with
> >patch 1 applied?
> 
> This patch is how the pinctrl-msm driver actually reports the sparse
> GPIO map.
> 
> Patch 1 prevents gpiolib from accessing GPIOs that haven't been
> properly requested.
> 
> Patch 2 adds an infrastructure for sparse GPIO maps
> 
> Patch 3 updates pinctrl-msm to use that expose that new infrastructure
> 
> Patch 4 updates pinctrl-qdf2xxx to work with the new feature in pinctrl-msm
> 

Ok. What path doesn't request the gpio though? If we don't have a
path that fails to request the gpio before using it then I don't
see the need for this patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
