From: maj@jamers.net (Mark James)
Date: Thu, 19 Mar 2015 17:23:45 +0000
Subject: ARM: socfpga: dts: fix spi1 interrupt
In-Reply-To: <550AD9CD.5020805@opensource.altera.com>
References: <55089E1B.7000600@jamers.net>
 <20150318080950.GB10862@pengutronix.de>
 <550AD9CD.5020805@opensource.altera.com>
Message-ID: <550B0621.3070101@jamers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Thank you for that - I thought I would be all good with what I sent having changed the settings in Thunderbird as per Documentation/email-clients.txt, evidently not! Will do some more reading before submitting any more patches.

Thanks again,

Mark

On 19/03/15 14:14, Dinh Nguyen wrote:
> On 03/18/2015 03:09 AM, Steffen Trumtrar wrote:
>> Hi!
>>
>> On Tue, Mar 17, 2015 at 09:35:23PM +0000, Mark James wrote:
>>> Hello,
>>>
>>> The socfpga.dtsi currently has the wrong interrupt number set for SPI master 1. Trying to use the master without this change results in the kernel boot process waiting forever for an interrupt that will never occur while attempting to probe any slave devices configured in the device tree as being under SPI master 1.
>>>
>>> The change works for the Cyclone V, and according to the Arria 5 handbook should be good there too.
>>>
>>>
>>> Signed-off-by: Mark James <maj@jamers.net>
>>> Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>
>>> ---
>>>  arch/arm/boot/dts/socfpga.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>> index 9d87609..d9176e6 100644
>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>> @@ -660,7 +660,7 @@
>>>  			#address-cells = <1>;
>>>  			#size-cells = <0>;
>>>  			reg = <0xfff01000 0x1000>;
>>> -			interrupts = <0 156 4>;
>>> +			interrupts = <0 155 4>;
>>>  			num-cs = <4>;
>>>  			clocks = <&spi_m_clk>;
>>>  			status = "disabled";
>>
>> Thanks for sending the patch to the mainline list.
>> One little nitpick about the patchformat though:
>>
>> Please add linebreaks after 70-75 characters for readability. And remove the
>> "Hello,\n\n" otherwise this would land in the final git commit, where it
>> doesn't belong.
>> For reference have a look at Documentation/SubmittingPatches in the kernel
>> tree.
>>
>> Maybe Dinh can fix this up, otherwise he will tell you what to do.
>>
> 
> Yes, I can pick this up and fix up the commit.
> 
> Dinh
> 
