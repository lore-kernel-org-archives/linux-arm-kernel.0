From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 20 Jun 2017 18:43:03 -0700
Subject: [PATCH v4 0/3] watchdog: dw_wdt: add reset lines
In-Reply-To: <738tknf5zp.fsf@pengutronix.de>
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
 <738tknf5zp.fsf@pengutronix.de>
Message-ID: <a6d32d71-6f66-18af-5283-036bf1ef93ce@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2017 12:55 AM, Steffen Trumtrar wrote:
> 
> Steffen Trumtrar <s.trumtrar@pengutronix.de> writes:
> 
>> Hi!
>>
>> This series adds support for the reset line that is (potentially) holding
>> the watchdog in reset.
>>
>> As the watchdog is useless if this happens, it needs to be deasserted in
>> the probe function.
>>
>> Tested on a Socrates board.
>>
>> Regards,
>> Steffen
>>
>>
>> Changes since v3:
>>
>>    - goto out_disable_clk
>>    - add Reviewed-by
>>
>> Changes since v2:
>>
>>    - use optional reset functions
>>    - add Acked-by to devictree bindings
>>
>> Changes since v1:
>>
>>    - remove reset-names property
>>    - remove warning if reset property is missing
>>
>> Steffen Trumtrar (3):
>>    watchdog: bindings: dw_wdt: add reset lines
>>    watchdog: dw_wdt: get reset lines from dt
>>    ARM: socfpga: dtsi: add dw-wdt reset lines
>>
>>   Documentation/devicetree/bindings/watchdog/dw_wdt.txt |  3 +++
>>   arch/arm/boot/dts/socfpga.dtsi                        |  2 ++
>>   drivers/watchdog/dw_wdt.c                             | 11 +++++++++++
>>   3 files changed, 16 insertions(+)
>>
>> base-commit: 2ea659a9ef488125eb46da6eb571de5eae5c43f6
> 
> Gentle Ping!
> 
> Is this series already applied somewhere I didn't look?
> 

https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next

 From there, we can only hope that Wim will find the time to pick it up for the next release.

The arm dts change will have to go through the arm tree(s) as usual.

Guenter
