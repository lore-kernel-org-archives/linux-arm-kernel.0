From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 29 Apr 2014 10:29:02 +0200
Subject: [PATCH v9 10/17] ARM: dts: sun6i: Add mmc clocks
In-Reply-To: <20140428193753.GJ3134@lukather>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-11-git-send-email-hdegoede@redhat.com>
 <20140428193753.GJ3134@lukather>
Message-ID: <535F62CE.20606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/28/2014 09:37 PM, Maxime Ripard wrote:
> On Sat, Apr 26, 2014 at 12:16:14PM +0200, Hans de Goede wrote:
>> Add clk-nodes for the mmc clocks.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index d45efa7..12bcc17 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -198,6 +198,38 @@
>>  					"apb2_uart4", "apb2_uart5";
>>  		};
>>  
>> +		mmc0_clk: clk at 01c20088 {
>> +			#clock-cells = <0>;
>> +			compatible = "allwinner,sun4i-a10-mod0-clk";
> 
> And this is not misleading but wrong. The MMC clocks have the phase
> control feature that mod0 clock don't have, so they should have a
> compatible of their own.

You said the same thing when I posted v8, and I replied to that, that
this is the exact same construction used as with sun4i, sun5i and sun7i.

I agree this needs to be fixed, but it needs to be fixed for *all* of
them, and IMHO it is best to be consistently "wrong" for now and then
fix them all in one go (and all in the same way) when we've landed a
generic way of dealing with phase-control.

So for now I'm going to keep this as is, iow the same as the clock
bindings for mmc which we already have for sun4i, sun5i and sun7i
which all have the same issue.

Regards,

Hans
