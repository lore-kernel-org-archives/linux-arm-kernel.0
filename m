From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 23 Feb 2010 22:28:43 +0100
Subject: [PATCH 03/13] ARM: LPC32XX: Clock driver
In-Reply-To: <20100220163313.GA12409@n2100.arm.linux.org.uk>
References: <1266621969-28847-1-git-send-email-wellsk40@gmail.com>
	<1266621969-28847-4-git-send-email-wellsk40@gmail.com>
	<20100220163313.GA12409@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F805CCE964FB@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks much for your response on this.

Does it make sense to repost the complete patchset or just the diffs
of the changed files? (clock.h and clock.c).

> 
> There's no requirement to return a rate of zero if the clock is not
> enabled.
> In fact, it's something that should be avoided because it prevents
> querying
> the rate you'll get before enabling the clock (which might affect whether
> you decide to enable it.)
> 

Alright, this reduces some checks. I've also made changes to set_rate
functions to allow clock rate changes without the clock being enabled
or changing the current clock enable state.

thanks,
Kevin
 
