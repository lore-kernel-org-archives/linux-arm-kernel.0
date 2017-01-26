From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2017 09:44:03 +0100
Subject: [PATCH 4/7] arm64: dts: exynos: Add clocks to Exynos5433 LPASS
 module
In-Reply-To: <CAJKOXPdb4vBP_kZDgy1CJ-6WHdpU5+NKygoCNZuiCyh3MvpR9Q@mail.gmail.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115103eucas1p1d0e446fa6e998da257e3c17922a00d7f@eucas1p1.samsung.com>
 <1485345031-2948-5-git-send-email-m.szyprowski@samsung.com>
 <20170125195022.yiqxnfted2vw4owh@kozik-lap>
 <2eabe488-1e58-4320-6d6f-f7844ee06998@samsung.com>
 <CAJKOXPdb4vBP_kZDgy1CJ-6WHdpU5+NKygoCNZuiCyh3MvpR9Q@mail.gmail.com>
Message-ID: <627ea264-535d-2c89-3987-02b8620d9328@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2017-01-26 09:40, Krzysztof Kozlowski wrote:
> On Thu, Jan 26, 2017 at 9:18 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 2017-01-25 20:50, Krzysztof Kozlowski wrote:
>>> On Wed, Jan 25, 2017 at 12:50:28PM +0100, Marek Szyprowski wrote:
>>>> Exynos5433 LPASS module requires some clocks for proper operation with
>>>> power domain.
>>>>
>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> ---
>>>>    arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> index 57c7bbeb65a7..16072c1c3ed3 100644
>>>> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>>>> @@ -1494,6 +1494,8 @@
>>>>                  audio-subsystem at 11400000 {
>>>>                          compatible = "samsung,exynos5433-lpass";
>>>>                          reg = <0x11400000 0x100>, <0x11500000 0x08>;
>>>> +                       clocks = <&cmu_aud CLK_PCLK_SFR0_CTRL>;
>>>> +                       clock-names = "sfr0_ctrl";
>>> You wrote that 6/7 depends on this. I prefer not to take DTS changes if
>>> the corresponding user (driver) is still under discussion because the
>>> bindings might change. I'll take it when bindings got acked or accepted.
>>
>> Well, audio support in 4.9 is still not functional due to missing other
>> patches to ALSA SoC, so nothing will break as for now if we manage to get
>> this into v4.10.
> Get this into v4.10? So this needs some additional explanation in the
> commit message why this is a fix. Probably one more sentence would be
> enough. Or did you mean v4.11?

Yes, I meant v4.11.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
