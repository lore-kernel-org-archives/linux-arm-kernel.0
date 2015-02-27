From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Feb 2015 15:23:57 -0600
Subject: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
In-Reply-To: <20150227200719.GE1678@linaro.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
 <24986C4E-2DED-456F-A1D3-E52037540E01@codeaurora.org>
 <20150226222035.GB1250@linaro.org> <20150227200719.GE1678@linaro.org>
Message-ID: <0A05D548-BD53-4A33-A5C7-F396E1915FFA@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 27, 2015, at 2:07 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Thu, Feb 26 2015 at 15:20 -0700, Lina Iyer wrote:
>> On Thu, Feb 26 2015 at 15:10 -0700, Kumar Gala wrote:
>>> 
>>> On Feb 25, 2015, at 4:54 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>> 
>>>> Hi,
>>>> 
>>>> These patches used to be part of my cpuidle patchset, think these can go in
>>>> independently.
>>>> 
>>>> The patches do the following -
>>>> 
>>>> 1. Add QCOM Secure Monitor specific enumeration for warm boot on qcom targets
>>>> 2. Add an API to set up the warmboot address. Consolidate the warm boot flags
>>>> into the implementation file
>>>> 
>>>> Thanks,
>>>> Lina
>>>> 
>>>> Lina Iyer (2):
>>>> ARM: qcom: Add SCM warmboot flags for quad core targets.
>>>> qcom: scm: Add scm_set_warm_boot_addr function
>>>> 
>>>> arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>> arch/arm/mach-qcom/scm-boot.h |  5 +++--
>>>> 2 files changed, 41 insertions(+), 2 deletions(-)
>>> 
>>> Lina,
>>> 
>>> Do you mind rebasing these patches on my recent SCM cleanup set.  You find it at:
>>> 
>>> git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git qcom/scm-cleanup
>>> 
>> 
>> Sure. As suggested by Kevin H, I will merge the two patches and rebase
>> on top yours and resubmit.
>> 
> I have rebased on top of yours. I will send it shortly. But please note
> that source "driver/firmware/Kconfig" is missing in arch/arm/Kconfig for
> the driver/firmware to build.

I?ll fix this.

> 
> Also, I have a dependency on the scm_call_atomic() api introduced by
> Stephen [1] for cpuidle. When can I expect to see that?
> 
> [1]. https://lkml.org/lkml/2014/8/4/765

Please add the patch to your patchset.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
