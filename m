From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 21 Jul 2015 15:13:58 +0200
Subject: [PATCH v8 2/2] mmc: host: sdhci: Disable 1.8V signaling for
 arasan 4.9a version of SDHCI controller.
In-Reply-To: <CAOHikRBkDinUfcOR3Dg12e2Xy_P5TABOpHSnkSpZhRyhLRWGFA@mail.gmail.com>
References: <1434715227-27399-1-git-send-email-stripathi@apm.com>
 <1434715227-27399-3-git-send-email-stripathi@apm.com>
 <CAOHikRBkDinUfcOR3Dg12e2Xy_P5TABOpHSnkSpZhRyhLRWGFA@mail.gmail.com>
Message-ID: <CAPDyKFqozGkHRSFYm=P61XnYj4F-kpoYG2CmVDc1tSkT_zQJ5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2015 at 14:28, Suman Tripathi <stripathi@apm.com> wrote:
> Hi ,
>
> On Fri, Jun 19, 2015 at 5:30 PM, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch disables the 1.8V signaling for arasan 4.9a version
>> of SDHCI controller with the help SDHCI_QUIRK2_NO_1_8_V quirk.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 21c0c08..4c99ea4 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -171,7 +171,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>
>>         if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
>>                 host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> -               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>> +               host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23 |
>> +                                SDHCI_QUIRK2_NO_1_8_V;
>>         }
>
>
> I think I am  wrong here. No-1.8v is something related to board
> regulator circuitry not related to IP version. So it should be dts
> driven.

Agree!

So I guess that will change patch1 and this one can be completely dropped?

Kind regards
Uffe
