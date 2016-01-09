From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sat, 9 Jan 2016 11:04:36 +0800
Subject: [RESEND RFC PATCH 2/2] ARM: dts: rockchip: Update the cpu freqs
 table
In-Reply-To: <4951150.PYM4FhWu6V@phil>
References: <1452252698-16765-1-git-send-email-zhengxing@rock-chips.com>
 <1452252698-16765-3-git-send-email-zhengxing@rock-chips.com>
 <4951150.PYM4FhWu6V@phil>
Message-ID: <569078C4.8080000@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016?01?09? 03:16, Heiko Stuebner wrote:
> Hi Xing,
>
> Am Freitag, 8. Januar 2016, 19:31:38 schrieb Xing Zheng:
>> Actually, we need more cpu freqs which are 50MHz integer multiples.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> ---
>>
>>   arch/arm/boot/dts/rk3036.dtsi |   13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
>> index 1cb5877..1a773eb 100644
>> --- a/arch/arm/boot/dts/rk3036.dtsi
>> +++ b/arch/arm/boot/dts/rk3036.dtsi
>> @@ -79,7 +79,18 @@
>>   			resets = <&cru SRST_CORE0>;
>>   			operating-points = <
>>   				/* KHz    uV */
>> -				 816000 1000000
>> +				1200000 1200000
>> +				1100000 1200000
>> +				1000000 1200000
>> +				 900000 1200000
>> +				 800000 1200000
>> +				 700000 1200000
>> +				 600000 1200000
>> +				 500000 1200000
>> +				 400000 1200000
>> +				 300000 1200000
>> +				 200000 1200000
>> +				 100000 1200000
> what about reducing the voltage as well?
>
> >From rk3288-specific discussions I remember that reducing the frequency
> without touching the voltage, didn't really save so much energy.
> And it looks like it was running 816MHz at 1.0V just fine as well.
>
> I guess you should find out which voltages are really necessary for each
> step.
>
>
> Heiko
>
Thank you for your comments. :-)

Yes, these patches currently still in draft stage. Modify the frequency 
of 816MHz is for mac apll patch can be FROMLIST for Kylin Board,
and will work cpu frequency table as a start.

We know you want to set the appropriate frequency of different batches 
of The RK3036 SoCs take some time,so I just tested a fixed
high voltage 1.2v on my evb board, the frequency of the voltage to 
ensure that we can work needed.
We'll start work dynamically adjust the voltage.

Thanks.

- Xing Zheng
