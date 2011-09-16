From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Sep 2011 10:01:24 +0100
Subject: [RFC PATCH 06/11] DT: regulator: Helper routine to extract
	fixed_voltage_config
In-Reply-To: <4E72F875.4090001@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
	<20110915135051.GL7988@opensource.wolfsonmicro.com>
	<4E72F875.4090001@ti.com>
Message-ID: <20110916090123.GE22062@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 12:49:17PM +0530, Rajendra Nayak wrote:
> On Thursday 15 September 2011 07:20 PM, Mark Brown wrote:
> >On Thu, Sep 15, 2011 at 04:52:02PM +0530, Rajendra Nayak wrote:

> >>+# For fixed voltage regulators
> >>+- supply-name: Name of the regulator supply
> >>+- microvolts: Output voltage of regulator
> >>+- gpio: gpio to use for enable control
> >>+- startup-delay: startup time in microseconds
> >>+- enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
> >>+- enabled-at-boot: 1 = yes, 0 = no

> >Much of this is specific to the Linux fixed voltage regulator driver
> >rather than a generic regulator with a fixed voltage.

> So how should these non-generic things be handled through device
> tree? Should they never be part of dt or should the bindings just be
> defined such that its clear they are linux specific?

Having them be part of the fixed voltage regulator bindings would be
fine, the problem is that you're adding this in framework code not in a
driver.
