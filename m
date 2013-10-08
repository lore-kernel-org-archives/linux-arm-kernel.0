From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 08 Oct 2013 23:37:58 +0200
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for
 BE correct operation
In-Reply-To: <20131007195525.f56083f0d91df6a6396cc494@linaro.org>
References: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
 <5252DA06.8000303@codethink.co.uk>
 <CAA3XUr2wYFL9WAQd9uAJSKK5KhWF3bPzYbh-3x=B3oLVXk79og@mail.gmail.com>
 <52533A70.5040705@ti.com>
 <20131007195525.f56083f0d91df6a6396cc494@linaro.org>
Message-ID: <52547B36.2060407@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/13 02:55, Kim Phillips wrote:
> On Mon, 7 Oct 2013 18:49:20 -0400
> Santosh Shilimkar<santosh.shilimkar@ti.com>  wrote:
>
>> On Monday 07 October 2013 12:37 PM, Victor Kamensky wrote:
>>> On 7 October 2013 08:57, Ben Dooks<ben.dooks@codethink.co.uk>  wrote:
>>>> On 07/10/13 17:48, Victor Kamensky wrote:
>>>> If you are booting on the Arndale board, is there a patch to mark
>>>> the relevant Exynos devices as BE capable?
>>>
>>> Arndale need massive fixes in their BSP layer to be endian agnostic
>>> ARM V7 platform. Unfortunate it is not as simple as with few others
>>> that already marked as BE capable.
>>>
>>> Please see
>>> https://git.linaro.org/gitweb?p=people/victor.kamensky/linux-linaro-tracking-be.git;a=shortlog;h=refs/heads/llct-be-topic
>>> Mostly it is __raw_xxx conversion to xxx_relaxed, but there are
>
> apologies if this was explained earlier in the thread, but what has
> __raw_xxx ->  xxx_relaxed have to do with endianness?  the relaxed
> accessor variants allow the compiler to reorder the instruction: it's
> got nothing to do with byte swapping the data, no?

the __raw have similar properties, however the readl/writel relaxed
are basically __raw with byte-swapping and no attempt to do any other
flush/drain/etc.

Thus I thought these would be the best ones to go for.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
