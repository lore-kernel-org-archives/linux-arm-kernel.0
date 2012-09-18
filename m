From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 Sep 2012 17:09:09 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <1347983056.11116.11.camel@hornet>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
 <1347983056.11116.11.camel@hornet>
Message-ID: <20120918160909.GA15587@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 04:44:16PM +0100, Pawel Moll wrote:

> Well, that's what it really is. The config API sends a request "set xyz
> uV" to the microcontrollers. And the micro can (at least in theory) get
> you any voltage within the min/max limits by whatever means it has (at
> least some of the daugtherboards use micro's DAC to adjust reference
> voltage for a DC/DC converter with a feedback loop using ADC).

And the microcontroller is incapable of telling us what it supports, or
even what's physically present?

> But fair enough, I should have done better work in describing this.

So this is going to break interoperation with a bunch of consumer
drivers that rely on being able to tell what voltages are supported.
The key thing for them would be that regulator_is_supported_voltage()
works, currently it relies on list_voltage() as that's the only way to
do that right now.

> v3 to follow.

v3?  I didn't see V2.  Please also CC posts to the relevant mailing
lists for the subsystem (lkml in this case).
