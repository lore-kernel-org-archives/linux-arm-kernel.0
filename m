From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 30 Sep 2009 17:30:28 -0400
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <4AC3B748.5060904@bluewatersys.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>
	<4AC3B748.5060904@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 30, 2009 12:54 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> The clock generation system in the ep93xx uses two external oscillator's
>> and two internal PLLs to derive all the internal clocks.  Many of these
>> internal clocks can be stopped to save power.
>> 
>> This introduces a "parent" hierarchy for the clocks so that the users
>> count can be correctly tracked for power management.
>> 
>> The "parent" for the video clock can either be one of the PLL outputs
>> or the external oscillator.  In order to correctly track the "parent"
>> for the video clock calc_clk_div() needed to be modified.  It now
>> returns an error code if the desired rate cannot be generated.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> ---
>> 
>
> Acked-by: Ryan Mallon <ryan@bluewatersys.com>

Russell,

As the clkdev maintainer, do you see any problems with this?

Thanks,
Hartley
