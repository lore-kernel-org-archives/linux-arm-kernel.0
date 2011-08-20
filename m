From: robherring2@gmail.com (Rob Herring)
Date: Sat, 20 Aug 2011 13:22:52 -0500
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110820161048.GD13302@S2100-06.ap.freescale.net>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<20110820161048.GD13302@S2100-06.ap.freescale.net>
Message-ID: <4E4FFB7C.40806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2011 11:10 AM, Shawn Guo wrote:
> On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds basic support for the Calxeda Highbank platform.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
> [...]
>> +DT_MACHINE_START(HIGHBANK, "Highbank")
>> +	.map_io		= highbank_map_io,
>> +	.init_irq	= highbank_init_irq,
>> +	.nr_irqs	= NR_IRQS,
> 
> Is it really needed?

For single kernel binary, yes. See Nicolas Pitre's task list for
mach/irqs.h.

Rob

> 
>> +	.timer		= &highbank_timer,
>> +	.init_machine	= highbank_init,
>> +	.dt_compat	= highbank_match,
>> +MACHINE_END
> 
