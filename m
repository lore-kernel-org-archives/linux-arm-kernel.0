From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Sep 2010 16:59:37 +0100
Subject: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <4C938EE2.1010307@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com>
Message-ID: <20100917155937.GB29596@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 10:53:06AM -0500, Nishanth Menon wrote:
> Mark Brown had written, on 09/17/2010 10:36 AM, the following:

> >It might be clearer to use some term other than enabled in the code -
> >when reading I wasn't immediately sure if enabled meant that it was
> >available to be selected or if it was the active operating point.  How
> >about 'allowed' (though I'm not 100% happy with that)?

> ;).. The opp is enabled or disabled if it is populated, it is
> implicit as being available but not enabled- how about active? this
> would change the opp_enable/disable functions to opp_activate,
> opp_deactivate..

> Recommendations folks?

The enable/disable thing wasn't so noticable in the API itself, it was
in the data structures that I found it confusing - the core has a
different idea about what's going on with the system as a whole compared
to the decision that an individual device is taking.

> >When reading the description I'd expected to see some facility to
> >trigger selection of an active operating point in the library (possibly
> >as a separate call since you might have a bunch of operating points
> >being updated in quick succession) but it looks like that needs to be
> >supplied externally at the minute?

> The intent is we use the opp_search* functions to pick up the opp
> and enable/activate it and disable/deactivate it.

Sure, I get that bit.  What I meant was that I was expecting something
that would say that changes had been made to the enabled/disabled sets
and that it'd be a good idea to rescan, especially for cases where the
devices change their requirements but the OPPs need to be done over a
larger block.
