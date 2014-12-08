From: lyz@rock-chips.com (Yunzhi Li)
Date: Mon, 08 Dec 2014 12:12:26 +0800
Subject: [PATCH v2 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY.
In-Reply-To: <CABgxDoLe2RxCjD53uvTgYZ=tNOKHLeGoZE5Aa5XvaUYvNX=HYw@mail.gmail.com>
References: <1417783941-2418-1-git-send-email-lyz@rock-chips.com>	<1417783941-2418-2-git-send-email-lyz@rock-chips.com>
 <CABgxDoLe2RxCjD53uvTgYZ=tNOKHLeGoZE5Aa5XvaUYvNX=HYw@mail.gmail.com>
Message-ID: <5485252A.90308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain :

On 2014/12/5 21:38, Romain Perier wrote:
> Hi,
>
> Some quick comments
>
> 2014-12-05 13:52 GMT+01:00 Yunzhi Li <lyz@rock-chips.com>:
>> [...]
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index ccad880..e3a5857 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -239,6 +239,13 @@ config PHY_QCOM_IPQ806X_SATA
>>          depends on OF
>>          select GENERIC_PHY
>>
>> +config PHY_ROCKCHIP_RK3288_USB2
>> +       tristate "Rockchip USB2 RK3288 PHY Driver"
>> +       depends on ARCH_ROCKCHIP && OF
>> +       select GENERIC_PHY
>> +       help
>> +         Enable this to support the Rockchip USB 2.0 PHY.
>> +
>
> The C module is named phy-rockchip-usb.c, why did you call the config
> entry PHY_ROCKCHIP_RK3288_USB2 ? why RK3288 ? this driver might be
> ported to old SoCs later.
> I think that PHY_ROCKCHIP_USB would be enough.
Right, this driver will be ported to old SoCs like RK3188 or RK3066, 
this will be renamed to PHY_ROCKCHIP_USB in the next version.
