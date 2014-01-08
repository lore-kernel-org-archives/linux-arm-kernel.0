From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Jan 2014 18:25:31 +0000
Subject: [RFC 10/18] regulator: vexpress: Use regmap instead of custom
 interface
In-Reply-To: <20131224122455.GY30815@sirena.org.uk>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-11-git-send-email-pawel.moll@arm.com>
 <20131224122455.GY30815@sirena.org.uk>
Message-ID: <1389205531.23721.40.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-24 at 12:24 +0000, Mark Brown wrote:
> On Mon, Dec 23, 2013 at 04:23:42PM +0000, Pawel Moll wrote:
> 
> > This patch makes the Versatile Express regulator driver
> > use regmap interface, instead of custom vexpress config
> > one. It will request the regmap resource associated
> > with the device, which makes it pretty much hardware
> > agnostic.
> 
> If this change is making the operations hardware agnostic regmap based
> ones then they should be being either replaced with standard operations
> or standard operations being added.  It looks like you should be able to
> use the existing linear map operations.

Bad wording on my side. What I meant was: it doesn't matter what wacky
VE-specific interface is hidden behind the regmap, not it's a generic
regulator driver.

Having said that, I could create helpers for continuous (linear won't
cut - if you remember the continuous_voltage_range was introduced for
VE's sake) regulator, which would simply read/write value to a specified
register. Not sure how useful would that be, though. I doubt that such
"regulator" will appear anywhere outside VE world. And if so, this would
probably call for a "generic continuous regulator" driver and a relevant
DT binding, which I don't think anyone really wants. If your opinion
differs, I'm happy to botch something up.

Cheers!

Pawe?
