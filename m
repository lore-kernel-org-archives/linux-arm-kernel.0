From: olof@lixom.net (Olof Johansson)
Date: Fri, 13 Apr 2012 13:59:29 -0700
Subject: [PATCH V2 4/5] ARM: dt: tegra30.dtsi: Add audio-related nodes
In-Reply-To: <4F851673.6030000@wwwdotorg.org>
References: <1334099980-19527-1-git-send-email-swarren@wwwdotorg.org>
 <1334099980-19527-4-git-send-email-swarren@wwwdotorg.org>
 <CAOesGMhDDenRK_GeR=jWJbcoacRMUPnjFu5w4DCyUWC=CadnbA@mail.gmail.com>
 <4F851673.6030000@wwwdotorg.org>
Message-ID: <CAOesGMiVPLRMo6OnLpr0wk4VPPVcgjqbsi3T=D5zHGb1EYrmYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 10:28 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2012 10:27 PM, Olof Johansson wrote:
> ...
>> On Tue, Apr 10, 2012 at 4:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> Add nodes for the Tegra30 AHUB and I2S controllers.
> ...
>>> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> ...
>>> + ? ? ? ahub at 70080000 {
>>
>> No need for unit address here since there's only one node with this
>> name -- "ahub {" ?is sufficient.
>
> Is there actually a benefit from leaving it out though?

Just like there's no benefit from including it. :)

So, either way is OK but I think we're a little too eager to always
include them on ARM compared to what powerpc does. No big deal though.
>
>>> + ? ? ? ? ? ? ? compatible = "nvidia,tegra30-ahub";
>>> + ? ? ? ? ? ? ? reg = <0x70080000 0x200 0x70080200 0x100>;
>>
>> Why not just use 0x70080000 0x300?
>
> The register space is logically divided into two chunks; the first for
> the DMA FIFOs and the second for the AHUB routing registers. Future
> chips may change the relative positions and sizes of these two chunks,
> hence I figured it was best to model them independently even though
> they're contiguous in Tegra30.

Makes perfect sense, thanks for the motivation.


-Olof
