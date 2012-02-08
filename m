From: khilman@ti.com (Kevin Hilman)
Date: Wed, 08 Feb 2012 15:06:15 -0800
Subject: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
In-Reply-To: <20120208184539.GE29796@atomide.com> (Tony Lindgren's message of
 "Wed, 8 Feb 2012 10:45:39 -0800")
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
 <20120208184539.GE29796@atomide.com>
Message-ID: <87ty312ae0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
>> While testing on my OMAP3430 platform, this error message was emitted:
>> 
>> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
>> 
>> Trying to find this message was difficult because it was wrapped across
>> several lines.  It also mis-spells "required", doesn't read very well,
>> and has spaces lacking.  Let's replace it with a more concise:
>> 
>> omap_vc_init_channel: No PMIC info for vdd_core
>> 
>> While we're here, fix a simple spelling error in a comment.
>> 
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Acked-by: Tony Lindgren <tony@atomide.com>

NAK.

Tony, please use the patches already in your cleanup branch (that came
from my for_3.3/cleanup/pm) that fix this and also fix a similar problem
for VP.

Thanks,

Kevin
