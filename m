From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2017 14:45:50 +0000
Subject: [PATCH] arm64: Fix the kernel panic() on QDF2400 platform
In-Reply-To: <1487819448-8715-1-git-send-email-shankerd@codeaurora.org>
References: <1487819448-8715-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20170223144550.GE27512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 09:10:48PM -0600, Shanker Donthineni wrote:
> The commit 38fd94b0 'arm64: Work around Falkor erratum 1003' has
> been added to fix the hardware bug but causing a system crash.
> The value of the register x1 which contains 'struct mm_struct *'
> should be preserved inside macro pre_ttbr0_update_workaround.
> 
> Macro pre_ttbr0_update_workaround expects 2nd and 3rd arguments
> are temporary registers. Don't clobber register x1, Otherwise
> the next load operation 'mmid x1 x1' access the invalid address.

Whilst I'm pleased that you've sent a fix (and I'll pick it up), I have
to ask... did anybody actually test the original patch? If so, why wasn't
this found earlier?

Will
