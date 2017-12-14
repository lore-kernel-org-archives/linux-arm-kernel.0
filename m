From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 14 Dec 2017 22:19:35 +0100
Subject: DT dtc warnings
In-Reply-To: <CAOMZO5BGX1U90bGrff42rZKKOSQK3NB=-k_4BX04Tsi=yX0Odg@mail.gmail.com>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
 <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
 <CAJKOXPfCDT+7wPkz3g6AiKgLvFp4rnicYQgYn8A_yaPe4YhD5A@mail.gmail.com>
 <CAOMZO5BGX1U90bGrff42rZKKOSQK3NB=-k_4BX04Tsi=yX0Odg@mail.gmail.com>
Message-ID: <CAJKOXPea5nx+i+vWJcMGqct1=gP5OHbDSAzqTCBYr1RvFW-1gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 10:13 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Dec 14, 2017 at 7:01 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>> Can anyone help why this W=1 triggers warning like these:
>> arch/arm/boot/dts/exynos3250-artik5-eval.dtb: Warning
>> (simple_bus_reg): Node /soc/syscon-poweroff missing or empty
>> reg/ranges property
>> arch/arm/boot/dts/exynos3250-artik5-eval.dtb: Warning
>> (simple_bus_reg): Node /soc/syscon-reboot missing or empty reg/ranges
>> property
>>
>> For a node without unit address?
>> http://elixir.free-electrons.com/linux/v4.15-rc3/source/arch/arm/boot/dts/exynos-syscon-restart.dtsi
>>
>> AFAIR, if node does not have unit-address then it should not have
>> reg/ranges property. Or maybe it is coming from parent's simple-bus?
>
> syscon-poweroff and syscon-reboot should be outside the soc bus.

Thanks for reply!

Isn't this property of a SoC? The registers used by
syscon-poweroff/reboot are part of SoC power management unit. It does
not refer to any externals. Why then it should be put outside of soc?

Best regards,
Krzysztof
