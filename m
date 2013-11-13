From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 13 Nov 2013 19:17:25 +0800
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: add eMMC HS200 mode support
In-Reply-To: <20131031071826.GF23549@S2101-09.ap.freescale.net>
References: <1383142242-24989-1-git-send-email-b29396@freescale.com>
 <1383142242-24989-3-git-send-email-b29396@freescale.com>
 <20131031071826.GF23549@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=Qz3fk8mXWVKqi6qQp5GPQrK43nDrUrWhTtn81t79iePg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Oct 31, 2013 at 3:18 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Oct 30, 2013 at 10:10:42PM +0800, Dong Aisheng wrote:
>> Add support for eMMC 4.5 cards to work on hs200 mode.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>

Would you help pick this series too?

Regards
Dong Aisheng

>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index ec25421..5816585 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -825,6 +825,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>>               pinctrl = imx_data->pins_100mhz;
>>               break;
>>       case MMC_TIMING_UHS_SDR104:
>> +     case MMC_TIMING_MMC_HS200:
>>               pinctrl = imx_data->pins_200mhz;
>>               break;
>>       default:
>> @@ -852,6 +853,7 @@ static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>               imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR50;
>>               break;
>>       case MMC_TIMING_UHS_SDR104:
>> +     case MMC_TIMING_MMC_HS200:
>>               imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
>>               break;
>>       case MMC_TIMING_UHS_DDR50:
>> --
>> 1.7.2.rc3
>>
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
