From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 14 Jul 2017 10:35:55 -0700
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <be10e365-95fa-dfa4-9900-4af05d8f41a9@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-2-git-send-email-timur@codeaurora.org>
 <20170714164455.GM20973@minitux>
 <be10e365-95fa-dfa4-9900-4af05d8f41a9@codeaurora.org>
Message-ID: <20170714173555.GP20973@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 14 Jul 10:01 PDT 2017, Timur Tabi wrote:

> On 07/14/2017 11:44 AM, Bjorn Andersson wrote:
> > We would have to drop the "const" on the groups arrays of the other
> > platform in order to use this, but I don't have a better suggestion at
> > this time.
> 
> Why?  I don't modify any data in this patch, and I build just fine with
> these options enabled:
> 
> CONFIG_PINCTRL_MSM8916=y
> CONFIG_PINCTRL_MSM8994=y
> CONFIG_PINCTRL_MSM8996=y
> CONFIG_PINCTRL_QDF2XXX=m
> 

What I mean is that if we want to specify that any pin of those drivers
are locked down we would make npins = 0.

But as this is a system configuration thing this information would
preferably be injected in runtime (like you do), but the
soc_data->groups arrays are currently all const (see e.g.
msm8x74_groups), so we can't change npins in runtime.


But I think this is fine for now.

Regards,
Bjorn
