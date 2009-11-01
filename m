From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 1 Nov 2009 22:13:25 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091031013427.GL14091@buzzloop.caiaq.de>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
Message-ID: <20091101211325.GC2085@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Is anyone using suspend/resume with a recent git mainline kernel on PXA
> or other ARM embedded boards? My platform used to suspend and resume
> just fine on 2.6.31 but now as I rebased it, it fails the resume part.

2.6.32-rc* broke resume on spitz (pxa). I narrowed it down to crash in
arch_suspend_enable_irqs() in kernel/power/suspend.c...

Can you try to light a led or something just before it to see if you
hit same problem?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
