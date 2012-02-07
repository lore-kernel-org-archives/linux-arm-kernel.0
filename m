From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Feb 2012 03:56:24 +0100
Subject: [PATCH 1/4] i2c/gpio-i2c add: add DT support
In-Reply-To: <20120206160907.GG10173@sirena.org.uk>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
 <20120206160907.GG10173@sirena.org.uk>
Message-ID: <20120207025624.GB15647@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:09 Mon 06 Feb     , Mark Brown wrote:
> On Sun, Feb 05, 2012 at 11:38:53AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > +	- udelay: half clock cycle time in us (may depend on each platform)
> 
> > +	udelay = <2>;		/* ~100 kHz */
> 
> Why not specify this in kHz and do the conversion in the driver?  It
> seems a more intuitive thing to be specifying.  I appreciate that the
> platform data used udelay but it seems an entirely unintuitive thing
> from a user point of view even if it's what the implementation wants.
because it's not accurate and on some platform you need to adapt it so we keep
the udelay

as example due to latency when changing state of the gpio as we may access it
via i2c or internal bus latency

Best Regards,
J.
