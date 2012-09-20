From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 20 Sep 2012 10:20:48 +0200
Subject: [PATCH v2] mtd: atmel_nand: fix the compile error which miss
 label "err_ecc_ioremap".
In-Reply-To: <20120920052333.GC17667@game.jcrosoft.org>
References: <1347347412-24214-1-git-send-email-josh.wu@atmel.com>
 <20120920052333.GC17667@game.jcrosoft.org>
Message-ID: <505AD1E0.2040607@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 07:23 AM, Jean-Christophe PLAGNIOL-VILLARD :
> On 15:10 Tue 11 Sep     , Josh Wu wrote:
>> Add err_ecc_ioremap label to fix following errors:
>> ---8<--- 
>>   CC      drivers/mtd/nand/atmel_nand.o
>> drivers/mtd/nand/atmel_nand.c: In function 'atmel_nand_probe':
>> drivers/mtd/nand/atmel_nand.c:1423: error: label 'err_ecc_ioremap' used but not defined
>> make[3]: *** [drivers/mtd/nand/atmel_nand.o] Error 1
>> make[2]: *** [drivers/mtd/nand] Error 2
>> make[1]: *** [drivers/mtd] Error 2
>> make: *** [drivers] Error 2
>> --->8---
> switch to devm_xxx instead this will simplify the error patch and remove patch

As far as I understand, it is a correction patch: so my advice would be
to take this patch for fixing the current code (for 3.7 if I recall well).
If we want to move to the new devm_xxx API, we can do it once the
current code is fixed.

Bye,
-- 
Nicolas Ferre
