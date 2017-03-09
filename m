From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 9 Mar 2017 23:45:30 +0300
Subject: [PATCH 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <38ee4af3-b2cf-e9a8-1339-d7d904b7dc15@cogentembedded.com>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170309130216epcas5p276d211cfa5ed9f87b11a73ebe6fcdc7c@epcas5p2.samsung.com>
 <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
 <38ee4af3-b2cf-e9a8-1339-d7d904b7dc15@cogentembedded.com>
Message-ID: <f82787e1-9d35-a410-f3e6-c7432e61c140@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2017 08:05 PM, Sergei Shtylyov wrote:

>> Add Palmchip BK3710 PATA controller driver.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/ata/Kconfig       |   9 ++
>>  drivers/ata/Makefile      |   1 +
>>  drivers/ata/pata_bk3710.c | 395 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 405 insertions(+)
>>  create mode 100644 drivers/ata/pata_bk3710.c
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 7e0fc98..c23ee65 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -509,6 +509,15 @@ config PATA_BF54X
>>
>>        If unsure, say N.
>>
>> +config PATA_BK3710
>> +    tristate "Palmchip BK3710 PATA support"
>> +    depends on ARCH_DAVINCI
>> +    help
>> +      This option enables support for the integrated IDE controller on
>> +      the TI DaVinci SoC.
>
>    Strictly speaking, Palmchip BK3710 is Mentor Graphics' IDE core, used on
> the original DaVinci's. Mentor's documentation was never publicly available
> though...

    From googling I knew that Palmchip was a company Mentor probably bought...

> [...]

    I'll try to review the whole driver on weekend.

MBR, Sergei
