From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 09:15:46 +0000
Subject: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
	boot failure)
In-Reply-To: <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
	<20110106180030.GA8249@n2100.arm.linux.org.uk>
	<20110106182023.GV7771@atomide.com>
	<20110106203238.GH1198@n2100.arm.linux.org.uk>
	<20110106204053.GA7771@atomide.com>
	<20110107161230.GR1198@n2100.arm.linux.org.uk>
	<20110110185209.GC4957@atomide.com>
	<20110111231611.GX4957@atomide.com>
	<2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
Message-ID: <20110113091546.GA24429@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 02:22:06PM +0530, Anand Gadiyar wrote:
> Tony Lindgren wrote:
> >  	/* Power on the ULPI PHY */
> > -	if (gpio_is_valid(OMAP4SDP_MDM_PWR_EN_GPIO)) {
> > -		/* FIXME: Assumes pad is already muxed for GPIO mode */
> > -		gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY
> VMDM_3V3");
> > +	status = gpio_request(OMAP4SDP_MDM_PWR_EN_GPIO, "USBB1 PHY
> VMDM_3V3");
> > +	if (status)
> > +		pr_err("%s: Could not get USBB1 PHY GPIO\n");
> 
> Tony,
> 
> This throws up a build warning as there's no parameter corresponding to
> the %s. Showed up in linux-next as of today.

It's pretty obvious that the above is wrong, and the compiler would
have caught it with a warning when building it.  Was the above patch
not build-tested before it was committed?

Given the very sorry state of OMAP in mainline at present, I'm surprised
that this kind of stuff is still going on...
