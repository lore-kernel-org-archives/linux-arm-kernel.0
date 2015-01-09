From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 09 Jan 2015 10:35:33 -0800
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <20150109161624.GR12302@n2100.arm.linux.org.uk>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
 <54AEA7E0.5070101@gmail.com>
 <CADtm3G5Ebf6WkHG3fyiY3pm7fEBBNoW3DDEEwpvBXGj0fVE6jQ@mail.gmail.com>
 <3495606.iOQOj3bxPc@wuerfel> <20150108221356.GD12302@n2100.arm.linux.org.uk>
 <54AF03F5.9030907@gmail.com> <20150109161624.GR12302@n2100.arm.linux.org.uk>
Message-ID: <54B01F75.8020604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/15 08:16, Russell King - ARM Linux wrote:
> On Thu, Jan 08, 2015 at 02:25:57PM -0800, Florian Fainelli wrote:
>> On 08/01/15 14:13, Russell King - ARM Linux wrote:
>>> On Thu, Jan 08, 2015 at 11:10:47PM +0100, Arnd Bergmann wrote:
>>>> My guess is that any implementation that has working LDREX/STREX
>>>> on uncached memory does not support SMP, because these instructions
>>>> tend to be implemented through the cache coherency logic on SMP
>>>> systems but could be implemented more easily without a dcache
>>>> on uniprocessor cores.
>>>
>>> Yes, I negated Tony's patches... Tony was fixing pstore to use
>>> writecombine memory.
>>>
>>> So this change is fine.
>>
>> Do you want me to submit the patch as-is to your patch tracking, or
>> would you want to include Gregory's quotes for completeness?
> 
> I think as-is.

Thanks, submitted as 8276/1.
-- 
Florian
