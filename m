From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Jan 2015 10:10:13 -0700
Subject: [PATCH v2 03/11] ARM: tegra: Set the sound card model that alsaucm
 expects
In-Reply-To: <CAAObsKBKnU_wBaxNFN-buz71qL-te4s6bqrrnxao_N-TwBVkAQ@mail.gmail.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-4-git-send-email-tomeu.vizoso@collabora.com>
 <54B7F757.5060002@wwwdotorg.org>
 <CAAObsKCad9O_=TUQrF7fVbBvjDTmfJsLPgr+EasCyhvY+xhdHg@mail.gmail.com>
 <CAAObsKBKnU_wBaxNFN-buz71qL-te4s6bqrrnxao_N-TwBVkAQ@mail.gmail.com>
Message-ID: <54BD3A75.80009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2015 02:01 AM, Tomeu Vizoso wrote:
> On 16 January 2015 at 09:50, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> On 15 January 2015 at 18:22, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>>>
>>>> Patches are on its way to add a config file to alsaucm for the Nyan
>>>> boards. Use the same card ID that alsaucm will expect.
>>>>
>>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>> ---
>>>>    arch/arm/boot/dts/tegra124-nyan-big.dts | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
>>>> b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>>> index 43e58a4..9a9cffe 100644
>>>> --- a/arch/arm/boot/dts/tegra124-nyan-big.dts
>>>> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
>>>> @@ -1976,9 +1976,9 @@
>>>>          };
>>>>
>>>>          sound {
>>>> -               compatible = "nvidia,tegra-audio-max98090-nyan-big",
>>>> +               compatible = "nvidia,tegra-audio-max98090-nyan",
>>>>                               "nvidia,tegra-audio-max98090";
>>>
>>>
>>> If all the boards that are derived from Nyan truly have identical audio HW
>>> (or at least any differences can be described by this binding), then it
>>> seems fine to add "nvidia,tegra-audio-max98090-nyan" to the compatible
>>> value.
>>
>>
>>
>>> However, I don't see a reason to remove the board-specific compatible value
>>> "nvidia,tegra-audio-max98090-nyan-big"; we should always include all the
>>> values that are relevant.
>>
>> Ok.
>
> Oh, actually, my intention was to move the whole sound node to the
> nyan dtsi, as there isn't anything specific to the blaze regarding
> sound.

There are zero differences between the sound circuits of the boards? If 
so, that sounds fine. I suppose if we do need to apply a quirk to one 
board but not the other, we can always fall back on the top-level 
compatible value if we absolutely have to.
