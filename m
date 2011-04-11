From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 11 Apr 2011 15:46:43 +0200
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <4D8EFEC1.7010803@compulab.co.il>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<201103270152.45581.marek.vasut@gmail.com>
	<201103271028.56672.anarsoul@gmail.com>
	<4D8EFEC1.7010803@compulab.co.il>
Message-ID: <20110411134642.GA1519@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> PXA27x does not like fastbus for some reason, it can hang in
> >>> random places when it's enabled. So don't use it to make cpufreq
> >>> stable.
> >> This is B/S, you're loosing performance!
> > I'm losing nothing, without this patch cpufreq does not work stable at all on 
> > Zipit Z2.
> 
> Possibly, but Z2 is not the only one using PXA27x.
> And of course you lose performance, unless you don't care,
> because if it does not work at all, you don't care about performance,
> but again it is wrong to force all PXA27x based boards to this.

Well, some other pxa27x machcines  (spitz) are crashing randomly for
_years_ now... so maybe the problem is more widespread?

How easy is to trigger the problem? Do you have script?

Is it possible that this bug triggers with governor==performance.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
