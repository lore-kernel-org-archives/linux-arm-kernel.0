From: zhengxing@rock-chips.com (Xing Zheng)
Date: Sat, 2 Jan 2016 10:38:28 +0800
Subject: [RESEND PATCH v1 3/4] net: ethernet: arc: Add support emac for
 RK3036
In-Reply-To: <3169681.aSJgN2TRic@wuerfel>
References: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
 <1451287341-16453-4-git-send-email-zhengxing@rock-chips.com>
 <FFCE9129-357E-4643-A350-9927A5AD5720@gmail.com> <3169681.aSJgN2TRic@wuerfel>
Message-ID: <6ADB598D-07E0-4E51-A9FE-25B47FD87F7E@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



OK, I think I will use named structures.

Thanks.

> ? 2016?1?1??20:55?Arnd Bergmann <arnd@arndb.de> ???
> 
>> On Tuesday 29 December 2015 14:59:59 Florian Fainelli wrote:
>>> On December 27, 2015 11:22:20 PM PST, Xing Zheng <zhengxing@rock-chips.com> wrote:
>>> The RK3036's GRFs offset are different with RK3066/RK3188, and need to
>>> set
>>> mac TX/RX clock before probe emac.
>>> 
>>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>>> ---
>> <snip>
>>> };
>>> 
>>> static const struct of_device_id emac_rockchip_dt_ids[] = {
>>> -      { .compatible = "rockchip,rk3066-emac", .data =
>>> &emac_rockchip_dt_data[0] },
>>> -      { .compatible = "rockchip,rk3188-emac", .data =
>>> &emac_rockchip_dt_data[1] },
>>> +      { .compatible = "rockchip,rk3036-emac", .data =
>>> &emac_rockchip_dt_data[0] },
>>> +      { .compatible = "rockchip,rk3066-emac", .data =
>>> &emac_rockchip_dt_data[1] },
>>> +      { .compatible = "rockchip,rk3188-emac", .data =
>>> &emac_rockchip_dt_data[2] },
>>>      { /* Sentinel */ }
>> 
>> Food for thought, you might want to use an enum here to index emac_rockchip_dt_data which would be less error prone if you add/remove entries in this structure.
> 
> I would use named structures instead:
> 
> static const struct emac_rockchip_soc_data emac_rk3066_emac_data = {
>    .grf_offset = 0x154,
> };
> 
> static const struct of_device_id emac_rockchip_dt_ids[] = {
>    { .compatible = "rockchip,rk3066-emac", .data = &emac_rk3066_emac_data,
>    ...
> };
> 
>    Armd
> 
> 
