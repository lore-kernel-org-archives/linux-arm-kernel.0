From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Feb 2018 19:29:15 +0530
Subject: [PATCH 0/4] Move DP phy switch to PHY driver
In-Reply-To: <1752563.I66u68YxnT@diego>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
 <a9eac594-33d5-6171-51ca-66204008fc1f@ti.com> <1752563.I66u68YxnT@diego>
Message-ID: <5d20a7bf-f96a-f030-1350-aea2c5cd8153@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 16 February 2018 06:35 PM, Heiko St?bner wrote:
> Hi Kishon,
> 
> Am Freitag, 16. Februar 2018, 12:04:42 CET schrieb Kishon Vijay Abraham I:
>> On Friday 10 February 2017 01:14 PM, Chris Zhong wrote:
>>> There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
>>> only one PHY can connect to DP controller at one time, the other should
>>> be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
>>> set this bit means enable PHY 1, clear this bit means enable PHY 0.
>>>
>>> If the board has 2 Type-C ports, the DP driver get the phy id from
>>> devm_of_phy_get_by_index, and then control this switch according to
>>> this id. But some others board only has one Type-C port, it may be PHY 0
>>> or PHY 1. The dts node id can not tell us the correct PHY id. Hence move
>>> this switch to PHY driver, the PHY driver can distinguish between PHY 0
>>> and PHY 1, and then write the correct register bit.
>>
>> Changed subject of "Documentation: bindings: add uphy-dp-sel for Rockchip
>> USB Type-C PHY" as suggested by Rob, rebased "phy: rockchip-typec: support
>> DP phy switch" to the latest kernel and merged.
> 
> I'm not sure how far along you are with your merging, but you might want to 
> revert this one.
> 
> In your inbox you should find more recent threads about the type-c phy
> where Rob strongly suggested moving the whole grf registers out of the
> dt and into the driver.
> 
> Enric Balletbo did just that and posted a series (including the dp-move)
> yesterday (refined in a v2 from today).
> 
> Alternatively Enric could rebase his series on top of that recent change.

I can drop this series and take Enric's series. All of them are still in my
local system.

Thanks
Kishon
