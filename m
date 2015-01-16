From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 16 Jan 2015 09:50:47 +0100
Subject: [PATCH v2 03/11] ARM: tegra: Set the sound card model that
 alsaucm expects
In-Reply-To: <54B7F757.5060002@wwwdotorg.org>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-4-git-send-email-tomeu.vizoso@collabora.com>
 <54B7F757.5060002@wwwdotorg.org>
Message-ID: <CAAObsKCad9O_=TUQrF7fVbBvjDTmfJsLPgr+EasCyhvY+xhdHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 18:22, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>
>> Patches are on its way to add a config file to alsaucm for the Nyan
>> boards. Use the same card ID that alsaucm will expect.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>   arch/arm/boot/dts/tegra124-nyan-big.dts | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
>> b/arch/arm/boot/dts/tegra124-nyan-big.dts
>> index 43e58a4..9a9cffe 100644
>> --- a/arch/arm/boot/dts/tegra124-nyan-big.dts
>> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
>> @@ -1976,9 +1976,9 @@
>>         };
>>
>>         sound {
>> -               compatible = "nvidia,tegra-audio-max98090-nyan-big",
>> +               compatible = "nvidia,tegra-audio-max98090-nyan",
>>                              "nvidia,tegra-audio-max98090";
>
>
> If all the boards that are derived from Nyan truly have identical audio HW
> (or at least any differences can be described by this binding), then it
> seems fine to add "nvidia,tegra-audio-max98090-nyan" to the compatible
> value.



> However, I don't see a reason to remove the board-specific compatible value
> "nvidia,tegra-audio-max98090-nyan-big"; we should always include all the
> values that are relevant.

Ok.

>> -               nvidia,model = "Acer Chromebook 13";
>> +               nvidia,model = "GoogleNyan";
>
>
> Why not just name the UCM config file after the ASoC card name that's
> already in use? Perhaps it's not likely to be unique enough though:-(

Yeah, that would be A13, which isn't terribly useful.

Regards,

Tomeu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
