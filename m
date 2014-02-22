From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 22 Feb 2014 23:28:19 +0100
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
Message-ID: <20140222222819.GA20490@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > return from the finisher will always be interpreted as an abort rather
> > than success (because the state has to be unwound.)
> > 
> > This is the only way to get a zero return from cpu_suspend().
> 
> Yes, that's the only reason why this code is jumping to cpu_resume, since
> all it is needed is to snapshot the CPU context and by the time the
> finisher is called that's done. Wanted to say that soft reboot is not
> useful (cache flushing and resume with MMU off), but what you are saying
> is correct. We might be saving swsusp_save return value in a global
> variable and just return from the finisher, but that's horrible and
> given the amount of time it takes to snapshot the image to disk the
> cost of this soft reboot will be dwarfed by that.

I feel bad for the "global variable" trick on x86, and if you can
avoid it, please do!

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
