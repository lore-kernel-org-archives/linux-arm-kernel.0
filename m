From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 23 Apr 2014 11:49:29 +0200
Subject: [linux-sunxi] Re: [PATCH v8 10/17] ARM: dts: sun6i: Add mmc clocks
In-Reply-To: <20140423094426.GK24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-11-git-send-email-hdegoede@redhat.com>
 <20140423094426.GK24905@lukather>
Message-ID: <53578CA9.2070703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/23/2014 11:44 AM, Maxime Ripard wrote:
> On Tue, Apr 22, 2014 at 01:01:30PM +0200, Hans de Goede wrote:
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
> This is simply not true.
> 
> module0 clocks don't have any kind of phase control, while we do here.

We've the exact same situation for all of sun4i, sun5i and sun7i. IMHO
it would be much simpler to keep things uns sync everywhere, until we actually
know how we want to deal with the phase control stuff, and then change
the compatible, etc. everywhere at once.

Regards,

Hans
