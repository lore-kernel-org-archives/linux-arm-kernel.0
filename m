From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 Sep 2011 13:17:32 -0500
Subject: [RFC PATCH 03/11] DT: regulator: Helper routine to extract
	regulator_init_data
In-Reply-To: <20110915134427.GJ7988@opensource.wolfsonmicro.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<20110915134427.GJ7988@opensource.wolfsonmicro.com>
Message-ID: <4E72413C.7020508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2011 08:44 AM, Mark Brown wrote:
> On Thu, Sep 15, 2011 at 04:51:59PM +0530, Rajendra Nayak wrote:
> 
>>  .../devicetree/bindings/regulator/regulator.txt    |   37 +++++++++
>>  drivers/of/Kconfig                                 |    6 ++
>>  drivers/of/Makefile                                |    1 +
>>  drivers/of/of_regulator.c                          |   85 ++++++++++++++++++++
>>  include/linux/of_regulator.h                       |   23 +++++
> 
> Don't go hiding the bindings for things away from the code they're
> binding.  Bindings for the regualtor API are a regulator API thing and
> should be part of the regulator API code.
> 

Agreed, but FYI not all subsystem maintainers agree. Moving of_i2c.c
into i2c was rejected.

Rob

>> +Required properties:
>> +- compatible: Must be "regulator";
> 
> Is this idiomatic or should we just have a helper that parses a big list
> of properties from the device node?
> 
>> +- mode-fast: boolean, Can handle fast changes in its load
>> +- mode-normal: boolean, Normal regulator power supply mode
>> +- mode-idle: boolean, Can be more efficient during light loads
>> +- mode-standby: boolean, Can be most efficient during light loads
> 
> I guess these are actually permissions to set the given modes?  The
> documentation should be clearer.
> 
>> +- apply-uV: apply uV constraint if min == max
> 
> This seems a bit Linux/runtime policy specific (especially the last
> bit).
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
