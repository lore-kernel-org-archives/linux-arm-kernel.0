From: seanpaul@chromium.org (Sean Paul)
Date: Thu, 3 Oct 2013 12:06:59 -0400
Subject: [PATCH 2/5] ARM: dts: Add dp-controller node to exynos5250-snow
In-Reply-To: <CAOesGMj3142o1B_33BqtLZMbObn2tjfBaBHvAB-2+O+XOuCjSw@mail.gmail.com>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380670860-17621-3-git-send-email-seanpaul@chromium.org>
 <CAOesGMj3142o1B_33BqtLZMbObn2tjfBaBHvAB-2+O+XOuCjSw@mail.gmail.com>
Message-ID: <CAOw6vbJeD396f1LEN8SE5j+Rcc=962EcuUuJpxU87Daxfag=Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 2, 2013 at 5:10 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Oct 1, 2013 at 4:40 PM, Sean Paul <seanpaul@chromium.org> wrote:
>> This patch adds the dp-controller node to the exynos5250-snow board dts
>> file.
>>
>> Signed-off-by: Sean Paul <seanpaul@chromium.org>
>> ---
>>  arch/arm/boot/dts/exynos5250-snow.dts | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>> index e5af3f2..780511a 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -190,6 +190,18 @@
>>                 samsung,vbus-gpio = <&gpx1 1 0>;
>>         };
>>
>> +       dp-controller {
>> +               samsung,color-space = <0>;
>> +               samsung,dynamic-range = <0>;
>> +               samsung,ycbcr-coeff = <0>;
>> +               samsung,color-depth = <1>;
>> +               samsung,link-rate = <0x0a>;
>> +               samsung,lane-count = <2>;
>> +
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&dp_hpd>;
>> +       };
>
> This won't actually do what I think you want. Since the dtsi has the
> node name "dp-controller at 145B0000", you will end up duplicating a new
> node and not build on top of that one.
>

Thanks, Olof. I based this off Inki's exynos-drm-next tree which does
not have the latest from arm-soc, I'll re-upload.

Sean


> There's two ways to do it: Always include the unit address, or create
> a label in the dtsi such that:
>
> dp_controller: dp-controller@ {....
> }
>
> Then in your dts you can, at the root level:
>
> &dp_controller {
>   ... new stuff and overrides ...
> };
>
>
>
> -Olof
