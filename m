From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 5 Jul 2012 22:51:17 +0530
Subject: [PATCH] clk: Fix cached parent ptrs allocation
In-Reply-To: <4FF5BBD3.6080704@wwwdotorg.org>
References: <1341407737-1016-1-git-send-email-pgaikwad@nvidia.com>
 <4FF5BBD3.6080704@wwwdotorg.org>
Message-ID: <4FF5CD0D.7030902@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012 09:37 PM, Stephen Warren wrote:
> On 07/04/2012 07:15 AM, Prashant Gaikwad wrote:
>> Compiler optimizes code someway that even if clk->parents
>> is not NULL it tries to allocate parents array. Change the
>> condition so that compiler does not optimize it in wrong
>> way.
> If simply inverting the if test and swapping the if/else blocks solves
> some problem, that sounds like a compiler bug that we need to track down
> and file/fix.
>
>> Also, initialize i to num_parents to make sure parent
>> is searched using parent name if parents is NULL.
> Are you sure the change to initialize i wasn't all that was required to
> solve the problem though? Mike has applied a patch for this that'll be
> applied to 3.5-rcX and hence trickle into 3.6.
Just initializing i does not fix problem. The patch Mike has applied 
does two things
1. remove warning for uninitialized i
2. invert the if test
