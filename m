From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 17:01:47 +0200
Subject: [PATCH] ARM: mm: cpu_fa526_do_idle: remove WFI
In-Reply-To: <CACmBeS3_aqf42sCKeO9TNJSkOPYwvyAXOvYKjrU8_jV6yAKQ-g@mail.gmail.com>
References: <1371476360-8751-1-git-send-email-jonas.jensen@gmail.com>
 <20130617143021.GI2718@n2100.arm.linux.org.uk>
 <CACmBeS3_aqf42sCKeO9TNJSkOPYwvyAXOvYKjrU8_jV6yAKQ-g@mail.gmail.com>
Message-ID: <3363106.HfAWgJLKER@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013 16:58:14 Jonas Jensen wrote:
> On 17 June 2013 16:30, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > It replaces the WFI and return with a pure nop, so we will fall through
> > to cpu_fa526_dcache_clean_area().  Do we really want to clean a random
> > D cache entry depending on what r0 happened to hold at this point?  I
> > think not...
> 
> I'm sorry for making the assumption that I know even the most basic
> ARM assembler...
> 
> This is not the sort of thing I deal with (and probably shouldn't) on
> a daily basis.
> 
> Can I make a guess, remove only mcr and replace it with nop?

No need for the nop, just remove the mcr instruction.

	Arnd
