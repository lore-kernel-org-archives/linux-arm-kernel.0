From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 19:15:09 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <1348162472.11116.149.camel@hornet>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
 <1347983056.11116.11.camel@hornet>
 <20120918160909.GA15587@opensource.wolfsonmicro.com>
 <1347987819.11116.38.camel@hornet>
 <20120919022141.GA8832@opensource.wolfsonmicro.com>
 <1348073905.11116.80.camel@hornet>
 <20120920130114.GQ17666@opensource.wolfsonmicro.com>
 <1348162472.11116.149.camel@hornet>
Message-ID: <20120920181508.GA5102@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 06:34:32PM +0100, Pawel Moll wrote:

> These calculations try to maximize the range, but in most cases it's
> impossible to be exactly in line with constraints. The delta should be
> less then 1%, eg. in my test case I get:

No, what I mean is that we don't want steps of 343uV or something.

> 1. Something like bool "regulator_desc.linear"

> 2. A magic value for regulator_desc.n_voltages, something like
> 	#define N_VOLTAGES_LINEAR (~0)

> Does any of them seem reasonable?

The former of them seems much more tasteful, though I'd go with
continuous_volt or something, we already have linear maps.
