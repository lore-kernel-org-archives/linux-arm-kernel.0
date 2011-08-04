From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 4 Aug 2011 13:30:21 -0500
Subject: [PATCH] ep93xx: use DEFINE_RES_* helpers
In-Reply-To: <20110804182248.GB2445@mwesterb-mobl.ger.corp.intel.com>
References: <201108021629.05478.hartleys@visionengravers.com>
	<20110804182248.GB2445@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3882B8C48@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 04, 2011 11:23 AM, Mika Westerberg wrote:
> On Tue, Aug 02, 2011 at 04:29:05PM -0700, H Hartley Sweeten wrote:
>
>> @@ -590,11 +543,7 @@ static struct platform_device ep93xx_pwm0_device = {
>>  };
>>  
>>  static struct resource ep93xx_pwm1_resource[] = {
>> -	{
>> -		.start	= EP93XX_PWM_PHYS_BASE + 0x20,
>> -		.end	= EP93XX_PWM_PHYS_BASE + 0x30 - 1,
>> -		.flags	= IORESOURCE_MEM,
>> -	},
>> +	DEFINE_RES_MEM(EP93XX_PWM_PHYS_BASE + 0x10, 0x10),
>
> Should this be
>
>	DEFINE_RES_MEM(EP93XX_PWM_PHYS_BASE + 0x20, 0x10),

Doh!  Will fix.

> Otherwise
>
> Reviewed-by: Mika Westerberg <mika.westerberg@iki.fi>

Thanks,
Hartley
