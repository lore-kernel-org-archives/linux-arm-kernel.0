From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Mon, 14 Sep 2009 15:58:24 +0300
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <20090914081001.GB14519@n2100.arm.linux.org.uk>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<200909132328.47079.marek.vasut@gmail.com>
	<20090913230008.GC30169@n2100.arm.linux.org.uk>
	<20090914002100.GD30621@shareable.org>
	<20090914081001.GB14519@n2100.arm.linux.org.uk>
Message-ID: <94a0d4530909140558nd8d2c47lc9954563c80a574f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2009 at 11:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 14, 2009 at 01:21:00AM +0100, Jamie Lokier wrote:
>> Russell King - ARM Linux wrote:
>> > On Sun, Sep 13, 2009 at 11:28:47PM +0200, Marek Vasut wrote:
>> > > > ? ? ? ? ? ? ? ? bhi ? ? __delay
>> > > > ? ? ? ? ? ? ? ? mov ? ? pc, lr
>> > > > ?ENDPROC(__udelay)
>> > > >
>> > > Hi
>> > >
>> > > why was this code there in the first place ?
>> >
>> > To make the delay loop more stable and predictable on older CPUs.
>>
>> So why has it been commented out, if it's needed for that?
>
> We moved on and it penalises later CPUs, leading to udelay providing
> shorter delays than requested.
>
> So the choice was either stable and predictable on older CPUs but
> buggy on newer CPUs, or correct on all CPUs but gives unnecessarily
> longer delays on older CPUs.

Why not add an #ifdef CPU_V4 or whatever?

-- 
Felipe Contreras
