From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 30 Sep 2010 22:02:46 +0200
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <1285876546.14953.10.camel@c-dwalke-linux.qualcomm.com>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
	<20100930071919.GA6434@ucw.cz>
	<1285865137.14953.4.camel@c-dwalke-linux.qualcomm.com>
	<1285870183.14953.7.camel@c-dwalke-linux.qualcomm.com>
	<20100930195237.GA2174@elf.ucw.cz>
	<1285876546.14953.10.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100930200246.GB2174@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > > This is goodbye to s2ram support, AFAICT.
> > > > 
> > > > This depends on SMP tho. It's like saying,
> > > > 
> > > > depends on 
> > > 
> > > That's weird, there was more to this email..
> > > 
> > > It's like saying,
> > > 
> > > depends on SMP && HOTPLUG && EXPERIMENTAL && !ARCH_MSM
> > > 
> > > But ARCH_MSM has no SMP, so the whole thing should short circuit right
> > > at the start. It's only when you bring in SMP that it get interesting.
> > 
> > If arch_msm has no SMP, then why is change needed?
> 
> I'm getting it ready for SMP .. It's not there yet but will be.

Ok. It makes sense, then.

> > (I was trying to warn you that you'll need HOTPLUG support to get SMP
> > suspend support.)
> 
> Yeah, I'm aware of it.. We haven't implemented hotplug yet, so we don't
> have suspend support yet for SMP.

Still, it might be better to just provide stubs that return -ENOTSUPP
or something, and leave it enabled in config. Same results, you'll
need to provide full functions in future, anyway, and no churn in
shared config files.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
