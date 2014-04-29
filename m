From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 29 Apr 2014 12:43:56 +0100
Subject: [PATCH v2 00/10] arm64: UEFI support
In-Reply-To: <20140429102817.GE17007@arm.com>
References: <1398442154-19974-1-git-send-email-leif.lindholm@linaro.org>
 <20140429102817.GE17007@arm.com>
Message-ID: <20140429114356.GK26088@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Pulling in Peter and Stephen)

On Tue, 29 Apr, at 11:28:17AM, Catalin Marinas wrote:
> 
> The patches look fine to me, they've been through several rounds of
> review already. How do we propose these get merged as the series
> contains both generic and arm64 patches? And there are dependencies
> already in linux-next.
> 
> Are the EFI patches in -next pulled from some non-rebaseable branch?

Peter suggsted a plan when he took the generic EFI stuff that's in tip
(and hence currently in linux-next),

  It doesn't hurt to inform Stephen, although I think it will simply fall
  out automatically since he uses git to merge and git will recognize the
  graph.

  During the merge window, it means they should not push their patches
  until Linus has accepted the precondition patches from the tip tree.
  Since Ingo and I try to push most of the tip tree as early as possible
  in the merge window, this is usually not a problem.

So we currently have the prerequisites in tip/x86/efi, and assuming that
this 10-patch series gets merged into a single branch somewhere, things
should work automatically for linux-next.

It may be prudent to negotiate a plan now for when the merge window
opens because, as Peter mentions above, the stuff in tip/x86/efi needs
to be merged by Linus first to avoid build breakage with the arm64
stuff.

-- 
Matt Fleming, Intel Open Source Technology Center
