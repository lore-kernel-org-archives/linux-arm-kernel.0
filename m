From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Aug 2011 10:26:15 +0100
Subject: PB1176 broken in -rc1
In-Reply-To: <CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
References: <20110810152400.GO10121@e102144-lin.cambridge.arm.com>
	<CACRpkdaoDJy-YKONaz2j07pPvTZuHZ7KgEm6XGxNXK-jNzB8_w@mail.gmail.com>
Message-ID: <20110816092615.GC28656@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Aug 16, 2011 at 10:21:50AM +0100, Linus Walleij wrote:
> My kernel does not even boot on either -rc1 or -rc2 on the
> PB1176, with or wthout Jamies poisoning fixup.
> 
> Did you change anything else on top of -rc1 when you tested this?

Nope, I was using vanilla -rc1.

> Will, Jamie, any hints?

Can you make your .config available somewhere please?

> If I cherry-pick my TCM patches adding PB1176 support to a clean
> v3.0 branch, everything works fine, so I suspect I am not guilty for
> this AFAICT, it's something else.
> 
> Also the -rc2 code works fine on U300 which has a TCM,
> ARM926-EJS.

It sounds like an unrelated issue, so let's try to track it down.

> P.S. By the way regarding this:
> 
> > [ ? ?0.000000] CPU: found DTCM0 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved DTCM0 4k to fffe8000, enabled
> > [ ? ?0.000000] CPU: found DTCM1 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved DTCM1 4k to fffe9000, enabled
> > [ ? ?0.000000] CPU: found ITCM0 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved ITCM0 4k to fffe0000, enabled
> > [ ? ?0.000000] CPU: found ITCM1 4k @ 00000000, not enabled
> > [ ? ?0.000000] CPU: moved ITCM1 4k to fffe1000, enabled
> 
> [Will]
> > The NULL addresses in the dmesg look
> > strange to me, but I'm not familiar with the TCMs.
> 
> This looks perfectly normal. The TCMs are default disabled and mapped
> to address 0x00000000, I activate them and move them to our desired
> location.

Ah, ok. Please excuse my lack of TCM knowledge! How do you use the interface
with the TCMs once they've been mapped at the high address? Are they visible
to userspace?

Will
