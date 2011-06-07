From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 7 Jun 2011 08:49:48 +0200
Subject: [PATCH v2 1/2] sdio: add quirk to handle pending IRQ in case of
	none CCCR_INTx bits
In-Reply-To: <4DE6B0E8.9050306@boundarydevices.com>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
	<1306918113-23872-2-git-send-email-per.forlin@stericsson.com>
	<4DE6B0E8.9050306@boundarydevices.com>
Message-ID: <BANLkTi=Dmntzb=4BBptwqZ5WfBMQYbaTGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2011 23:36, Troy Kisky <troy.kisky@boundarydevices.com> wrote:
> On 6/1/2011 1:48 AM, Per Forlin wrote:
>> From: Per Forlin <per.forlin@linaro.org>
>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 7b4fd7b..852021c 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -175,6 +175,7 @@ struct mmc_card {
>> ?#define MMC_QUIRK_DISABLE_CD (1<<5) ? ? ? ? ?/* disconnect CD/DAT[3] resistor */
>> ?#define MMC_QUIRK_INAND_CMD38 ? ? ? ?(1<<6) ? ? ? ? ?/* iNAND devices have broken CMD38 */
>> ?#define MMC_QUIRK_BLK_NO_CMD23 ? ? ? (1<<7) ? ? ? ? ?/* Avoid CMD23 for regular multiblock */
>> +#define MMC_QUIRK_SDIO_IRQ_CCCR_INTX_0 (1<<7) ? ? ? ?/* SDIO card has IRQ even if CCCR_INTx is 0 */
>
> Using the same value as MMC_QUIRK_BLK_NO_CMD23 looks odd...
>
Thanks for your observation.
Typo, it should be (1 << 8)
I'll update the patch but I don't plan post a new version yet. The
root cause issue in the libertas is resolved. If the fix turns out to
be needed later on I resend it.

Thanks,
Per
