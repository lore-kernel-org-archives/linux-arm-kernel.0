From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 5 Mar 2018 22:55:14 +0800
Subject: [PATCH] soc: rockchip: disable jtag switching for RK3128 SoCs
In-Reply-To: <1633972.b4bkohDpDd@phil>
References: <20180302122031.17426-1-heiko@sntech.de>
 <7020f92d-cc0e-745e-713b-3aa847b7e939@rock-chips.com>
 <1633972.b4bkohDpDd@phil>
Message-ID: <b364b257-3ead-cbfe-2ba0-ad49c2c92d04@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/3/5 22:42, Heiko Stuebner wrote:
> Hi Shawn,
> 
> Am Montag, 5. M?rz 2018, 15:39:04 CET schrieb Shawn Lin:
>> On 2018/3/2 20:20, Heiko Stuebner wrote:
>>> From: Xiao Yao <xiaoyao@rock-chips.com>
>>>
>>> Disable IO function switching between sdmmc and jtag
>>> for RK3128 SoCs.
>>>
>>
>> I acked this on the vendor kernel tree, so FWIW:
>>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Hope this is one of the final patches for that, as I would
>> revive IO function switching between sdmmc and jtag for newer
>> SoCs after addressing the problem from HW level.
> 
> the main problem we had with that was that the  mmc-subsystem
> somehow definitly didn't like it when the controller pins where pulled
> out from under it on card eject.

Right, we had sort out it's timing revelant between mmc controller and
the switching hw block.

> 
> But of course, if you can get this solved by hw somehow, that
> would be pretty cool :-)

It is under extensively tested now, and seems quite positive. :)

> 
> 
> Heiko
> 
> 
> 


-- 
Best Regards
Shawn Lin
