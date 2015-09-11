From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Sat, 12 Sep 2015 07:44:37 +0800
Subject: [PATCH 2/2] ARM: dts: support Highspeed for rk3066a platform
In-Reply-To: <25757012.mQz0HMffNZ@diego>
References: <1441956268-10418-1-git-send-email-shawn.lin@rock-chips.com>
 <1441956341-10623-1-git-send-email-shawn.lin@rock-chips.com>
 <25757012.mQz0HMffNZ@diego>
Message-ID: <55F36765.2040703@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015/9/12 6:45, Heiko St?bner ??:
> Hi Shawn,
>
> Am Freitag, 11. September 2015, 15:25:41 schrieb Shawn Lin:
>> Add cap-sd-highspeed and cap-mmc-highspeed for rk3066a
>> platform to make sd cards running faster.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   arch/arm/boot/dts/rk3066a.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
>> index 946f187..b50a785 100644
>> --- a/arch/arm/boot/dts/rk3066a.dtsi
>> +++ b/arch/arm/boot/dts/rk3066a.dtsi
>> @@ -595,6 +595,8 @@
>>   &mmc0 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
>> +	cap-mmc-highspeed;
>> +	cap-sd-highspeed;
>>   };
>>
>
> Currently we're setting the dw_mmc capabilities in the individual board files
> and patch1 also correctly adds the cap to the radxarock file.
>

Thanks, Heiko. :)

Right, I was condering add caps in rk3066a for all boards which include 
it or for each individual board. Unfortunately, I chose the wrong one.:(


Done in the v2.

> So I'd think we should stay with one scheme and probably add the rk3066 caps
> to the bqcurie2, marsboard and rayeager where applicable.
>
>
> Heiko
>
>
>


-- 
Best Regards
Shawn Lin
