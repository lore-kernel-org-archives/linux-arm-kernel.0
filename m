From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 Sep 2012 16:02:12 +0100
Subject: [PATCH v2 04/13] regulators: Versatile Express regulator driver
In-Reply-To: <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-5-git-send-email-pawel.moll@arm.com>
Message-ID: <20120918150212.GA12543@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 03:17:46PM +0100, Pawel Moll wrote:
> Implementation of the regulator framework driver for the
> Versatile Express voltage control. Devices without
> voltage constraints (ie. "regulator-[min|max]-microvolt"
> properties in the DT node) are treated as fixed (or rather
> read-only) regulators.

This doesn't seem great...  it doesn't seem to know or represent
anything at all about the hardware, I'd expect a voltage regulator to at
a minimum be able to implement list_voltage().  You've not provided any
information on what the hardware actually is and the driver just seems
to proxy through to some other API which actually implements the
regulator support.

> +	init_data->constraints.apply_uV = 0;

This seems broken, why are you interfering with the supplied
constraints?
