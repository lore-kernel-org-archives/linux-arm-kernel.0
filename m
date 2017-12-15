From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 15 Dec 2017 08:34:55 +0100
Subject: DT dtc warnings
In-Reply-To: <20171215072921.GJ2559@piout.net>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
 <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
 <CAJKOXPfCDT+7wPkz3g6AiKgLvFp4rnicYQgYn8A_yaPe4YhD5A@mail.gmail.com>
 <CAOMZO5BGX1U90bGrff42rZKKOSQK3NB=-k_4BX04Tsi=yX0Odg@mail.gmail.com>
 <CAJKOXPea5nx+i+vWJcMGqct1=gP5OHbDSAzqTCBYr1RvFW-1gw@mail.gmail.com>
 <CAOMZO5CKPhQwdkYBeu74k=RYBxGhVf13nnrzHXUhq8LWk8yBSg@mail.gmail.com>
 <CAJKOXPeqm-KRnuc7uUena=iH+rYLzSVSCb-uSbLB4SdRGqLRtw@mail.gmail.com>
 <20171215072921.GJ2559@piout.net>
Message-ID: <CAJKOXPcf_zf3X8i9xVpK_BSvnR-78otwmaiOERDYTT2tC3VC2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 8:29 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 15/12/2017 at 08:23:39 +0100, Krzysztof Kozlowski wrote:
>> On Fri, Dec 15, 2017 at 12:02 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> > On Thu, Dec 14, 2017 at 7:19 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> >
>> >> Thanks for reply!
>> >>
>> >> Isn't this property of a SoC? The registers used by
>> >> syscon-poweroff/reboot are part of SoC power management unit. It does
>> >> not refer to any externals. Why then it should be put outside of soc?
>> >
>> > If these nodes have registers, then they should have a unit address
>> > and reg property.
>>
>> That's the point - they do not have unit address.
>>
>
> Should they be put under the syscon they are using?

They are not using syscon but regmap provided by such external IP
block (for example this:
http://elixir.free-electrons.com/linux/v4.15-rc3/source/arch/arm/boot/dts/exynos3250.dtsi#L153).
I guess you are proposing something like on imx7s:
http://elixir.free-electrons.com/linux/v4.15-rc3/source/arch/arm/boot/dts/imx7s.dtsi#L539

That makes sense... I am not sure how this would be related to the
warning itself but anyway it looks logically.

Best regards,
Krzysztof
