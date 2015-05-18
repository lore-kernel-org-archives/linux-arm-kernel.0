From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 18 May 2015 18:01:54 +0200
Subject: [PATCH v4 3/3] ARM: berlin: add an ADC node for the BG2Q
In-Reply-To: <55587E28.7070504@kernel.org>
References: <1431339531-11938-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431339531-11938-4-git-send-email-antoine.tenart@free-electrons.com>
 <55587E28.7070504@kernel.org>
Message-ID: <555A0CF2.7040403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.05.2015 13:40, Jonathan Cameron wrote:
> On 11/05/15 11:18, Antoine Tenart wrote:
>> This patch adds the ADC node for the Berlin BG2Q, using the newly added
>> Berlin IIO ADC driver.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>
> The driver support will be working it's way through to mainline in the
> next merge window.  Obviously I 'could' take this through IIO, but not
> without an appropriate Ack.
>
> Hence I'll assume it's going through the arm-soc tree.

The node patch just fits right on top of the branch that reworks
the existing nodes of chip/system control nodes, i.e. where the
adc belongs to.

I'll pick the dts patch and will send it as part of the PR later
this week. As you already applied the driver and binding doc, this
is rather independent anyway.

Sebastian

>> ---
>>   arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
>> index 187d056f7ad2..97c7e19e3ec6 100644
>> --- a/arch/arm/boot/dts/berlin2q.dtsi
>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
>> @@ -565,6 +565,13 @@
>>   						function = "twsi3";
>>   					};
>>   				};
>> +
>> +				adc: adc {
>> +					compatible = "marvell,berlin2-adc";
>> +					interrupt-parent = <&sic>;
>> +					interrupts = <12>, <14>;
>> +					interrupt-names = "adc", "tsen";
>> +				};
>>   			};
>>
>>   			sic: interrupt-controller at e000 {
>>
>
