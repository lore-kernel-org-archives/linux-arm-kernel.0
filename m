From: robherring2@gmail.com (Rob Herring)
Date: Fri, 06 Jan 2012 15:30:54 -0600
Subject: [PATCH v2 1/5] arm/dts: OMAP4: Update DTS file with new GIC
 bindings
In-Reply-To: <20120106211558.GA7457@ponder.secretlab.ca>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
 <1324388398-2683-2-git-send-email-b-cousson@ti.com>
 <20120106211558.GA7457@ponder.secretlab.ca>
Message-ID: <4F07680E.8000404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2012 03:15 PM, Grant Likely wrote:
> On Tue, Dec 20, 2011 at 02:39:54PM +0100, Benoit Cousson wrote:
>> The GIC binding was updated in 3.2 and expect 3 interrupt-cells.
>> - Update the #interrupt-cells
>> - interrupt-parent seems to be needed as well for the top level GIC
> 
> Hmmm... it shouldn't be.  If it is then it is a bug.
> 

I think this is an old comment which I fixed in 3.2, so interrupt-parent
can be removed.

Rob

> g.
> 
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 4c61c82..bede009 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -95,7 +95,8 @@
>>  		gic: interrupt-controller at 48241000 {
>>  			compatible = "arm,cortex-a9-gic";
>>  			interrupt-controller;
>> -			#interrupt-cells = <1>;
>> +			interrupt-parent;
>> +			#interrupt-cells = <3>;
>>  			reg = <0x48241000 0x1000>,
>>  			      <0x48240100 0x0100>;
>>  		};
>> -- 
>> 1.7.0.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
