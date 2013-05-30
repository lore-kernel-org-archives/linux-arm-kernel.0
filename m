From: rogerq@ti.com (Roger Quadros)
Date: Thu, 30 May 2013 12:13:22 +0300
Subject: [PATCH] ARM: OMAP2+: omap-usb-host: clean up pin mux setup code
In-Reply-To: <20130508235232.GW32546@atomide.com>
References: <1366624673-2684-1-git-send-email-rogerq@ti.com>
 <20130508235232.GW32546@atomide.com>
Message-ID: <51A71832.70305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2013 02:52 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130422 03:02]:
>> The USB host pins are named quite differently between OMAP3 and
>> OMAP4+ SoCs. To make this managable in code, we create a pin mapping
>> table (pin_names) that maps pin function to pin name.
>>
>> This pin mapping table is populated at runtime based on a pin
>> name template. Templates are provided for OMAP3 and 4 SoCs.
>>
>> The setup_io_mux() function uses the pin mapping table to
>> setup the pin mux.
>>
>> The resulting code is a lot more clean, manageable and scalable.
> 
> I'm planning to drop all the omap4 pdata soonish. Will post some
> patches after -rc1 to do that. Do you still need this patch
> considering that?
> 

In that case we don't need this.

cheers,
-roger
