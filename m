From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 25 Nov 2014 10:54:14 -0800
Subject: [PATCHv6 6/8] arm64: use fixmap for text patching when text is RO
In-Reply-To: <20141125170445.GB21525@leverpostej>
References: <1416606645-25633-1-git-send-email-lauraa@codeaurora.org>
 <1416606645-25633-7-git-send-email-lauraa@codeaurora.org>
 <20141125170445.GB21525@leverpostej>
Message-ID: <5474D056.2050101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 9:04 AM, Mark Rutland wrote:
> Hi Laura,
>
> It looks like "early" means before we've set up the strict page
> permissions, though as far as I can tell the fixmap will already be
> available before we do any patching. Could we not always use the fixmap
> for patching? Then we only need the patch_{map,unmap} additions, and not
> the changes to distinguish the early cases.
>
>  From testing on Juno with defconfig, all of the early patches were
> avoidable NOP -> NOP changes as part of static key initialisation, which
> I think we can skip similarly to x86 (I'll send a patch shortly). All other
> patches were not early and went via the fixmap.
>
> Even with the avoidable NOP -> NOP patching I did not see a noticeable
> boot time difference from forcing the use of the fixmap.
>

I was basing it off of the arm version which needed the early option.
If arm64 doesn't need it I'll drop it.

> Thanks,
> Mark.
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
