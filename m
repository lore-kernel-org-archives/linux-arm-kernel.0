From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 Sep 2012 22:21:43 -0400
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <1347987819.11116.38.camel@hornet>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
 <20120918150212.GA12543@opensource.wolfsonmicro.com>
 <1347983056.11116.11.camel@hornet>
 <20120918160909.GA15587@opensource.wolfsonmicro.com>
 <1347987819.11116.38.camel@hornet>
Message-ID: <20120919022141.GA8832@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 06:03:39PM +0100, Pawel Moll wrote:
> On Tue, 2012-09-18 at 17:09 +0100, Mark Brown wrote:

> > or even what's physically present?

> You mean read back what voltage is set now? By all means - that's what
> it is doing for "read only" devices.

No, I mean discovering which regulators are present and what they can
do.

> > So this is going to break interoperation with a bunch of consumer
> > drivers that rely on being able to tell what voltages are supported.
> > The key thing for them would be that regulator_is_supported_voltage()
> > works, currently it relies on list_voltage() as that's the only way to
> > do that right now.

> Ok, I guess I should use regulator_list_voltage_linear() and
> regulator_map_voltage_linear() then? I'll just have to carefully think
> what step to choose.

No, we should provide a way to describe this situation in the API - it's
not unreasonable and having to pick step sizes is obviously suboptimal.
