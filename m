From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 29 Sep 2014 09:12:26 -0400
Subject: [PATCH v3] clocksource: arch_timer: Allow the device tree to
 specify the physical timer
In-Reply-To: <1410454801-14231-1-git-send-email-dianders@chromium.org>
References: <1410454801-14231-1-git-send-email-dianders@chromium.org>
Message-ID: <54295ABA.1010806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 09/11/2014 01:00 PM, Doug Anderson wrote:
> Some 32-bit (ARMv7) systems are architected like this:
> 
> * The firmware doesn't know and doesn't care about hypervisor mode and
>   we don't want to add the complexity of hypervisor there.
> 
> * The firmware isn't involved in SMP bringup or resume.
> 
> * The ARCH timer come up with an uninitialized offset between the
>   virtual and physical counters.  Each core gets a different random
>   offset.
> 
> * The device boots in "Secure SVC" mode.

I believe this can safely be detected by whether a write to CNTFRQ succeeds
(handling the UNDEF on failure). I've tested this approach in what I've
determined to be the 19 valid combinations of the following options.

* AArch64 EL3, AArch32 EL3, no EL3
* AArch64 EL2, AArch32 EL2, no EL2
* Start in SVC_N, SVC_S, HYP_N, MON_S

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
