From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Mar 2014 21:28:26 +0800
Subject: [PATCH 3/7] of: introduce of_dma_is_coherent() helper
In-Reply-To: <201403071709.11568.arnd@arndb.de>
References: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
 <CAL_JsqJ3QhRRNVAsvAPP=Ex_ptQcbpCXh7pf44K1xh+scFqiug@mail.gmail.com>
 <531948A8.9040106@ti.com> <201403071709.11568.arnd@arndb.de>
Message-ID: <531DBDFA.5000104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 March 2014 12:09 AM, Arnd Bergmann wrote:
> On Friday 07 March 2014, Santosh Shilimkar wrote:
>> On Friday 07 March 2014 11:55 AM, Rob Herring wrote:
>>
>>> Thinking about this some more, if the arch is always coherent or
>>> always non-coherent, then the default ops are always fine. In that
>>> case set_arch_dma_coherent_ops is always a nop and of_dma_is_coherent
>>> is a don't care.
>>>
>> Hmmm.. I guess you are right. In that case we can drop the need of
>> config option.
> 
> A compile-time config option clearly would not work here, because it
> breaks multiplatform support when some platforms are different from
> others. I can still see the possible need for a global run-time setting
> though, to give some platform init code the ability to override the
> DT flags when it knows better. That is probably what you want to do
> on keystone without LPAE.
> 
The compile time flag added was keeping in mind to be used per architecture
like ARM, X86 or powerpc on need basis. I understand that it might
be used by machines within the architectures but that was not my
intention. In any case config bit isn't a good idea.

Keystone without LPAE actually I don't need such an option. For
non-LPAE case, I need to modify the memory node and same goes
with dma-ranges info to use aliased address space.

How about we care about such an option when we actually need
it. As Rob pointed out, we are just fine for now with sane
defaults.

Regards,
Santosh
