From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Apr 2015 22:42:46 +0200
Subject: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
In-Reply-To: <20150403163553.GA16247@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com> <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com> <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth> <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
Message-ID: <20150403204246.GB13009@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Maybe an option would be to provide two cpu_v7_switch_mm
> implementations (one with the errata and one without). Then
> the system can start with the simple implementation. Once
> the boot as progressed far enough to know, that the hardware
> is affected by the errata, it could switch to the implementation
> with the flushing.

Actually... we should start with the slow&safe option, and then switch
to faster implementation if workaround is not needed.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
