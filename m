From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Nov 2011 21:14:48 +0000
Subject: [PATCH v4 1/4] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111104202905.GA3918@quad.lixom.net>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
	<20111104202905.GA3918@quad.lixom.net>
Message-ID: <20111104211447.GC2541@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 01:29:05PM -0700, Olof Johansson wrote:
> On Thu, Oct 27, 2011 at 06:54:24PM +0530, Rajendra Nayak wrote:

> > @@ -0,0 +1,33 @@
> > +Voltage/Current Regulators

> There should be a mandatory compatible field here, right? I.e. a topmost
> generic one, "regulator" or similar.

It's not really useful for the regulator subsystem to directly bind to
the device as something needs to actually control it, the idea is that
this binding is included by reference in the bindings for specific
devices.

> Also, lower-caps is common instead of V and A.

On the other hand the case is pretty important for SI units

> > +- <name>-supply: phandle to the parent supply/regulator node

> Having a fixed name here instead of a free form string would probably be a good
> idea?

The name will be fixed by the individual device bindings, this is
specifying the general form of a supply property.  Each device binding
will define the set of supplies that the device can use.
