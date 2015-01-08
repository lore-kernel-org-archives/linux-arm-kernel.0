From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 08 Jan 2015 14:25:57 -0800
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <20150108221356.GD12302@n2100.arm.linux.org.uk>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
 <54AEA7E0.5070101@gmail.com>
 <CADtm3G5Ebf6WkHG3fyiY3pm7fEBBNoW3DDEEwpvBXGj0fVE6jQ@mail.gmail.com>
 <3495606.iOQOj3bxPc@wuerfel> <20150108221356.GD12302@n2100.arm.linux.org.uk>
Message-ID: <54AF03F5.9030907@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/15 14:13, Russell King - ARM Linux wrote:
> On Thu, Jan 08, 2015 at 11:10:47PM +0100, Arnd Bergmann wrote:
>> My guess is that any implementation that has working LDREX/STREX
>> on uncached memory does not support SMP, because these instructions
>> tend to be implemented through the cache coherency logic on SMP
>> systems but could be implemented more easily without a dcache
>> on uniprocessor cores.
> 
> Yes, I negated Tony's patches... Tony was fixing pstore to use
> writecombine memory.
> 
> So this change is fine.

Do you want me to submit the patch as-is to your patch tracking, or
would you want to include Gregory's quotes for completeness?
--
Florian
