From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 14:18:24 -0700
Subject: [PATCH v3 2/4] regulator: adapt fixed regulator driver to dt
In-Reply-To: <20111104210151.GA2541@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-3-git-send-email-rnayak@ti.com>
	<20111104203422.GB3918@quad.lixom.net>
	<20111104210151.GA2541@opensource.wolfsonmicro.com>
Message-ID: <20111104211824.GA5608@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 09:01:52PM +0000, Mark Brown wrote:
> On Fri, Nov 04, 2011 at 01:34:22PM -0700, Olof Johansson wrote:
> 
> > Shouldn't a fixed regulator just be a subset of a fixed one? If so, should the
> > binding be merged with that one?
> 
> No, the fixed voltage regultor is a superset of a general regulator - it
> has additional information like the voltage it supplies and the optional
> enable GPIO.

Still, seems like it could be merged into one regulator binding.

> > > +- regulator-fixed-enabled-at-boot: 1 = yes, 0 = no
> 
> > Same here, you can drop the prefix. Also, the regular regulators use
> > "regulator-name" for the supply name, it would make sense to reuse the same
> > naming here, right?
> 
> I'm having a hard time associating your second comment with the property
> being discussed - could you clarify please?

It was the first comment I wrote on the whole block and later interspersed
other comments above, so I don't blame you for not understanding. The
second comment was related to the "regulator-fixed-supply" property at
the top of the block.


-Olof
