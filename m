From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Oct 2016 20:51:51 +0200
Subject: [PATCH v3 1/3] mtd: s3c2410: make ecc mode configurable via
 platform data
In-Reply-To: <20161021182710.GA17279@kozik-lap>
References: <1476999766-32526-1-git-send-email-sergio.prado@e-labworks.com>
 <1476999766-32526-2-git-send-email-sergio.prado@e-labworks.com>
 <20161021182710.GA17279@kozik-lap>
Message-ID: <5a626833-d4bf-a991-65ea-2849f2250dce@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 08:27 PM, Krzysztof Kozlowski wrote:
> On Thu, Oct 20, 2016 at 07:42:44PM -0200, Sergio Prado wrote:
>> Removing CONFIG_MTD_NAND_S3C2410_HWECC option and adding a ecc_mode
>> field in the drivers's platform data structure so it can be selectable
>> via platform data.
>>
>> Also setting this field to NAND_ECC_SOFT in all boards using this
>> driver since none of them had CONFIG_MTD_NAND_S3C2410_HWECC enabled.
>>
>> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
>> ---
>>  arch/arm/mach-s3c24xx/common-smdk.c            |   1 +
>>  arch/arm/mach-s3c24xx/mach-anubis.c            |   1 +
>>  arch/arm/mach-s3c24xx/mach-at2440evb.c         |   1 +
>>  arch/arm/mach-s3c24xx/mach-bast.c              |   1 +
>>  arch/arm/mach-s3c24xx/mach-gta02.c             |   1 +
>>  arch/arm/mach-s3c24xx/mach-jive.c              |   1 +
>>  arch/arm/mach-s3c24xx/mach-mini2440.c          |   1 +
>>  arch/arm/mach-s3c24xx/mach-osiris.c            |   1 +
>>  arch/arm/mach-s3c24xx/mach-qt2410.c            |   1 +
>>  arch/arm/mach-s3c24xx/mach-rx1950.c            |   1 +
>>  arch/arm/mach-s3c24xx/mach-rx3715.c            |   1 +
>>  arch/arm/mach-s3c24xx/mach-vstms.c             |   1 +
>>  arch/arm/mach-s3c64xx/mach-hmt.c               |   1 +
>>  arch/arm/mach-s3c64xx/mach-mini6410.c          |   1 +
>>  arch/arm/mach-s3c64xx/mach-real6410.c          |   1 +
>>  drivers/mtd/nand/Kconfig                       |   9 --
>>  drivers/mtd/nand/s3c2410.c                     | 119 +++++++++++++------------
>>  include/linux/platform_data/mtd-nand-s3c2410.h |   6 +-
>>  18 files changed, 79 insertions(+), 70 deletions(-)
>>
> 
> I acked this twice (v1 and v2)... and still you are ignoring them. I am
> sorry, I am not gonna to ack this third time!

Hi, um, I am kinda new to this mess, what's going on ? You ACKed
previous patches, next revision was submitted, so you need to ACK
the next revision too (due to the changes).

> For v2 I acked also other patches but it it is not there as well...
> 
> BR,
> Krzysztof


-- 
Best regards,
Marek Vasut
