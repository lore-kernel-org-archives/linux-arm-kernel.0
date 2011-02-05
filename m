From: ccross@android.com (Colin Cross)
Date: Sat, 5 Feb 2011 10:36:22 -0600
Subject: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support forre-enabling
	l2x0
In-Reply-To: <cb528285e8aa8cdda01d7ced0121b2cf@mail.gmail.com>
References: <1295834493-5019-5-git-send-email-ccross@android.com>
	<1295968464.10109.264.camel@e102109-lin.cambridge.arm.com>
	<20110125154133.GB17280@n2100.arm.linux.org.uk>
	<1295979242.10109.308.camel@e102109-lin.cambridge.arm.com>
	<2f97ec8a084e590220e1548fc927b60e@mail.gmail.com>
	<-8932138696981683633@unknownmsgid>
	<AANLkTi=cTXmQFm_s5OL2pGyyaFv5UR_f9MV=S5Ajx0tu@mail.gmail.com>
	<20110204234331.GF8732@n2100.arm.linux.org.uk>
	<AANLkTi=fHnivHXHnYrQvdP6JWbEA3t1X3DuBxj5gN3H0@mail.gmail.com>
	<1bebe4b5c8590059b70a146d5486fa6a@mail.gmail.com>
	<20110205094730.GA23965@n2100.arm.linux.org.uk>
	<cb528285e8aa8cdda01d7ced0121b2cf@mail.gmail.com>
Message-ID: <AANLkTik_r4k_5o+F47vRbGPcWLwfgHgWqhym49XfhBZ9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 5, 2011 at 4:41 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>> Sent: Saturday, February 05, 2011 3:18 PM
>> To: Santosh Shilimkar
>> Cc: Colin Cross; Will Deacon; Catalin Marinas; Linus Walleij;
>> konkers at android.com; Tony Lindgren; linux-kernel at vger.kernel.org;
>> linux-tegra at vger.kernel.org; olof at lixom.net; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH v2 04/28] ARM: mm: cache-l2x0: Add support
>> forre-enabling l2x0
>>
>> On Sat, Feb 05, 2011 at 01:21:24PM +0530, Santosh Shilimkar wrote:
>> > GIC save/restore on OMAP follows different strategy. There is a
>> > Predefined layout to save content and restore is done atomically
>> > by boot ROM code.
>> > L2 cache also same case. Only AUXCTRL needs to be programmed on
>> > wakeup from low power mode and that too with secure call. Rest
>> > of the registers are managed by boot ROM code.
>> >
>> > TWD is already managed through framework. Othe CPU low power
>> > sequence is very small and OMAP has restrictions on the last
>> > core to go down and first to wakeup.
>> >
>> > So at least I don't see any use of common notifiers for GIC
>> > and L2 will help OMAP lower power code.
>>
>> What this means is that we're going to end up littering things like
>> GIC
>> and other stuff with lots of individual SoC specific code to save
>> state
>> into individual SoC specific structures. ?This is not sane, and
>> we're
>> not going to corrupt generic code with SoC specific code.
>
> Fully agree and hence flagged it early.
>
> Regards,
> Santosh
>

Would putting dummy values in the areas the boot ROM uses and then
letting the common GIC code restore over them cause any problems?
