From: rogerq@ti.com (Roger Quadros)
Date: Tue, 4 Mar 2014 11:33:55 +0200
Subject: [PATCH 03/12] phy: ti-pipe3: cleanup clock handling
In-Reply-To: <53159D0D.2040009@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
 <1393859254-10937-4-git-send-email-rogerq@ti.com> <53159D0D.2040009@ti.com>
Message-ID: <53159E03.6010203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 11:29 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 03 March 2014 08:37 PM, Roger Quadros wrote:
>> As this driver is no longer USB specific, use generic clock names.
>> - Fix PLL_SD_SHIFT from 9 to 10
>> - As optclk and wkupclk may not be always required, don't bail out
>> if they aren't available.
> 
> I think here too we face the same problem as for PHY. What if a particular platform needs a clock but is not available. I don't want this to be blocking though.

Since we know for sure what clocks the different TI PHYs need, we could do the checks based on compatible id and always fail on clock error.

cheers,
-roger
