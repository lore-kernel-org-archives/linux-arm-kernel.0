From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Fri, 01 Jun 2012 18:26:28 +0400
Subject: [RFC PATCH 05/11] mfd: omap: control: core system control driver
In-Reply-To: <20120601141342.GS12766@atomide.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
 <4FBF8078.9050809@ti.com> <20120528113502.GG3923@besouro>
 <4FC4CE4B.8020708@ti.com> <20120601112951.GM12766@atomide.com>
 <4FC8C649.10507@dev.rtsoft.ru> <20120601141342.GS12766@atomide.com>
Message-ID: <4FC8D114.6020100@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2012 06:13 PM, Tony Lindgren wrote:
> * Konstantin Baydarov <kbaidarov@dev.rtsoft.ru> [120601 06:44]:
>> On 06/01/2012 03:29 PM, Tony Lindgren wrote:
>>> We can have a static map for the SCM, so ioremapping each driver
>>> individually should not be an issue.
>> Actually SCM registers window is mapped statically. Mapping is defined in omap44xx_io_desc[] in arch/arm/mach-omap2/io.c:
>>
>> ...
>>         .virtual    = L4_44XX_VIRT,
>>         .pfn        = __phys_to_pfn(L4_44XX_PHYS),
>>         .length        = L4_44XX_SIZE,
>>         .type        = MT_DEVICE,
>> ...
>>
>>
>> So ioremap() always returns same virtual address (0xfc002000).
> Hmm I guess you mean L4_44XX_VIRT + offset. Otherwise drivers
> would not work at all.. Or else I don't follow you.
Right. I mean when 0x4A00 2000(scm base) is remapped in scm driver, ioremap() always returns same virtual address (0xfc002000).
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
