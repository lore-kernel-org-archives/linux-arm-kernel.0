From: blogic@openwrt.org (John Crispin)
Date: Thu, 28 Jan 2016 19:13:48 +0100
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <20160127144105.GQ6042@sirena.org.uk>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
Message-ID: <56AA5A5C.9080402@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/01/2016 15:41, Mark Brown wrote:
> On Wed, Jan 27, 2016 at 01:00:59PM +0100, John Crispin wrote:
> 
>> +		/* Constrain board-specific capabilities according to what
>> +		 * this driver and the chip itself can actually do.
>> +		 */
>> +		c = rdev->constraints;
>> +		c->valid_modes_mask |= REGULATOR_MODE_NORMAL |
>> +				       REGULATOR_MODE_STANDBY;
>> +		c->valid_ops_mask |= REGULATOR_CHANGE_MODE;
> 
> No, drivers should *never* enable things that weren't explictly enabled
> by the machine constraints.  This misses the whole point of having
> constraints.  They are there so that the system integrator can enable
> the functionality that is safe on a given board.  
> 
> The comment is also inaccurate, it claims it's imposing constraints but
> in fact it's adding additional permissions.
> 

Hi Mark

would the following two bindings be ok ? I would create patches to add them.

* regulator-allow-mode; or regulator-allow-change-mode;
* regulator-modes = <REGULATOR_MODE_NORMAL REGULATOR_MODE_STANDBY>;

	John
