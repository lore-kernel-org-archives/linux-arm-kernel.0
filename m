From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Sep 2011 22:05:32 +0100
Subject: [PATCH][RESEND] ARM: cache: detect PIPT I-cache using CTR
In-Reply-To: <1316723111-10473-1-git-send-email-will.deacon@arm.com>
References: <1316723111-10473-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110922210532.GE8072@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 09:25:11PM +0100, Will Deacon wrote:
> The Cache Type Register L1Ip field identifies I-caches with a PIPT
> policy using the encoding 11b.
> 
> This patch extends the cache policy parsing to identify PIPT I-caches
> correctly and prevent them from being treated as VIPT aliasing in cases
> where they are sufficiently large.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> KernelVersion: 3.1-rc3
> ---
> 
> Russell - this has been sitting in the patch system as 7062/1 for a
> while now. Please can you add it to your for-next branch for 3.2?

Well... I don't apply any patch to the for-next branch itself - that'd
be madness as the branch is re-built from the topic branches and it's
just a convenience for SFR so I don't have to keep on listing out all
the individual branches for him to pull.

Last time I tried to apply it to my misc branch (which was 3.1-rc1 based)
it wouldn't apply.  I've since rebased that branch (for various reasons)
and it now appears to apply cleanly, so I can _only_ _now_ apply it.
