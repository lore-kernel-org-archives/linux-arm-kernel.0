From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 16 Dec 2015 20:09:39 +0100
Subject: [PATCH v3] net/macb: add support for resetting PHY using GPIO
In-Reply-To: <20151216190431.GB28759@localhost.localdomain> (Richard Cochran's
 message of "Wed, 16 Dec 2015 20:04:31 +0100")
References: <1450290690-32369-1-git-send-email-gregory.clement@free-electrons.com>
 <20151216190431.GB28759@localhost.localdomain>
Message-ID: <878u4utdl8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,
 
 On mer., d?c. 16 2015, Richard Cochran <richardcochran@gmail.com> wrote:

> On Wed, Dec 16, 2015 at 07:31:30PM +0100, Gregory CLEMENT wrote:
>> +Optional properties for PHY child node:
>> +- reset-gpios : Should specify the gpio for phy reset
>
> reset-gpios plural or reset-gpio singular?

The bindings name is plural but it handle only one gpio.

See:
https://lkml.org/lkml/2015/12/9/623

>
>> +
>>  Examples:
>>  
>>  	macb0: ethernet at fffc4000 {
>> @@ -29,4 +32,8 @@ Examples:
>>  		local-mac-address = [3a 0e 03 04 05 06];
>>  		clock-names = "pclk", "hclk", "tx_clk";
>>  		clocks = <&clkc 30>, <&clkc 30>, <&clkc 13>;
>> +		ethernet-phy at 1 {
>> +			reg = <0x1>;
>> +			reset-gpios = <&pioE 6 1>;
>
> Did you mean "gpioE" ?

No, I really mean pioE: it is the name used for the at91 SoCs.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
