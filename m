From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 12:52:37 -0600
Subject: DT dtc warnings
In-Reply-To: <CAJKOXPcf_zf3X8i9xVpK_BSvnR-78otwmaiOERDYTT2tC3VC2A@mail.gmail.com>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
 <CAJKOXPc7M3jeV_hNBBRJKGs3vtNzdrGbW_YETw2n0fXxhqjZ_g@mail.gmail.com>
 <CAJKOXPfCDT+7wPkz3g6AiKgLvFp4rnicYQgYn8A_yaPe4YhD5A@mail.gmail.com>
 <CAOMZO5BGX1U90bGrff42rZKKOSQK3NB=-k_4BX04Tsi=yX0Odg@mail.gmail.com>
 <CAJKOXPea5nx+i+vWJcMGqct1=gP5OHbDSAzqTCBYr1RvFW-1gw@mail.gmail.com>
 <CAOMZO5CKPhQwdkYBeu74k=RYBxGhVf13nnrzHXUhq8LWk8yBSg@mail.gmail.com>
 <CAJKOXPeqm-KRnuc7uUena=iH+rYLzSVSCb-uSbLB4SdRGqLRtw@mail.gmail.com>
 <20171215072921.GJ2559@piout.net>
 <CAJKOXPcf_zf3X8i9xVpK_BSvnR-78otwmaiOERDYTT2tC3VC2A@mail.gmail.com>
Message-ID: <CAL_Jsq+hOLV=92558k+M9UcBk-0bMXEgYQkAw7Pvk4KAys04Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 1:34 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Dec 15, 2017 at 8:29 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> On 15/12/2017 at 08:23:39 +0100, Krzysztof Kozlowski wrote:
>>> On Fri, Dec 15, 2017 at 12:02 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>> > On Thu, Dec 14, 2017 at 7:19 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> >
>>> >> Thanks for reply!
>>> >>
>>> >> Isn't this property of a SoC? The registers used by
>>> >> syscon-poweroff/reboot are part of SoC power management unit. It does
>>> >> not refer to any externals. Why then it should be put outside of soc?
>>> >
>>> > If these nodes have registers, then they should have a unit address
>>> > and reg property.
>>>
>>> That's the point - they do not have unit address.
>>>
>>
>> Should they be put under the syscon they are using?

+1

> They are not using syscon but regmap provided by such external IP
> block (for example this:
> http://elixir.free-electrons.com/linux/v4.15-rc3/source/arch/arm/boot/dts/exynos3250.dtsi#L153).
> I guess you are proposing something like on imx7s:
> http://elixir.free-electrons.com/linux/v4.15-rc3/source/arch/arm/boot/dts/imx7s.dtsi#L539

Yes, but the regmap property is pointless. It's the parent!

> That makes sense... I am not sure how this would be related to the
> warning itself but anyway it looks logically.

They just have to be under a node that is not a simple-bus.

"soc" nodes with a simple-bus compatible don't really mean everything
in the SoC, but just all (or some part of) the memory mapped space.
There's many board specific settings within those nodes. We don't
really split up top-level things into board and soc levels.

Rob
