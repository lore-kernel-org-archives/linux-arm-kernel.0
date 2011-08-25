From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Wed, 24 Aug 2011 23:09:13 -0400
Subject: [PATCH 10/10] ARM: perf: add mode exclusion for Cortex-A15 PMU
In-Reply-To: <CAKHPGBZ1eXzhsjFvLt_KTYKsR_OH7rgbeSGedTY5g8dhi90uzQ@mail.gmail.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
	<1312823771-9952-11-git-send-email-will.deacon@arm.com>
	<CAKHPGBZ1eXzhsjFvLt_KTYKsR_OH7rgbeSGedTY5g8dhi90uzQ@mail.gmail.com>
Message-ID: <4E55BCD9.7050703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Will,

> From: Will Deacon <will.deacon@arm.com>
> 
> The Cortex-A15 PMU implements the PMUv2 specification and therefore
> has support for some mode exclusion.
> 
> This patch adds support for excluding user, kernel and hypervisor counts
> from a given event.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---


--8<---

> +
> +/*
> + * Event filters for PMUv2
> + */
> +#define        ARMV7_EXCLUDE_PL1       (1 << 31)
> +#define        ARMV7_EXCLUDE_USER      (1 << 30)
> +#define        ARMV7_INCLUDE_HYP       (1 << 27)
> +

This mode exclusion stuff is confusing me.
For exclude user mode, shouldn't PMXEVTYPER[PL1,U] = 0b11

With this patch the counters will spin with secure mode activity as well,
if exclude user mode is selected ?

/me goes to bother the h/w guys.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
