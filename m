From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Mar 2013 11:30:45 -0600
Subject: [PATCH V2 1/4] ARM: tegra: dalmore: add cpu regulator node
In-Reply-To: <514B1412.9060707@cogentembedded.com>
References: <1363873663-19272-1-git-send-email-ldewangan@nvidia.com>
 <1363873663-19272-2-git-send-email-ldewangan@nvidia.com>
 <514B1412.9060707@cogentembedded.com>
Message-ID: <514B43C5.6060404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 08:07 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 21-03-2013 17:47, Laxman Dewangan wrote:
> 
>> Dalmore uses the TPS51632 as CPU regulator. The device is connected
>> on I2C5.
> 
>> Add DT node for TPS51632.

>> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts

>> +    i2c at 7000d000 {
>> +        status = "okay";
>> +        clock-frequency = <400000>;
>> +
>> +        tps51632 {
> 
>    Should be named "tps51632 at 43" I think.

The unit-address (i.e. "@43" part) of the node name is typically omitted
if it isn't required to make the node name unique.
