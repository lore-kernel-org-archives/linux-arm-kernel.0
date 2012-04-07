From: robherring2@gmail.com (Rob Herring)
Date: Sat, 07 Apr 2012 14:04:37 -0500
Subject: [PATCH 2/7] of: add clock providers
In-Reply-To: <20120407041841.054AE3E2F59@localhost>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-3-git-send-email-robherring2@gmail.com>
 <20120407041841.054AE3E2F59@localhost>
Message-ID: <4F808FC5.6090601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2012 11:18 PM, Grant Likely wrote:
> On Tue, 13 Mar 2012 18:22:22 -0500, Rob Herring <robherring2@gmail.com> wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> Based on work by Ben Herrenschmidt and Jeremy Kerr, this patch adds an
>> of_clk_get function to allow platforms to retrieve clock data from the
>> device tree.
>>
>> Platform register a provider through of_clk_add_provider, which will be
>> called when a device references the provider's OF node for a clock
>> reference.
>>
>> v3: - Clarified documentation
>>
>> v2: - fixed errant ';' causing compile error
>>     - Editorial fixes from Shawn Guo
>>     - merged in adding lookup to clkdev
>>     - changed property names to match established convention. After
>>       working with the binding a bit it really made more sense to follow the
>>       lead of 'reg', 'gpios' and 'interrupts' by making the input simply
>>       'clocks' & 'clock-names' instead of 'clock-input-*', and to only use
>>       clock-output* for the producer nodes. (Sorry Shawn, this will mean
>>       you need to change some code, but it should be trivial)
>>     - Add ability to inherit clocks from parent nodes by using an empty
>>       'clock-ranges' property.  Useful for busses.  I could use some feedback
>>       on the new property name, 'clock-ranges' doesn't feel right to me.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> Reviewed-by: Shawn Guo <shawn.guo@freescale.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
>> Cc: Mike Turquette <mturquette@ti.com>
> 
> Hi Rob,
> 
> Thanks for respinning this patch.  Since you're actually using it, do
> you want to take over getting it into mainline?
> 

Yes. Is what you have on your public tree the latest?

>> ---
>>  .../devicetree/bindings/clock/clock-bindings.txt   |  116 ++++++++++++++
>>  .../devicetree/bindings/clock/fixed-clock.txt      |   21 +++
>>  drivers/clk/clkdev.c                               |    9 +
>>  drivers/of/Kconfig                                 |    6 +
>>  drivers/of/Makefile                                |    1 +
>>  drivers/of/clock.c                                 |  165 ++++++++++++++++++++
> 
> I would actually like to see this file moved into drivers/clk.  I
> don't think there is any need anymore to collect OF support code into
> drivers/of.  I plan to move the spi and gpio support code into
> drivers/spi and drivers/gpio respectively.
> 

You keep saying that and if you recall, the i2c maintainers objected to
doing that. I'd imagine you'll find the spi and gpio maintainer more
agreeable. ;)

I'll have to think about how to split it as much of it is really clkdev
code.

Rob
