From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Mar 2016 11:24:47 +0800
Subject: [PATCH v5 2/4] dt-bindings: add bindings for rk3399 clock
 controller
In-Reply-To: <3689505.b0IKY6iWOt@phil>
References: <1458974276-10325-1-git-send-email-zhengxing@rock-chips.com>
 <1458974276-10325-3-git-send-email-zhengxing@rock-chips.com>
 <1507551.YPleCY5ZQt@phil> <3689505.b0IKY6iWOt@phil>
Message-ID: <56F8A3FF.6090800@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016?03?28? 08:07, Heiko Stuebner wrote:
> Hi Xing,
>
> Am Montag, 28. M?rz 2016, 01:52:12 schrieb Heiko St?bner:
>> Am Samstag, 26. M?rz 2016, 14:37:54 schrieb Xing Zheng:
>>> Add devicetree bindings for Rockchip cru which found on
>>> Rockchip SoCs.
>>>
>>> Signed-off-by: Xing Zheng<zhengxing@rock-chips.com>
>>> Signed-off-by: Jianqun Xu<jay.xu@rock-chips.com>
>>> Acked-by: Rob Herring<robh@kernel.org>
>>> ---
>>>
>>> Changes in v5: None
>>> Changes in v3: None
>>> Changes in v2: None
>>>
>>>   .../bindings/clock/rockchip,rk3399-cru.txt         |   83
>>>
>>> ++++++++++++++++++++ 1 file changed, 83 insertions(+)
>>>
>>>   create mode 100644
>>>
>>> Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-
>> cru.txt
>>
>>> b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt new
>>> file mode 100644
>>> index 0000000..9427caa
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
>>> @@ -0,0 +1,83 @@
>>> +* Rockchip RK3399 Clock and Reset Unit
>>> +
>>> +The RK3399 clock controller generates and supplies clock to various
>>> +controllers within the SoC and also implements a reset controller for
>>> SoC +peripherals.
>>> +
>>> +Required Properties:
>>> +
>>> +- compatible: PMU for CRU should be "rockchip,rk3399-pmucru"
>>> +- compatible: CRU should be "rockchip,rk3399-cru"
>>> +- reg: physical base address of the controller and length of memory
>> mapped
>>
>>> +  region.
>>> +- #clock-cells: should be 1.
>>> +- #reset-cells: should be 1.
>>> +
>>> +Optional Properties:
>>> +
>>> +- rockchip,grf: phandle to the syscon managing the "general register
>> files"
>>
>>> +  If missing, pll rates are not changeable, due to the missing pll lock
>>> status. +
>> the rk3399 doesn't need the GRF, so we should drop this block for now
> actually, I just saw that the GRF is needed for the static settings during
> init. So the rockchip,grf should stay but also move up to required
> properties?
>
> Same for the grf-comment in the examples-section.
>
>
I check the setting of the pclk_alive and pclk_pmu_src are not gating 
default on the PMUGRF_SOC_CON0,
so I think that we don't need to do the static settings to re-enable 
them in the clock driver any more.

Thanks.

-- 
- Xing Zheng
