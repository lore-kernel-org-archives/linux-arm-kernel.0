From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Wed, 27 Dec 2017 23:16:44 +0200
Subject: [PATCH] Device tree binding for Avago APDS990X light sensor
In-Reply-To: <20171227200147.GB16799@amd>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
Message-ID: <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 09:01:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > +Required properties:
> > > +- compatible: "avago,apds990x"
> > > +- reg: address on the I2C bus
> > > +- interrupts: external interrupt line number
> > > +- Vdd-supply: power supply for VDD
> > > +- Vled-supply: power supply for LEDA
> > 
> > AFAIK the custom is to use lower case letters for regulator supplies.
> > 
> > > +- ga: Glass attenuation
> > > +- cf1: Clear channel factor 1
> > > +- irf1: IR channel factor 1
> > > +- cf2: Clear channel factor 2
> > > +- irf2: IR channel factor 2
> > > +- df: Device factor
> > > +- pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
> > > +- ppcount: Proximity pulse count
> > 
> > Are these device specific? If so, please add the vendor prefix to them.
> 
> Well, whole binding is "vendor specific". Does it make sense to add
> prefix in such case?

Yes, it does. If you later find one or more of these are generic, you could
remove the vendor prefix. I doubt that'll happen though, these seem very
device specific parameters.

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
