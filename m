From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 11:32:31 +0200
Subject: [PATCH] ARM: mvebu: fix GPIO config on the Linksys boards
In-Reply-To: <op.ye4rq1ae2s3iss@ecaz> (Imre Kaloz's message of "Wed, 30 Mar
 2016 11:10:03 +0200")
References: <1438368120-23860-1-git-send-email-kaloz@openwrt.org>
 <op.ye4rq1ae2s3iss@ecaz>
Message-ID: <87vb44ux8w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Imre,
 
 On mer., mars 30 2016, "Imre Kaloz" <kaloz@openwrt.org> wrote:

> Hi guys,
>
> Just noticed this never got neither merged or declined ;)

Thanks for the reminder. The patch was sent the day I did the pull
request, maybe that's why I missed it. Except that, I see no reason to
not having appled it. Sorry for that.

>
> It should still apply, but if needed, I can refresh it and send a v2.

Now it is applied on mvebu/dt

Thanks,

Gregory


>
>
> Best,
>
> Imre
>
> On Fri, 31 Jul 2015 20:42:00 +0200, Imre Kaloz <kaloz@openwrt.org> wrote:
>
>> Some of the GPIO configs were wrong in the submitted DTS files,
>> this patch fixes all affected boards.
>>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>>
>> Cc: <stable@vger.kernel.org> # v4.1 +
>> ---
>>  arch/arm/boot/dts/armada-385-linksys.dtsi     | 6 +++---
>>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi
>> b/arch/arm/boot/dts/armada-385-linksys.dtsi
>> index 74a9c6b..1b0075f 100644
>> --- a/arch/arm/boot/dts/armada-385-linksys.dtsi
>> +++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
>> @@ -243,7 +243,7 @@
>>  		button at 2 {
>>  			label = "Factory Reset Button";
>>  			linux,code = <KEY_RESTART>;
>> -			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
>> +			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
>>  		};
>>  	};
>> @@ -258,7 +258,7 @@
>>  		};
>> 		sata {
>> -			gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
>> +			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
>>  			default-state = "off";
>>  		};
>>  	};
>> @@ -311,7 +311,7 @@
>> &pinctrl {
>>  	keys_pin: keys-pin {
>> -		marvell,pins = "mpp24", "mpp47";
>> +		marvell,pins = "mpp24", "mpp29";
>>  		marvell,function = "gpio";
>>  	};
>> diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
>> b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
>> index fdd187c..e767735 100644
>> --- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
>> +++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
>> @@ -302,13 +302,13 @@
>>  		button at 1 {
>>  			label = "WPS";
>>  			linux,code = <KEY_WPS_BUTTON>;
>> -			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
>> +			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>>  		};
>> 		button at 2 {
>>  			label = "Factory Reset Button";
>>  			linux,code = <KEY_RESTART>;
>> -			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
>> +			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
>>  		};
>>  	};

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
