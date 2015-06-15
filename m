From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 15 Jun 2015 11:58:26 -0700
Subject: [RFC] ARM: exynos: MCPM: [is this a] fix for secondary boot on
 5422?
In-Reply-To: <557ECBAE.20302@samsung.com> (Przemyslaw Marczak's message of
 "Mon, 15 Jun 2015 14:57:18 +0200")
References: <1416896510-24612-1-git-send-email-khilman@kernel.org>
 <CAJKOXPfLEV1sQsz87ULDKX4vijqRpbGj7AcOEDiy83kukvVKVg@mail.gmail.com>
 <557EA6AE.304@samsung.com>
 <CAP245DVU4RmkSuOR2dNV+GMwkKxAXFs_p3zo90DP2Zo4-hbhcg@mail.gmail.com>
 <557ECBAE.20302@samsung.com>
Message-ID: <7hoakg4x4d.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Przemyslaw Marczak <p.marczak@samsung.com> writes:

> On 06/15/2015 01:19 PM, Amit Kucheria wrote:
>> On Mon, Jun 15, 2015 at 3:49 PM, Przemyslaw Marczak
>> <p.marczak@samsung.com> wrote:
>>> Hello Krzysztof,
>>>
>>>
>>> On 06/14/2015 10:56 AM, Krzysztof Koz?owski wrote:
>>
>> <snip>
>>
>>> I'm trying port the hardkernel's SPL to the mainline U-Boot at present. The
>>> mainline SPL is implemented for E5420 and E5800. But there are few
>>> differences:
>>> - different DRAM
>>> - different clocks
>>> - different boot core (peach-pi boots from A15)
>>> - bl2 signature
>>> - hdk's SPL uses smc calls
>>> ... and some more.
>>
>> This is really good news! Would this work leave CCI control to Linux
>> so that we may use MCPM to manage cpu and cluster OFF?
>>
>
> Yes, I would like to get this stuff working.
>

Do you have access to BL1 sources to change this?

IIUC, what is happening is BL1 is leaving CCI in secure mode, which
means the kernel MCPM cannot manage it.  That means the kernel cannot
manage any low-power CPU or cluster states.

Does anyone know at which stage of the boot secure world is left for
normal world?  in BL1?  in BL2?

If it's in BL2, maybe the CCI issue can also be fixed by ensuring that
CCI is not left in secure mode so the kernel can properly manage CCI.

Kevin
