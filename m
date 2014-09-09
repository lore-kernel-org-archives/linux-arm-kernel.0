From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Sep 2014 11:28:07 +0200
Subject: [PATCH] arm64, defconfig: Increase NR_CPUS default to 64
In-Reply-To: <20140909080740.GP23009@pengutronix.de>
References: <1410176689-20020-1-git-send-email-rric@kernel.org>
 <20140909080740.GP23009@pengutronix.de>
Message-ID: <1410254887.22255.14.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-09 at 10:07 +0200, Uwe Kleine-K?nig wrote:
> On Mon, Sep 08, 2014 at 01:44:48PM +0200, Robert Richter wrote:
> > @@ -252,11 +252,11 @@ config SCHED_SMT
> >  	  places. If unsure say N here.
> >  
> >  config NR_CPUS
> > -	int "Maximum number of CPUs (2-32)"
> > -	range 2 32
> > +	int "Maximum number of CPUs (2-64)"
> > +	range 2 64
> >  	depends on SMP
> >  	# These have to remain sorted largest to smallest
> Unrelated to the patch: What does this comment mean? There is only one
> line following, so it's sorted implicitly.

This comment doesn't mean much, anymore.

It was added in commit 159428538323 ("arm64: Add Kconfig option for APM
X-Gene SOC family"). Why someone cared so much about the sorting of the
two defaults is unclear to me. Maybe only to make sure future commits
wouldn't mess up the sorting order. Anyhow, it seems it was just
forgotten to remove that line in commit 62aceb8ff4b3 ("arm64: make
default NR_CPUS 8") which again made it a single item list.

> > -	default "8"
> > +	default "64"


Paul Bolle
