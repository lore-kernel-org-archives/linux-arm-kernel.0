From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 19 Oct 2012 16:18:16 +0800
Subject: Question about move atmel audio part to DT support
In-Reply-To: <5080F54F.4000600@atmel.com>
References: <5080F54F.4000600@atmel.com>
Message-ID: <50810CC8.4050009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc:
    linux-arm-kernel mailing list
    devicetree-discuss mailing list
    alsa-devel mailing list
    linux-sound mailing list


On 10/19/2012 14:38, Bo Shen wrote:
> Hi Mark Brown,
>    Now, I am trying to move atmel audio part to DT support. I meet the
> following issue.
>
>    Atmel audio part has three platform device:
>      -> atmel ssc: ssc library (different SOC has different number)
>      -> atmel ssc dai: dai for audio
>      -> atmel pcm: for pdc or dma transfer (now only support pdc, dma
> support will add soon)
>
>   In DT support kernel, I don't find any similar case. So, if I want to
> keep ssc as library, and use dai to register pcm. Then the dts file will
> like:
> ---<8---
> ssc0: ssc at fffbc000 {
>                  status = "okay";
> };
>
> dai0: dai {
>                  compatible = "atmel,atmel-ssc-dai";
>          };
>
> sound {
>                  compatible = "atmel,at91sam9g20-audio";
>                  atmel,model = "wm8731 @ sam9g20ek";
>
>                  atmel,audio-routing =
>                          "Ext Spk", "LHPOUT",
>                          "Int Mic", "MICIN";
>
>                  atmel,audio-codec = <&wm8731>;
>                  atmel,dai = <&dai>;
> };
> --->8---
>
>    Would this be OK?
>    If not, may I add some code for ssc which dedicate for audio into
> sound/soc/atmel (using audio-ssc and ssc to distiguish which dedicate
> for audio, which used for ssc library)? This will broken the exist code
> for audio (only sam9g20-wm8731).
>    Any suggestion?
