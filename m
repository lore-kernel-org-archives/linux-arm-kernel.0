From: joel@jms.id.au (Joel Stanley)
Date: Wed, 4 Oct 2017 14:54:57 +0930
Subject: [PATCH 4/8] ARM: dts: aspeed-romulus: Add I2C devices
In-Reply-To: <1507093339.5452.13.camel@aj.id.au>
References: <20170928075149.8154-1-joel@jms.id.au>
 <20170928075149.8154-5-joel@jms.id.au>
 <1507093339.5452.13.camel@aj.id.au>
Message-ID: <CACPK8Xf8tEvdaCr2vyUfPRw5oxN_A4PCaCKzWBXJC_CGOmz=Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 2:32 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Thu, 2017-09-28 at 17:21 +0930, Joel Stanley wrote:
>> Enable the buses that are in use and the devices that are attached.
>> Currently that is just the battery backed RTC.
>>
>> Some of these buses are for hotplugged cards, such as PCIe cards. Others
>> do not yet have upstream drivers, so there are no devices attached.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 54 ++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
>> index 1190fec1b5d0..f79c1d21c47f 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
>> @@ -79,3 +79,57 @@
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_rmii1_default>;
>>  };
>> +
>> +&i2c2 {
>> +     status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +     status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +     status = "okay";
>> +};
>> +
>> +&i2c5 {
>> +     status = "okay";
>> +};
>> +
>> +&i2c6 {
>> +     /* PCIe slot 1 (x8) */
>> +     status = "enabled";
>
> This is not okay. Neither are those below.

Hah. Well spotted.

Cheers,

Joel
