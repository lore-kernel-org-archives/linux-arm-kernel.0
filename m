From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 18 Oct 2016 17:30:11 +0200
Subject: [PATCH v2 2/4] ARM: dts: pxa: add pxa25x cpu operating points
In-Reply-To: <20161018113944.GC11471@vireshk-i7> (Viresh Kumar's message of
 "Tue, 18 Oct 2016 17:09:44 +0530")
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-3-git-send-email-robert.jarzmik@free.fr>
 <20161018113944.GC11471@vireshk-i7>
Message-ID: <87vawp4qv0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 15-10-16, 21:57, Robert Jarzmik wrote:
>> Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
>> Thermal Specfication. This will be input data for cpufreq-dt driver.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  arch/arm/boot/dts/pxa25x.dtsi | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
>> index 0d1e012178c4..16b4e8bad4a5 100644
>> --- a/arch/arm/boot/dts/pxa25x.dtsi
>> +++ b/arch/arm/boot/dts/pxa25x.dtsi
>> @@ -89,4 +89,29 @@
>>  		clocks = <&clktimer>;
>>  		status = "okay";
>>  	};
>> +
>> +	pxa250_opp_table: opp_table0 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp at 99500 {
>
> We have been keeping the values in ^^^ same as the values present
> below. Any specific reason for making it different here ?
No, that's a good comment, I'll change that.

I wrote this incrementaly, first the node, then the opp-hz. Then I realized that
the source crystal, at 3.8684 MHz didn't provide a round 99.5 MHz core clock,
but a 99.5328 MHz clock.

Anyway, I'll change that ... let's say into opp at 99533 in this case ?

-- 
Robert
