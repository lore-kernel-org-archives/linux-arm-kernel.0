From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 28 Jul 2015 12:32:14 +0200
Subject: [PATCH v2 2/4] ARM: Kirkwood: add modes-map property to ns2-leds
 nodes
In-Reply-To: <55B3A047.70905@free-electrons.com>
References: <1435859803-19583-1-git-send-email-simon.guinot@sequanux.org>
 <1435859803-19583-3-git-send-email-simon.guinot@sequanux.org>
 <55B3A047.70905@free-electrons.com>
Message-ID: <55B75A2E.4080803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Jacek,

On 25/07/2015 16:42, Gregory CLEMENT wrote:
> Hi Simon, Jacek, Bryan, Richard,
> 
> On 02/07/2015 19:56, Simon Guinot wrote:
>> From: Vincent Donnefort <vdonnefort@gmail.com>
>>
>> Since the LED modes mapping is no longer hardcoded inside the leds-ns2
>> driver, then it must be provided through the modes-map property in the
>> ns2-leds nodes.
>>
>> Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
> 
> As the other patch of the series seem to be merged in the led branch,
> then I can apply this patch on mvebu/dt.
> 
> It is OK for being in linux-next, however this patch depend on "leds:
> leds-ns2: move LED modes mapping outside of the driver", so I will need
> to find a way to express this dependency when I will do the pull request
> to arm-soc.
> 

Eventually I removed this patch from my branch.
Jacek, you can take it with my

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


> 
> Thanks,
> 
> Gregory
> 
> 
>> ---
>>  arch/arm/boot/dts/kirkwood-d2net.dts   | 5 +++++
>>  arch/arm/boot/dts/kirkwood-is2.dts     | 5 +++++
>>  arch/arm/boot/dts/kirkwood-ns2.dts     | 5 +++++
>>  arch/arm/boot/dts/kirkwood-ns2max.dts  | 5 +++++
>>  arch/arm/boot/dts/kirkwood-ns2mini.dts | 5 +++++
>>  5 files changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/kirkwood-d2net.dts b/arch/arm/boot/dts/kirkwood-d2net.dts
>> index 6b7856025001..e1c25c35e9ce 100644
>> --- a/arch/arm/boot/dts/kirkwood-d2net.dts
>> +++ b/arch/arm/boot/dts/kirkwood-d2net.dts
>> @@ -10,6 +10,7 @@
>>  
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/leds-ns2.h>
>>  #include "kirkwood-netxbig.dtsi"
>>  
>>  / {
>> @@ -28,6 +29,10 @@
>>  			label = "d2net_v2:blue:sata";
>>  			slow-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
>>  			cmd-gpio = <&gpio0 30 GPIO_ACTIVE_HIGH>;
>> +			modes-map = <NS_V2_LED_OFF  1 0
>> +				     NS_V2_LED_ON   0 1
>> +				     NS_V2_LED_ON   1 1
>> +				     NS_V2_LED_SATA 0 0>;
>>  		};
>>  	};
>>  
>> diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
>> index da674bbd49a8..4121674abd1c 100644
>> --- a/arch/arm/boot/dts/kirkwood-is2.dts
>> +++ b/arch/arm/boot/dts/kirkwood-is2.dts
>> @@ -1,5 +1,6 @@
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/leds-ns2.h>
>>  #include "kirkwood-ns2-common.dtsi"
>>  
>>  / {
>> @@ -27,6 +28,10 @@
>>  			label = "ns2:blue:sata";
>>  			slow-gpio = <&gpio0 29 0>;
>>  			cmd-gpio = <&gpio0 30 0>;
>> +			modes-map = <NS_V2_LED_OFF  1 0
>> +				     NS_V2_LED_ON   0 1
>> +				     NS_V2_LED_ON   1 1
>> +				     NS_V2_LED_SATA 0 0>;
>>  		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/kirkwood-ns2.dts
>> index 53368d1022cc..190189d235e6 100644
>> --- a/arch/arm/boot/dts/kirkwood-ns2.dts
>> +++ b/arch/arm/boot/dts/kirkwood-ns2.dts
>> @@ -1,5 +1,6 @@
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/leds-ns2.h>
>>  #include "kirkwood-ns2-common.dtsi"
>>  
>>  / {
>> @@ -27,6 +28,10 @@
>>  			label = "ns2:blue:sata";
>>  			slow-gpio = <&gpio0 29 0>;
>>  			cmd-gpio = <&gpio0 30 0>;
>> +			modes-map = <NS_V2_LED_OFF  1 0
>> +				     NS_V2_LED_ON   0 1
>> +				     NS_V2_LED_ON   1 1
>> +				     NS_V2_LED_SATA 0 0>;
>>  		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
>> index 72c78d0b1116..55cc41d9c80c 100644
>> --- a/arch/arm/boot/dts/kirkwood-ns2max.dts
>> +++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
>> @@ -1,5 +1,6 @@
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/leds-ns2.h>
>>  #include "kirkwood-ns2-common.dtsi"
>>  
>>  / {
>> @@ -46,6 +47,10 @@
>>  			label = "ns2:blue:sata";
>>  			slow-gpio = <&gpio0 29 0>;
>>  			cmd-gpio = <&gpio0 30 0>;
>> +			modes-map = <NS_V2_LED_OFF  1 0
>> +				     NS_V2_LED_ON   0 1
>> +				     NS_V2_LED_ON   1 1
>> +				     NS_V2_LED_SATA 0 0>;
>>  		};
>>  	};
>>  };
>> diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
>> index c441bf62c09f..9935f3ec29b4 100644
>> --- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
>> +++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
>> @@ -1,5 +1,6 @@
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/leds-ns2.h>
>>  #include "kirkwood-ns2-common.dtsi"
>>  
>>  / {
>> @@ -47,6 +48,10 @@
>>  			label = "ns2:blue:sata";
>>  			slow-gpio = <&gpio0 29 0>;
>>  			cmd-gpio = <&gpio0 30 0>;
>> +			modes-map = <NS_V2_LED_OFF  1 0
>> +				     NS_V2_LED_ON   0 1
>> +				     NS_V2_LED_ON   1 1
>> +				     NS_V2_LED_SATA 0 0>;
>>  		};
>>  	};
>>  };
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
