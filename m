From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Mar 2015 22:55:23 -0700
Subject: [PATCH 0/3] arm: msm: Use timer DT node for qcom watchdog config
In-Reply-To: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
References: <1424485176-8348-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150327055523.GC5625@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20, Mathieu Olivari wrote:
> This change is done as a follow-up to the following thread:
> https://lkml.org/lkml/2014/10/1/436
> 
> qcom-wdt is currently assuming the presence of a dedicated node in DT
> to gets its configuration. However, on msm architecture, the watchdog is
> usually part of the timer block. So this patch-set is changing the driver
> and slightly enhancing the timer DT bindings to provide the relevant clocks
> and interrupts.
> 
> Mathieu Olivari (3):
>   watchdog: qcom: use timer devicetree binding
>   ARM: qcom: add description of KPSS WDT for IPQ8064
>   ARM: msm: add watchdog entries to DT timer binding doc
> 
>  Documentation/devicetree/bindings/arm/msm/timer.txt | 16 +++++++++++++---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi                 | 14 +++++++++++++-
>  drivers/watchdog/qcom-wdt.c                         | 21 +++++++++++++++------
>  3 files changed, 41 insertions(+), 10 deletions(-)
> 

Can this patchset be applied? Or should we resend with collected
acks?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
