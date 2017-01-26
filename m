From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 26 Jan 2017 14:39:23 +0200
Subject: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
In-Reply-To: <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
Message-ID: <2e67332d-d8c3-fd24-1f81-72675a09927a@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/17 12:50, Ulf Hansson wrote:
> On 11 January 2017 at 18:19, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> +                       priv->init_card_type = MMC_TYPE_MMC;
>> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
>> +
>> +                       /*
>> +                        * Force to clear BUS_TEST to
>> +                        * skip bus_test_pre and bus_test_post
>> +                        */
>> +                       mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>> +                       mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
> 
> This cap is a bit strange. It was added several years ago by Adrian
> Hunter, but I am wondering about the reason to why it's needed.
> 

MMC_CAP2_HC_ERASE_SZ relates to EXT-CSD ERASE_GROUP_DEF.

I think it was added to enable people to choose whether they wanted a large
or small erase granularity.  That probably doesn't matter if the card
supports TRIM.
