From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 27 May 2013 17:59:59 +0800
Subject: [PATCH v2 0/4] mtd: atmel_nand: enable Nand Flash Controller
 (NFC) support
In-Reply-To: <20130524195525.GL24476@game.jcrosoft.org>
References: <1368784308-7600-1-git-send-email-josh.wu@atmel.com>
 <20130524195525.GL24476@game.jcrosoft.org>
Message-ID: <51A32E9F.7090009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/25/2013 3:55 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:51 Fri 17 May     , Josh Wu wrote:
>> This patch series enable NFC support for SAMA5 soc. It can send command,
>> address cycles automaticly. Also when enable NFC sram, NFC will transfer
>> data to sram. Which can save lots of cpu time.
> can you give some stats please

I already have some test stats in the followed patches. Maybe I can put 
the summary here too.

>
> and performance comparaisan NFS vs DMA

OK. I will add the DMA test data.

Best Regards,
Josh Wu

>
> Best Regards,
> J.
>> v1 --> v2:
>>   1) rebase it with latest l2-mtd git tree:
>>      - remove useless nand commands (NAND_CMD_DEPLETE1, NAND_CMD_STATUS_ERRORx).
>>      - adopt to the new nand write function's parameters. Add error message when
>>        handle subpage write via nfc sram.
>>   2) rewrite pmecc_enable function. Now I use exist NAND_ECC_READ/WRITE const
>>      instead of using a new enum definition.
>>
>> Josh Wu (4):
>>    mtd: atmel_nand: replace pmecc enable code with one function.
>>    mtd: atmel_nand: add Nand Flash Controller (NFC) support
>>    mtd: atmel_nand: enable Nand Flash Controller (NFC) read data via
>>      sram
>>    mtd: atmel_nand: enable Nand Flash Controller (NFC) write via sram
>>
>>   .../devicetree/bindings/mtd/atmel-nand.txt         |    4 +
>>   drivers/mtd/nand/atmel_nand.c                      |  657 ++++++++++++++++++--
>>   drivers/mtd/nand/atmel_nand_nfc.h                  |  106 ++++
>>   3 files changed, 718 insertions(+), 49 deletions(-)
>>   create mode 100644 drivers/mtd/nand/atmel_nand_nfc.h
>>
>> -- 
>> 1.7.9.5
>>
