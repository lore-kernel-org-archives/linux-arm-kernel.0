From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Wed, 27 Dec 2017 23:15:48 +0200
Subject: [PATCH] Device tree binding for Avago APDS990X light sensor
In-Reply-To: <7a5d43a9-27f5-bdbd-780f-6c6bc47fb987@gmail.com>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <7a5d43a9-27f5-bdbd-780f-6c6bc47fb987@gmail.com>
Message-ID: <20171227211547.5gc7pg4lxqnjeht2@kekkonen.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 07:50:42PM +0100, Filip Matijevi? wrote:
> Hi Sakari,
> 
> and thank you for your input - I've added a few comments below.
> 
> On 12/27/2017 07:00 PM, Sakari Ailus wrote:
> > Hi Pavel,
> > 
> > Thanks for the patch. Please see my comments below.
> > 
> > On Wed, Dec 27, 2017 at 10:18:28AM +0100, Pavel Machek wrote:
> >> From: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> >>
> >> This prepares binding for light sensor used in Nokia N9. 
> >>
> >> Signed-off-by: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> >> Signed-off-by: Pavel machek <pavel@ucw.cz>
> >>
> >> ---
> >>
> >> Patches to convert APDS990X driver to device tree and to switch to iio
> >> are available.
> >>
> >> diff --git a/Documentation/devicetree/bindings/misc/avago-apds990x.txt b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
> >> new file mode 100644
> >> index 0000000..e038146
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
> >> @@ -0,0 +1,39 @@
> >> +Avago APDS990X driver
> >> +
> >> +Required properties:
> >> +- compatible: "avago,apds990x"
> >> +- reg: address on the I2C bus
> >> +- interrupts: external interrupt line number
> >> +- Vdd-supply: power supply for VDD
> >> +- Vled-supply: power supply for LEDA
> > 
> > AFAIK the custom is to use lower case letters for regulator supplies.
> 
> I've just used the same notation as in current driver. Datasheet calls
> those VDD (with DD being in subscript) and LEDA. I see no problem in
> changing those to vdd-supply and vled-supply if no one else objects.
> 
> > 
> >> +- ga: Glass attenuation
> >> +- cf1: Clear channel factor 1
> >> +- irf1: IR channel factor 1
> >> +- cf2: Clear channel factor 2
> >> +- irf2: IR channel factor 2
> >> +- df: Device factor
> >> +- pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
> >> +- ppcount: Proximity pulse count
> > 
> > Are these device specific? If so, please add the vendor prefix to them.
> 
> AFAIK yes - same as before if no one else objects, these will be changed.
> 
> > 
> > I might not use short abbreviations such as "df" either. I wonder what
> > others think.
> 
> These are also come from current driver - some of these comes from the
> datasheet itself, but not all. For example "ga" and "df" are in there
> (so I I would leave those alone), but "irf1" is called "B", "cf2" is
> called "C" and "irf2" is called "D" (I guess the missing "cf1" should be
> "A", but there is no such thing in the datasheet).
> IMHO using some other names might just add to the confusion.

Ack, datasheet names are fine.

You could also use a single property with all device specific coefficients
in a pre-defined order.

I don't have a strong opinion either way.

-- 
Regards,

Sakari Ailus
sakari.ailus at linux.intel.com
