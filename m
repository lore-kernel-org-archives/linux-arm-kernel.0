From: s.peter@mpl.ch (Stefan Peter)
Date: Fri, 16 Nov 2012 20:44:01 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Add support for the MPL CEC4
In-Reply-To: <20121116163645.GC24569@lunn.ch>
References: <cover.1353055273.git.s.peter@mpl.ch>
 <7f8832a749a9ebc378460f26d13ed524b7da18a8.1353055273.git.s.peter@mpl.ch>
 <20121116151128.GO22106@titan.lakedaemon.net>
 <20121116163645.GC24569@lunn.ch>
Message-ID: <50A69781.8090702@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> +                        partition at 600000 {
>>> +                                label = "rootfs";
>>> +                                reg = <0x600000 0x1fa00000>;
>>> +                        };
>>> +                };
>>> +
>>> +		rtc at 10300 {
>>> +			status = "disabled";
>>> +		};
>>
>> really?
> 
> Hi Jason
> 
> The pcf8563 on the i2c bus is an RTC.
> 
> I don't know why, but my QNAP also has an I2C RTC and the Armada XP
> based OpenBlocks AX3 has one as well.

I don't know why other manufacturers have done so, but we decided to not
use the kirkwood rtc because the only battery holders you can get for
the battery required by the kirkwood rtc are to flimsy for an industrial
environment.

Regards

Stefan Peter


-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
