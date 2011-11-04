From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Nov 2011 21:25:38 +0000
Subject: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
In-Reply-To: <20111104211824.GA5608@quad.lixom.net>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-3-git-send-email-rnayak@ti.com>
	<20111104203422.GB3918@quad.lixom.net>
	<20111104210151.GA2541@opensource.wolfsonmicro.com>
	<20111104211824.GA5608@quad.lixom.net>
Message-ID: <20111104212538.GA8266@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 02:18:24PM -0700, Olof Johansson wrote:
> On Fri, Nov 04, 2011 at 09:01:52PM +0000, Mark Brown wrote:

> > No, the fixed voltage regultor is a superset of a general regulator - it
> > has additional information like the voltage it supplies and the optional
> > enable GPIO.

> Still, seems like it could be merged into one regulator binding.

I don't see how you can usefully do that, the task of plumbing a
regulator into a board is largely orthogonal to the specific feature set
of a given regulator.  The specific bindings for a fixed voltage
regulator would be useful or unhelpful for most regultors controlled via
I2C.
