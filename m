From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 21 Feb 2017 23:26:47 +0100
Subject: [PATCH 0/4] ARM64: Initial Marvell IAP140 enablement
In-Reply-To: <a8a1279c-4978-f612-e4cd-57b8645f3e79@suse.de> ("Andreas
 \=\?utf-8\?Q\?F\=C3\=A4rber\=22's\?\= message of "Tue,
 21 Feb 2017 19:26:40 +0100")
References: <20170219032000.4674-1-afaerber@suse.de>
 <87bmtxatmt.fsf@free-electrons.com>
 <a8a1279c-4978-f612-e4cd-57b8645f3e79@suse.de>
Message-ID: <8737f7yyc8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Hi Gregory,
>
> Am 20.02.2017 um 14:17 schrieb Gregory CLEMENT:
>>  On dim., f?vr. 19 2017, Andreas F?rber <afaerber@suse.de> wrote:
>> 
>>> This mini-series adds initial support for the Marvell IAP140 SoC (aka PXA1908)
>>> and the Andromeda Box Edge development board.
>> 
>> Given the name of the SoC (PXA1908) and the fact that you reuse driver
>> related to PXA, for me these SoC is neither a mvebu nor a berlin SoC.
>
> That matches my understanding.

...zip...
> What I am reading out of the documentation Thomas pointed to is that
> ARCH_MMP would be more correct than ARCH_PXA, despite the PXA1908 name.
I agree here.

PXA for me are XScale micro-architecture based SoCs, quite old. PXA1908 has a
quite recent Cortex-A53 (or several of them), which makes me think its either an
MMP or something newer than MMP.

> MMP does help with driver compilation. Just for the OF earlycon I still
> need the PXA compatible fallback, or we would need to define an MMP
> earlycon. Since mmp2.dtsi does not use the pxa compatible, I'll look
> into the latter for v2.
>
> MMP sorts before MVEBU, unlike PXA.
>
> So MMP would mean Eric and Haojian only - I will drop the other Marvell
> maintainers for v2 then, except where review comments have been provided.
Yes please.

Cheers.

-- 
Robert
