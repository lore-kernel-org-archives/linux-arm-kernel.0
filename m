From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jul 2012 10:07:47 -0600
Subject: [PATCH] clk: Fix cached parent ptrs allocation
In-Reply-To: <1341407737-1016-1-git-send-email-pgaikwad@nvidia.com>
References: <1341407737-1016-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FF5BBD3.6080704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2012 07:15 AM, Prashant Gaikwad wrote:
> Compiler optimizes code someway that even if clk->parents
> is not NULL it tries to allocate parents array. Change the
> condition so that compiler does not optimize it in wrong
> way.

If simply inverting the if test and swapping the if/else blocks solves
some problem, that sounds like a compiler bug that we need to track down
and file/fix.

> Also, initialize i to num_parents to make sure parent
> is searched using parent name if parents is NULL.

Are you sure the change to initialize i wasn't all that was required to
solve the problem though? Mike has applied a patch for this that'll be
applied to 3.5-rcX and hence trickle into 3.6.
