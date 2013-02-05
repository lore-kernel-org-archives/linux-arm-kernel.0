From: rogerq@ti.com (Roger Quadros)
Date: Tue, 5 Feb 2013 13:32:19 +0200
Subject: [PATCH 00/13] Device tree support for OMAP HS USB Host
In-Reply-To: <5110EC0D.40609@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <5110EC0D.40609@ti.com>
Message-ID: <5110EDC3.8040200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 01:25 PM, Rajendra Nayak wrote:
> On Monday 04 February 2013 09:28 PM, Roger Quadros wrote:
>> This patchset adds device tree support for OMAP's High Speed USB Host
>> subsystem. Board adaptation for Panda and Beagleboard is also provided.
>>
>> Tested on Beagleboard.
>>
>> Will only work with Panda if we provide a reference to the PHY clock
> 
> But there is no reference provided even for Beagle. Does it work because
> the default clk speed is 192Mhz?

On beagle board the PHY is connected differently, i.e. as the clock receptor.
The PHY clock comes directly from the USB_CLK pin.

On Panda the PHY is the clock provider to the USB_CLK pin. For that it needs
a reference clock at the REFCLK pin which comes from FREF_CLK3.

> 
>> generator in the device tree in PATCH 11. I do not know how to do that
>> as there is no way to provide a phandle to any of the OMAP generated clocks
>> in the device tree. Suggestions welcome:).
> 

cheers,
-roger
