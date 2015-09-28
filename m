From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Sep 2015 13:49:10 -0600
Subject: [PATCH 3/3] ARM: bcm2835: Add the auxiliary clocks to the device
 tree.
In-Reply-To: <87si5ymjki.fsf@eliezer.anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
 <1441923750-19404-4-git-send-email-eric@anholt.net>
 <5600BAC3.70506@wwwdotorg.org> <87si5ymjki.fsf@eliezer.anholt.net>
Message-ID: <560999B6.7080400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2015 01:26 PM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 09/10/2015 03:22 PM, Eric Anholt wrote:
>>> These will be used for enabling UART1, SPI1, and SPI2.
>>
>>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>>
>>> +		aux_clocks: aux-clocks at 0x7e215004 {
>>> +			compatible = "brcm,bcm2835-aux-clock";
>>> +			#clock-cells = <1>;
>>> +			reg = <0x7e215004 0x4>;
>>
>> Actually, I take back the ack on this patch. This HW module has two
>> registers. The reg property should include both of those registers so
>> that if SW needs to start using the other register at some time in the
>> future, the entire set of registers is already represented in DT.
>
> If I changed it to "reg = <0x7e215000 0x8>" and use a #define for the
> clock register offset in patch 2/3, would I then have your ack?

I suspect the compatible should then be "brcm,bcm2835-aux" (or similar) 
since the node would represent the entire aux module, not just the clock 
gate feature of the module (assuming there are other features in the aux 
module besides just the clock gate).

With the reg change and the compatible change if appropriate, you can 
have my ack,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
