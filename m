From: apinski@caviumnetworks.com (Andrew Pinski)
Date: Mon, 24 Apr 2017 11:49:10 -0700
Subject: [PATCH 1/2] arm64:vdso: Rewrite gettimeofday into C.
In-Reply-To: <20170424152106.GG25449@e104818-lin.cambridge.arm.com>
References: <1492991221-5156-1-git-send-email-apinski@cavium.com>
 <20170424152106.GG25449@e104818-lin.cambridge.arm.com>
Message-ID: <31273d31-57a8-2bfd-283f-025d3a88c96f@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2017 8:21 AM, Catalin Marinas wrote:
> On Sun, Apr 23, 2017 at 04:47:00PM -0700, Andrew Pinski wrote:
>> This allows the compiler to optimize the divide by 1000.
>> And remove the other divide.
>>
>> On ThunderX, gettimeofday improves by 32%.  On ThunderX 2,
>> gettimeofday improves by 18%.
> Is this with or without the second patch (removing the ISB)?

Hi Caralin,
   This is without the second patch that removes the ISB.  Maybe I 
should not have sent them as the same patch set to make it clear that 
way.  As I tried to make a mention of, the improvement is the compiler 
not outputting the udiv instruction for the division by 1000.    I 
should also mention I tested this patch on a softiron using GCC 4.8.5 
(SUSE's default compiler) and the performance was the same; GCC 4.8.5 
emits udiv still in this case.  I did not try a newer compiler to see 
the performance there.

Thanks,
Andrew Pinski

>
