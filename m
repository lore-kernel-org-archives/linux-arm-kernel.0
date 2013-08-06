From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 06 Aug 2013 14:05:24 +0200
Subject: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <20130716080503.GA3125@lukather>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
Message-ID: <5200E684.5080003@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2013 10:05, Maxime Ripard wrote:
> Hi Gregory,
> 
> On Mon, Jul 15, 2013 at 04:24:36PM +0200, Gregory CLEMENT wrote:
>> The I2C Transaction Generator offloads CPU from managing I2C transfer step by step.
>> 
>> This feature is currently only available on Armada XP, so usage of this mechanism is activated through device tree.
>> 
>> Based on the work of Piotr Ziecik and rewrote to use the new way of handling multiples i2c messages.
>> 
>> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com> --- drivers/i2c/busses/i2c-mv64xxx.c | 207
>> ++++++++++++++++++++++++++++++++++++--- 1 file changed, 196 insertions(+), 11 deletions(-)
> 
> [...]
> 
>> +	/* +	 * For controllers embedded in new SoCs activate the +	 * Transaction Generator support. +	 */ +	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) +
>> drv_data->offload_enabled = true; +
> 
> Do you have a reason for not adding it to the match table? I mean, you will introduce a new compatible here, but if that compatible is used alone, won't probe the driver? That doesn't
> seem very right to me.

But we shouldn't use it alone: we should always use:
compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";

>From my point of view using  "marvell,mv78230-i2c" alone is an error.

Wolfram what is your opinion on it?


> 
> Also, you should probably add it to the bindings documentation.
See the patch 3 for the bindings documentation.

> 
> Maxime
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
