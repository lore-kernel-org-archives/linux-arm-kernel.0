From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 8 Jul 2015 16:18:48 +0900
Subject: [PATCH] ARM: tegra: roth: Add MMC pwrseq to power wifi on
In-Reply-To: <CABxcv=kBcr7g77jj98KQ19R_oaoTrVGjqDgQa6ghZz7CJ+t3uw@mail.gmail.com>
References: <1433749292-13890-1-git-send-email-acourbot@nvidia.com>
 <CABxcv=kBcr7g77jj98KQ19R_oaoTrVGjqDgQa6ghZz7CJ+t3uw@mail.gmail.com>
Message-ID: <CAAVeFuJ8sQN6t3tPQNyHizd4LGz=0=R3xdrdQstq5PtwYYnwSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping Thierry, is this patch good to be merged?

On Mon, Jun 8, 2015 at 5:12 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Alexandre,
>
> On Mon, Jun 8, 2015 at 9:41 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>> The wifi chip on roth needs to have its reset deasserted in order to be
>> probed. Add a mmc-pwrseq-simple to allow this to happen and get wifi
>> working at boot time.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  arch/arm/boot/dts/tegra114-roth.dts | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
>> index ea1772a686c2..04762532a178 100644
>> --- a/arch/arm/boot/dts/tegra114-roth.dts
>> +++ b/arch/arm/boot/dts/tegra114-roth.dts
>> @@ -972,6 +972,11 @@
>>                 nvidia,invert-interrupt;
>>         };
>>
>> +       sdhci0_pwrseq: sdhci0_pwrseq {
>> +               compatible = "mmc-pwrseq-simple";
>> +               reset-gpios = <&gpio TEGRA_GPIO(CC, 5) GPIO_ACTIVE_LOW>;
>> +       };
>> +
>>         /* Wifi */
>>         sdhci at 78000000 {
>>                 status = "okay";
>> @@ -979,6 +984,7 @@
>>                 broken-cd;
>>                 keep-power-in-suspend;
>>                 cap-sdio-irq;
>> +               mmc-pwrseq = <&sdhci0_pwrseq>;
>>         };
>>
>>         /* SD card */
>
> I'm neither familiar with this board nor have a schematic but the
> patch looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>
> Best regards,
> Javier
