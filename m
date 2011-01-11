From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Jan 2011 14:33:35 +0100
Subject: [PATCH] arm: mm: Poison freed init memory
In-Reply-To: <20110111090615.GH12552@n2100.arm.linux.org.uk>
References: <1294256845-29517-1-git-send-email-sboyd@codeaurora.org>
	<20110105202645.GL8638@n2100.arm.linux.org.uk>
	<4D255263.7040106@codeaurora.org>
	<20110106090741.GQ8638@n2100.arm.linux.org.uk>
	<4D2BE3E1.5060706@codeaurora.org>
	<20110111090615.GH12552@n2100.arm.linux.org.uk>
Message-ID: <20110111133335.GE10705@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Ok it seems that 0xcc was chosen by Pavel since it's a breakpoint
> > instruction (sorry for not noticing that earlier [1]).
> 
> It may be on x86, but on ARM:
> 
>    0:   cccccccc        stclgt  12, cr12, [ip], {204}
> 
> That's a co-processor #12 instruction which will only be executed of
> the processor condition codes satisfy 'gt'.
> 
> > There was some discussion about handling initdata with Pavel's patch
> > but it seems that nothing came of it?
> 
> I'm not sure who this Pavel is who you keep referring to - the message
> you link to is a discussion between William Irvin and hpa.

I was surprised, too, but it looks like I was the one who ported patch
from x86-64.

I'm not really sure if initdata poisoning happened... it is too long
ago.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
