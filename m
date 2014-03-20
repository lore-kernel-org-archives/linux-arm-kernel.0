From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Mar 2014 15:06:48 +0530
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <9096065.aGCg8yZblW@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <4836281.0IgPinItBq@wuerfel> <532A1BDD.904@cogentembedded.com>
 <9096065.aGCg8yZblW@wuerfel>
Message-ID: <532AB6B0.7010108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 12:12 PM, Arnd Bergmann wrote:
> On Thursday 20 March 2014 01:36:13 Sergei Shtylyov wrote:
>> On 03/19/2014 11:21 PM, Arnd Bergmann wrote:
>>> The question is whether there is anyone who would do this properly.
>>
>>     Nobody cares, it seems. As you can imagine, I stopped to care enough after 
>> being switched to other projects.
> 
> I only care about it because I have the intention to get all 'randconfig'
> kernels to build eventually. For stuff that is definitely 'legacy'
> and won't get cleaned up properly, I'm fine with a hack.
> 
>>> Both the OHCI and MUSB drivers use exactly one register (CFGCHIP2)
>>
>>     The idea at the time was to just ioremap() this register but I was not 
>> very eager.
> 
> Yes, that would work, too. However, that would cause problems later
> if we ever try to make the davinci platform "multiplatform", unless we also
> pass the physical address in a platform resource and make this a larger

Some SATA driver work done by Bartlomiej Zolnierkiewicz needed driver
access to syscfg registers too and I just asked him to pass the physical
addresses using platform resource. I think thats the best bet we have in
the absence of a modern interface.

> The syscon (system controller) framework helps share a set of registers
> across multiple drivers. If all accesses to the CFGCHIP2 register are
> in a single PHY driver, we wouldn't need it.

CFGCHIP2 has controls both for USB 1.1 (OHCI) and USB 2.0 (MUSB). Not
sure if there can be a single PHY driver for both.

Thanks,
Sekhar
