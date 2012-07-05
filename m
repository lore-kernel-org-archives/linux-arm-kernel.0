From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 5 Jul 2012 06:40:46 +0530
Subject: [PATCH] clk: Fix cached parent ptrs allocation
In-Reply-To: <1341407737-1016-1-git-send-email-pgaikwad@nvidia.com>
References: <1341407737-1016-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FF4E996.7010003@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012 06:45 PM, Prashant Gaikwad wrote:
> Compiler optimizes code someway that even if clk->parents
> is not NULL it tries to allocate parents array. Change the
> condition so that compiler does not optimize it in wrong
> way.
>
> Also, initialize i to num_parents to make sure parent
> is searched using parent name if parents is NULL.
>
> Signed-off-by: Prashant Gaikwad<pgaikwad@nvidia.com>
> ---
> Mike,
>
> There could be some other way to fix problem. I have not
> debugged it in detail but I think this simple change should do.
Mike,

Please ignore this patch as Rajendra has already sent patch to fix.

http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commitdiff;h=863b13271f1608ab3af6f7a371047d9a66693e38

>   drivers/clk/clk.c |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)
>
