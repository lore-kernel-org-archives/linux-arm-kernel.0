From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  9 Feb 2018 12:16:01 +0000
Subject: [PATCH 1/2] arm64: capabilities: Allow flexibility in scope
In-Reply-To: <20180208173229.GA5862@e103592.cambridge.arm.com>
References: <20180208173229.GA5862@e103592.cambridge.arm.com>
Message-ID: <20180209121605.14091-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> I'm not sure we need extra comments or documentation; I just want
>>> to check that I've understood the patch correctly.
>>
>> So, would you prefer this split to the original patch ?
> 
> I think splitting out this patch (1/2) makes sense.
> 
> 
> For the second part (2/2) of the split, I still find that hard to
> review.  The commit message suggests trivially obvious refactoring
> only, but I think there are three things going on:
> 
>   1) moving functions around (with the intention of merging them)
>   2) merging functions together
>   3) other miscellaneous bits of refactoring, and cleanups that become
>      "obvious" after steps (1) and (2).
> 
> The refactoring is likely straightfoward, but the resulting diff is
> not (at least, I struggle to read it).
> 
> Could you split the second part along the lines if (1)..(3) above?
> I think that would make for much easier review.  (Sorry to be a pain!)
> 
> Also, the second patch leaves at least one function that does nothing
> except call a second function that has no other caller.  It may do
> no harm to remove and inline any such function.  (Falls under (3),
> I guess.)
> 

Here it goes...

Suzuki K Poulose (4):
  arm64: capabilities: Prepare for grouping features and errata work
    arounds
  arm64: capabilities: Split the processing of errata work arounds
  arm64: capabilities: Allow features based on local CPU scope
  arm64: capabilities: Group handling of features and errata workarounds

 arch/arm64/kernel/cpufeature.c | 91 ++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

-- 
2.14.3
