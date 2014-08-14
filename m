From: dgreid@chromium.org (Dylan Reid)
Date: Thu, 14 Aug 2014 01:40:43 -0700
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53EBC2EC.1010300@wwwdotorg.org>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <53EB9BF0.9010002@wwwdotorg.org>
 <CAEUnVG6ki9O5hzw9OvJ1+8Www_G1+rqXujmNyJy+qOP-z_JR=A@mail.gmail.com>
 <53EBC2EC.1010300@wwwdotorg.org>
Message-ID: <CAEUnVG4=Jr=L=0x1_MrYqNYvpL_2s3Fnicg0vME_k6NjAxREYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 12:56 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/13/2014 01:07 PM, Dylan Reid wrote:
>>
>> On Wed, Aug 13, 2014 at 10:10 AM, Stephen Warren <swarren@wwwdotorg.org>
>> wrote:
>>>
>>> On 08/12/2014 07:56 PM, Dylan Reid wrote:
>>>>
>>>>
>>>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>>>> processor and is similar to the Venice2 reference platform.
>>>>
>>>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>>>> and work on the 1366x768 models.  I haven't tried on the HD systems
>>>> yet.
>>>>
>>>> WiFi does not yet work, it needs at least some PMIC changes to enable
>>>> the 32k clock.
>>>>
>>>> The elan trackpad is not yet functional but hopefully will be soon as
>>>> there are patches under review.
>>>>
>>>> There is also an issue on reboot because the TPM isn't reset.  It will
>>>> cause the stock firmware to enter recovery mode.  This can be worked
>>>> around by an EC-reset, press refresh and power at the same time.
>>>
>>>
>>>
>>>> diff --git a/arch/arm/boot/dts/tegra124-big.dts
>>>> b/arch/arm/boot/dts/tegra124-big.dts
>>>
>>>
>>>
>>> I think we need to include the SKU name in the filename and compatible
>>> value
>>> below, or at least plan out that for other SKUs, we'll add the SKU name
>>> on.
>>>
>>>
>>>> +/ {
>>>> +       model = "Google Big";
>>>> +       compatible = "google,nyan-big", "nvidia,tegra124";
>>>
>>>
>>>
>>> I think it'd be more user-friendly if the filename and compatible value
>>> more
>>> obviously tied to the end-user-visible product name.
>>
>>
>> I'll change the model to "Acer Chromebook 13"
>
>
> Would mentioning "CB5" in the model be a good idea; that's what it's sold
> as.

I am OK with either,  most of the press has referred to "Acer
Chromebook 13" although the CB5-311 model number has showed up a few
times too.

>
>
>> If we need a separate DT for the FullHD skew, then can we add a file
>> 'tegra124-nyan-big-full-hd.dtsi'?  We may also add
>> 'tegra124-nyan-big-full-hd-touch.dtsi' as well.  They would just
>> override the necessary things from this file.
>
>
> *.dts rather than *.dtsi I suspect? Yes, having a common include file and
> separate top-level files sounds like a good idea.
>
>
>>>> +       gpio-keys {
>>>> +               compatible = "gpio-keys";
>>>> +
>>>> +               lid {
>>>> +                       label = "Lid";
>>>> +                       gpios = <&gpio TEGRA_GPIO(R, 4)
>>>> GPIO_ACTIVE_LOW>;
>>>> +                       linux,input-type = <5>;
>>>> +                       linux,code = <0>;
>>>
>>>
>>>
>>> Aren't there #defines for the 5 and 0 there?
>>
>>
>> yes for code, apparently not for input-type.  I think 5 means EV_SW,
>> maybe that should get added to include/dt-bindings/input somewhere?
>
>
> Yes, that sounds like a good idea.
>
