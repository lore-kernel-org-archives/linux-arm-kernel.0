From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 8 Mar 2017 10:50:03 -0600
Subject: [PATCH] arm64: mm: Add workaround for Qualcomm Technologies
 Falkor erratum E1029
In-Reply-To: <20170303122703.GA12945@leverpostej>
References: <1488500355-7199-1-git-send-email-timur@codeaurora.org>
 <20170303122703.GA12945@leverpostej>
Message-ID: <646fee0b-13b4-85d7-63d5-26e450bd2e2d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 06:27 AM, Mark Rutland wrote:
> The idle loop is not the only place where WFI can occur.
>
> Notably, firmware is within its rights to use WFI, as is userspace given
> that SCTLR_EL1.nTWI is set at boot time. So IIUC, userspace can deadlock
> a core, which makes this sound very serious.
>
> Can this *only* happen for the PMU interrupt?
>
> I assume that as mentioned for other Falkor workarounds "the affected
> chips are pre-production and are only available to select customers for
> a limited time"?
>
> Given that we're having to a fair amount of the arm64 core code, for
> parts that QC don't even intend to support long term, it's increasingly
> difficult to care about this upstream.
>
> Are additional workarounds necessary for these parts?

We are withdrawing this patch.  We acknowledge your concerns.

There are other errata affected by this patch that we have submitted, but 
this is the only one that is unacceptable.  The affected chips are 
pre-production, and so we'll just keep this work-around internally until 
those chips have been replaced.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
