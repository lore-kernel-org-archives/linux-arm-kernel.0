From: steve.capper@linaro.org (Steve Capper)
Date: Wed, 26 Mar 2014 10:23:19 +0000
Subject: [PATCH V2 0/3] PTE fixes for arm and arm64
In-Reply-To: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140326102317.GA26040@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:38:51AM +0000, Steve Capper wrote:
> This series fixes a couple of problems that I have come across:
>  1) Some pte accessors for arm and arm64 can have their results
>     cancelled out by a downcast. This is addressed by the first two
>     patches.
> 
>  2) On arm with LPAE it is impossible to distinguish between clean
>     writable ptes and read only ptes. This is addressed by the third
>     patch.
> 
> As the third patch depends on the first patch, all three patches are
> bundled together in the same series.
> 
> I have reviewed Will and Russell's patch:
>  b6ccb9803e90 ("ARM: 7954/1: mm: remove remaining domain support
> 	from ARMv6")
> And I believe that the L_PTE_WRITE logic should be compatible with this
> patch. It applies cleanly and compiles; but I would be greatful if
> someone could please give it a test.

If there are no objections, I was going to put the following into
Russell's patch system:
	arm: mm: Double logical invert for pte accessors
	arm: mm: Switch back to L_PTE_WRITE

Cheers,
-- 
Steve
