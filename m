From: tushar.b@samsung.com (Tushar Behera)
Date: Sun, 22 Jun 2014 21:23:37 +0530
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in
 Exynos5420
In-Reply-To: <539ED472.5020102@gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
 <CABxcv=kX07pNCd-YPYp6J8S5hHzG1rsoer1YRfdPE0g-xFqZnQ@mail.gmail.com>
 <539ED472.5020102@gmail.com>
Message-ID: <CAC5m3Byht1TRGu28Y-_mRY8iZT+=rrzpQS1jx5rxQaJ7XLKxTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 4:56 PM, Tushar Behera <trblinux@gmail.com> wrote:
> On 06/11/2014 09:28 PM, Javier Martinez Canillas wrote:
>> On Wed, Jun 11, 2014 at 7:32 AM, Tushar Behera <tushar.b@samsung.com> wrote:
>>> Currently CLK_FOUT_EPLL was set as one of the parents of AUDSS mux.
>>> As per the user manual, it should be CLK_MAU_EPLL.
>>>
>>> The problem surfaced when the bootloader in Peach-pit board set
>>> the EPLL clock as the parent of AUDSS mux. While booting the kernel,
>>> we used to get a system hang during late boot if CLK_MAU_EPLL was
>>> disabled.
>>>
>>> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
>>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>>> Reported-by: Kevin Hilman <khilman@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>>> index e385322..79e9119 100644
>>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>>> @@ -167,7 +167,7 @@
>>>                 compatible = "samsung,exynos5420-audss-clock";
>>>                 reg = <0x03810000 0x0C>;
>>>                 #clock-cells = <1>;
>>> -               clocks = <&clock CLK_FIN_PLL>, <&clock CLK_FOUT_EPLL>,
>>> +               clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MAU_EPLL>,
>>>                          <&clock CLK_SCLK_MAUDIO0>, <&clock CLK_SCLK_MAUPCM0>;
>>>                 clock-names = "pll_ref", "pll_in", "sclk_audio", "sclk_pcm_in";
>>>         };
>>> --
>>> 1.7.9.5
>>>
>>> --
>>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
>
> Kukjin,
>
> Would you please take this patch as a fix for 3.16?
>
> --
> Tushar Behera

Kukjin,

Please pick this patch for 3.16. This is an essential fix required for
Peach-pit/Peach-pi board.

--
Tushar Behera
