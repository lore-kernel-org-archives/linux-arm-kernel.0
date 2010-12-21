From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 21 Dec 2010 20:51:06 +0100
Subject: [RFC][PATCH] ARM: Add initial hibernation support for Cortex
	A8 and A9
In-Reply-To: <20101221145126.GU28157@n2100.arm.linux.org.uk>
References: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
	<AANLkTinFTAHzuEaLMn=xcevLCFvjga7RC6yztzC1fO5d@mail.gmail.com>
	<20101221145126.GU28157@n2100.arm.linux.org.uk>
Message-ID: <20101221195105.GA29126@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The same should be true of things like perf.
> 
> Things like the control register we already have the value cached, so
> there's little point saving another copy of it.
> 
> What we should also have is a callback into the proc-*.S files for
> them to save the processor specific registers such as the TTB registers.
> 
> And then, with non-secure mode, we run into issues about which registers
> we _can_ sanely read and write.
> 
> What I'm saying is that rather than copying stuff verbatim from the
> ARM ARM, _think_ first and see what is actually necessary.

Well, the patch is not exactly nice, but "simple and stupid" version
that just saves everything might be useful baseline for bisect
etc... and speed should not really be issue here.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
