From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Aug 2017 14:28:45 +0200
Subject: [PATCH v3 2/2] arm64: dts: marvell: mcbin: enable more networking
 ports
In-Reply-To: <20170830093641.GH31552@kwain> (Antoine Tenart's message of "Wed,
 30 Aug 2017 11:36:41 +0200")
References: <20170824084639.19282-1-antoine.tenart@free-electrons.com>
 <20170824084639.19282-2-antoine.tenart@free-electrons.com>
 <20170830093641.GH31552@kwain>
Message-ID: <87fuc944ua.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,
 
 On mer., ao?t 30 2017, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Hi Gregory,
>
> On Thu, Aug 24, 2017 at 10:46:39AM +0200, Antoine Tenart wrote:
>> This patch enables the two GE/SFP ports. They are configured in 10GKR
>> mode by default. To do this the cpm_xdmio is enabled as well, and two
>> phy descriptions are added.
>> 
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>> Tested-by: Marcin Wojtas <mw@semihalf.com>
>
> These DT changes (patches 1/2 and 2/2) came along a series with patches
> on the PPv2 driver. All the net part was merged in linux-next, but these
> two dt patches were not taken because we all were in holidays.
>
> I know it's very late, but it would be very nice to have these two
> patches merged for 4.14.

I added them to mvebu/dt64 and made a pull request with the patch from
Thomas.

Thanks,

Gregory

>
> Thanks!
> Antoine
>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 30 +++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
>> index abd39d1c1739..9f0a00802452 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
>> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
>> @@ -127,6 +127,30 @@
>>  	};
>>  };
>>  
>> +&cpm_xmdio {
>> +	status = "okay";
>> +
>> +	phy0: ethernet-phy at 0 {
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		reg = <0>;
>> +	};
>> +
>> +	phy8: ethernet-phy at 8 {
>> +		compatible = "ethernet-phy-ieee802.3-c45";
>> +		reg = <8>;
>> +	};
>> +};
>> +
>> +&cpm_ethernet {
>> +	status = "okay";
>> +};
>> +
>> +&cpm_eth0 {
>> +	status = "okay";
>> +	phy = <&phy0>;
>> +	phy-mode = "10gbase-kr";
>> +};
>> +
>>  &cpm_sata0 {
>>  	/* CPM Lane 0 - U29 */
>>  	status = "okay";
>> @@ -154,6 +178,12 @@
>>  	status = "okay";
>>  };
>>  
>> +&cps_eth0 {
>> +	status = "okay";
>> +	phy = <&phy8>;
>> +	phy-mode = "10gbase-kr";
>> +};
>> +
>>  &cps_eth1 {
>>  	/* CPS Lane 0 - J5 (Gigabit RJ45) */
>>  	status = "okay";
>> -- 
>> 2.13.5
>> 
>
> -- 
> Antoine T?nart, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
