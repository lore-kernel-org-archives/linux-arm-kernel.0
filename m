From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu, 1 Jun 2017 08:50:35 +0200
Subject: [PATCH v2 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic_stby_poweroff property
In-Reply-To: <20170531145255.GC10351@leverpostej>
References: <20170531061457.23744-1-o.rempel@pengutronix.de>
 <20170531061457.23744-2-o.rempel@pengutronix.de>
 <20170531145255.GC10351@leverpostej>
Message-ID: <b9ba2cce-5383-636e-8e2c-4d85b2a92cb6@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.05.2017 um 16:52 schrieb Mark Rutland:
> On Wed, May 31, 2017 at 08:14:52AM +0200, Oleksij Rempel wrote:
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Cc: kernel at pengutronix.de
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-clk at vger.kernel.org
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> index 9252912a5b0e..214cb5f461c7 100644
>> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
>> @@ -6,6 +6,10 @@ Required properties:
>>  - interrupts: Should contain CCM interrupt
>>  - #clock-cells: Should be <1>
>>  
>> +Optional properties:
>> +- fsl,pmic_stby_poweroff: Configure CCM to assert PMIC_STBY_REQ signal
>> +  on power off.
> 
> s/_/-/ in property names, please.

ok.

I have now some more questions:
what naming schema should be actually used?
fsl,pmic-stby-poweroff
or
fsl,pmic-stby-power-off

i found some existing case:
sound/rt5660.txt:- realtek,poweroff-in-suspend
so in my case it will be:
fsl,standby-in-poweroff
or
fsl,standby-in-power-off

can we have generic name for this use case?
should I use same binding for PMIC and the SoC or they should be more like:
for SoC "standby-in-power-off"
and for PMIC "power-off-in-standby"



> When/why is this needed?
> 
> Why should a DT author (not) set this?
> 
> Thanks,
> Mark.
> 
>> +
>>  The clock consumer should specify the desired clock by having the clock
>>  ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
>>  for the full list of i.MX6 Quad and DualLite clock IDs.
>> -- 
>> 2.11.0
>>


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/8b5a51cc/attachment.sig>
