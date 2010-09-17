From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 18 Sep 2010 00:22:50 +0200
Subject: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <4C938EE2.1010307@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com>
Message-ID: <201009180022.51011.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 17, 2010, Nishanth Menon wrote:
> Mark Brown had written, on 09/17/2010 10:36 AM, the following:
> > On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:
> > 
> >> +struct opp_def {
> >> +	unsigned long freq;
> >> +	unsigned long u_volt;
> >> +
> >> +	bool enabled;
> >> +};
> > 
> > It might be clearer to use some term other than enabled in the code -
> > when reading I wasn't immediately sure if enabled meant that it was
> > available to be selected or if it was the active operating point.  How
> > about 'allowed' (though I'm not 100% happy with that)?
> ;).. The opp is enabled or disabled if it is populated, it is implicit 
> as being available but not enabled- how about active? this would change 
> the opp_enable/disable functions to opp_activate, opp_deactivate..

Would that mean that "active" is the one currently in use?

Rafael
