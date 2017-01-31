From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 31 Jan 2017 08:59:19 +0100
Subject: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
In-Reply-To: <20170129164719.eulijkfarzrm2o6j@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-17-quentin.schulz@free-electrons.com>
 <20170129164719.eulijkfarzrm2o6j@earth>
Message-ID: <2dc8ffb5-af22-8224-f0b8-e2d6d8ab8ca3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29/01/2017 17:47, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jan 27, 2017 at 09:54:49AM +0100, Quentin Schulz wrote:
>>  - added x-powers,constant-charge-current property to set the
>>  maximal default constant current charge of the battery,
> 
> Since this is information about the battery and not the fuel-gauge,
> it should use the WIP "framework" for information about batteries.
> 
> Have a look at the following patchset:
> 
> http://marc.info/?l=linux-pm&m=148411561025684&w=2
> 

OK. So what you propose is to have a fourth property in this new
structure named design-max-constant-charge-current that gives the
maximal input amperage the battery can receive?

Then, I set the charger to output a maximum of this amperage by default
and let the user the possibility to choose between the minimum allowed
by the PMIC and the maximum allowed by the battery from sysfs. That
makes more sense than what I do here in the way that I didn't protect a
possible over-amperage of the battery, thing that Chen-Yu was afraid
some users would do.

I've a comment on the linked patches however. Though the three
properties are listed as optional in the binding-dt, the implementation
is saying the opposite:

http://marc.info/?l=linux-pm&m=148411561725693&w=2

If I'm not mistaken, if `nominal-microvolt' or `design-microwatt-hours'
is not a property of the DT node, power_supply_get_battery_info will
return without parsing the other properties and even return a negative
error.

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/746ba7b8/attachment-0001.sig>
