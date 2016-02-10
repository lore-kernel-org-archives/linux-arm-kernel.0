From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 10 Feb 2016 02:19:03 +0200
Subject: [PATCH 00/11] clk: lpc32xx: add clock support for NXP LPC32xx
In-Reply-To: <loom.20160209T215103-78@post.gmane.org>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <loom.20160209T215103-78@post.gmane.org>
Message-ID: <56BA81F7.4080006@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 09.02.2016 23:01, Sylvain Lemieux wrote:
> Vladimir Zapolskiy <vz@...> writes:
>>
>> This changeset adds common clock framework driver for NXP LPC32xx
>> boards.
> 
> Hi Vladimir,
> 
> Just to let you know that we did some testing using this changeset;
> I installed patches 4 to 7, 10 & 11 on top of 4.5-rc1.
> 
> I was able to run our software (SIC1 interrupt sources disable)
> without any problem a custom LPC32xx board.

this is a known issue, and I hope it will be fixed in upstream in v4.6,
the required changes in irqchip and gpiochip drivers were sent for
review some time ago, a bit more work is needed to 

Also 2-3 more clean-up changes in USB host and gadget drivers are done
locally (no more need to configure clocks out of the common clock
framework), but not yet submitted, will do it tomorrow.

> We did not get any problem with the clock signals we are using.
> 

Thank you for testing, I'm going to add your Tested-by tag (if you
don't mind) and submit a PR to ARM maintainers shortly.

>> Vladimir Zapolskiy (11):
>>   dt-bindings: clock: add description of LPC32xx clock controller
>>   dt-bindings: clock: add description of LPC32xx USB clock controller
>>   dt-bindings: clock: add NXP LPC32xx clock list for consumers
>>   arm: dts: lpc32xx: add device nodes for external oscillators
>>   arm: dts: lpc32xx: add clock controller device node
>>   arm: dts: lpc32xx: add clock properties to device nodes
>>   arm: dts: lpc32xx: add USB clock controller
>>   clk: lpc18xx: add NXP specific common clock framework selection
>>   clk: lpc32xx: add common clock framework driver
>>   arm: lpc32xx: switch to common clock framework
>>   arm: dts: lpc32xx: remove clock frequency property from UART device
>>     nodes
> 
> 

With best wishes,
Vladimir
