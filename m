From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 1 Dec 2014 10:46:13 +0000
Subject: [PATCH] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <20141201104145.GY3836@n2100.arm.linux.org.uk>
References: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
 <20141201104145.GY3836@n2100.arm.linux.org.uk>
Message-ID: <20141201104612.GM828@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 10:41:45AM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 28, 2014 at 05:55:40PM +0000, Liviu Dudau wrote:
> > +	/*
> > +	 * PPIs are optionally configurable, but we cannot distinguish
> > +	 * between high and low, nor falling and rising. Change the
> > +	 * type so that it passes the next check.
> 
> This comment could do with a /lot/ of improvement.  It sounds like the
> only reason this code exists is to bypass the check.  If that's all
> that's being done, there's better ways to code it.

Hi Russell,

You are right, all I want to do is bypass the next check because *if*
the PPIs can be configured, then any combination is valid (edge 
raising/falling, level low/high). In real systems, PPIs tend to be
configured with active level low. That falls the existing check.

If I understood more your thoughts on improving the comment then I can
try to come up with a better version.

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
