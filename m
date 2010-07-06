From: augulis.darius@gmail.com (Darius Augulis)
Date: Tue, 06 Jul 2010 20:02:52 +0300
Subject: S3C2416 fixes (gpiolib, SDHCI, compilation without FB device)
In-Reply-To: <000001cb1687$638b2310$2aa16930$%szyprowski@samsung.com>
References: <1277212585-25605-1-git-send-email-jekhor@gmail.com>
	<4C248B23.7060905@gmail.com>
	<000001cb1687$638b2310$2aa16930$%szyprowski@samsung.com>
Message-ID: <4C3361BC.2040204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 06/28/2010 09:01 AM, Marek Szyprowski wrote:
> Hello,
>
> On Friday, June 25, 2010 12:56 PM Darius Augulis wrote:
>
>> On 06/22/2010 04:16 PM, Yauhen Kharuzhy wrote:
>>> This patch series fixes SDHCI on S3C2416. I got SD card working with this
>> patches
>>> and with patches for GPIO card detection support by Marek Szyprowski.
>>>
>>
>> Unfortunately I did not get SD card working with these patches. I'm
>> using custom board, not SMDK2416, but SD slot connection and schematics
>> are the same like in SMDK2416. I've tried to debug a bit this problem
>> and this is what I got: kernel do detection of card insert/remove,
>> driver prints messages:
>>
>> s3c-sdhci s3c-sdhci.1: card inserted.
>> s3c-sdhci s3c-sdhci.1: card removed.
>>
>> Then I put some printk in s3c-sdhci driver and MMC core and found that
>> mmc_rescan() is called only once at startup and no more when
>> inserting/removing SD card. Also mmc_rescan() stops at that point where
>> mmc_power_up() is called and does not return. And mmc_power_up() stops
>> where mmc_delay(10) is called and does not return too.
>> Every time when inserting/removing SD card only functions
>> sdhci_tasklet_card() and mmc_detect_change() are called, and nothing
>> happens. Kernel doesn't detect the card inserted.
>> Maybe this info could help to debug where the problem is - in my custom
>> board or in your patches?
>
> Have you tried with polled card detection method (SDHCI_CD_NONE)? If it
> doesn't work I suspect something with the hardware. Checking with mmc debug
> enabled might also help figuring this issue out.

yes, I've tried that, but didn't get sd card working. I got schematics 
from China manufacturer, SD card connection is the same like in 
smdk2416. with mmc debug enabled I found that SD card is detected when 
inserted or removed, but after detection card initialisation is not 
performed.

Darius.


>
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
