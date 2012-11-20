From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 20 Nov 2012 17:31:22 +0800
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
In-Reply-To: <50A5E44D.6040501@atmel.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
 <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
 <20121116061250.GP4387@opensource.wolfsonmicro.com>
 <50A5DE4E.80206@atmel.com>
 <20121116064113.GQ4387@opensource.wolfsonmicro.com>
 <50A5E44D.6040501@atmel.com>
Message-ID: <50AB4DEA.3090100@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/16/2012 14:59, Bo Shen wrote:
> On 11/16/2012 14:41, Mark Brown wrote:
>> On Fri, Nov 16, 2012 at 02:33:50PM +0800, Bo Shen wrote:
>>> On 11/16/2012 14:12, Mark Brown wrote:
>>
>>>> No, this isn't what was meant - the idea is to send only the
>>>> addition of
>>>> pinctrl data as one patch, based off the ASoC branch instead of -next.
>>
>>> What is the pinctrl data? (This patch can be applied on
>>
>> The data you're adding in the device tree!
>>
>>> sound/topic/atmel branch without any conflicts)
>>
>> That's not helpful to anyone doing bisection if there's nothing defining
>> the pin states, it means that the system won't be able to start the
>> driver as the API call will fail.
>>
>>> The other one add pinctrl nodes, must based on -next, or else I
>>> don't know where should I add the pinctrl nodes.
>>
>> What makes you say this?
>
> For example, if I want to add pinctrl node
> ---<8---
>   ssc0 {
>      pinctrl_ssc0_tx: ssc0_tx-0 {
>              atmel,pins = <1 16 0x1 0x0   /* PB16 periph A */
>                            1 17 0x1 0x0   /* PB17 periph A */
>                                  1 18 0x1 0x0>; /* PB18 periph A */
>          };
> --->8---
> This should be add into dtsi file as following
> ---<8---
> ahb {
>      apb {
>          pinctrl {
>              ssc0 {
>                  pinctrl_ssc0_tx
>              }
>          }
>      }
> }
> --->8---
>
> In the ASoC branch tree, I don't see any pinctrl related information.
> So, I say I don't know where should I add the pinctrl nodes.
>
> May be I misunderstanding, do you mean I should only add as followign
> based on ASoC tree? And the upper go into pinctrl tree?
> ---<8---
> ssc0: ssc at fffbc000 {
>      compatible = "atmel,at91rm9200-ssc";
>          reg = <0xfffbc000 0x4000>;
>          interrupts = <14 4 5>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
>          status = "disable";
> };
> --->8---

Any suggestion for this? what should I do with this patch for next?

> Best Regards
> Bo Shen
>
>
