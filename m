From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Mar 2013 10:40:17 +0100
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <alpine.LFD.2.03.1303071701330.28820@syhkavp.arg>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <20130307082721.GB28982@xo-6d-61-c0.localdomain>
 <alpine.LFD.2.03.1303071701330.28820@syhkavp.arg>
Message-ID: <20130307094017.GA6337@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Review comments are welcome!
> > > 
> > > [*] General design information on the b.L switcher can be found here:
> > >     http://lwn.net/Articles/481055/
> > >     However the code is only accessible to Linaro members for the
> > >     time being.
> > 
> > Assuming the lwn article is accurate:
> > 
> > Hmm. So we have hw capable of running 8 cores, and then we introduce strange
> > switching code, because "scheduler is not ready". Sounds like a bad idea.
> > 
> > I'd say:
> > 
> > * expose all 8 cores.
> 
> You may do that now.  However the resulting power efficiency is far from 
> optimal.

Really? Assuming the lwn article is accurate, it will be exactly the
same.

I propose exposing all 8 cores, then keeping 4 of them offline in
normal operation. This should have characteristics of your solution,
except that cpu does not change unexpectedly under the pinned tasks.

> > * as long as scheduler is not ready, you can offline "the other" set of cores...
> > 	/sys/.../cpu/..../online
> 
> You may do that now also.  But system performance is far from optimal.

Really? Do the offlining from the cpufreq code, and solution will be
equivalent to yours, except the hacks.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
