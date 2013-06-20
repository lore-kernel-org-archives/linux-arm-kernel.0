From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Jun 2013 12:35:10 -0300
Subject: [PATCH 1/6] ARM: mx27: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1371742088.528552668@f66.mail.ru>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
 <1371739815-6666-2-git-send-email-mpa@pengutronix.de>
 <1371742088.528552668@f66.mail.ru>
Message-ID: <CAOMZO5AaZSAsvNUCOqTuqx7UGCrGH6Cm-Uz9wN3nO1e1XU_usw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 12:28 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
>> task for the clock devices easier.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> [Markus Pargmann: Add gpio clocks]
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx27.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
>> index 0695264..48c263c 100644
>> --- a/arch/arm/boot/dts/imx27.dtsi
>> +++ b/arch/arm/boot/dts/imx27.dtsi
>> @@ -208,6 +208,8 @@
>>                               #gpio-cells = <2>;
>>                               interrupt-controller;
>>                               #interrupt-cells = <2>;
>> +                             clocks = <&clks 47>;
>> +                             clock-names = "ipg";
>
> Clock is not used in the gpio driver, so I doubt the usefulness of this patch.

I think you meant "this hunk", right?

My original patch did not have this part. It was added by Markus as
mentioned in the commit log, and I agree we should go with the
original version that did not add the gpio clock.
