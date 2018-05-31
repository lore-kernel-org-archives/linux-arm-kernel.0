From: faiz_abbas@ti.com (Faiz Abbas)
Date: Thu, 31 May 2018 16:56:46 +0530
Subject: [PATCH v2 5/6] ARM: dts: Add generic interconnect target module
 node for MCAN
In-Reply-To: <20180531040638.GA26751@rob-hp-laptop>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-6-faiz_abbas@ti.com>
 <20180531040638.GA26751@rob-hp-laptop>
Message-ID: <be0fd711-c44b-dbe2-648f-08aa88c7aec4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 31 May 2018 09:36 AM, Rob Herring wrote:
> On Wed, May 30, 2018 at 07:41:32PM +0530, Faiz Abbas wrote:
>> The ti-sysc driver provides support for manipulating the idlemodes
>> and interconnect level resets.
>>
>> Add the generic interconnect target module node for MCAN to support
>> the same.
>>
>> CC: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  arch/arm/boot/dts/dra76x.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
>> index bfc82636999c..57b8dc0fe719 100644
>> --- a/arch/arm/boot/dts/dra76x.dtsi
>> +++ b/arch/arm/boot/dts/dra76x.dtsi
>> @@ -11,6 +11,25 @@
>>  / {
>>  	compatible = "ti,dra762", "ti,dra7";
>>  
>> +	ocp {
>> +
>> +		target-module at 0x42c00000 {
> 
> Build your dtb with W=1 and fix warnings you add (drop '0x').

Sure, Will fix this.
> 
> This is a CAN bus controller? If so, then use 'can' for node name.

Yes but I am using m_can along the lines of dcan in other boards (For
example, see arch/arm/boot/dts/am33xx.dtsi:1046). Are you saying all CAN
controllers should only be called can?

Thanks,
Faiz
