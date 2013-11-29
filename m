From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 29 Nov 2013 17:44:18 +0200
Subject: [PATCH 0/7] Davinci nand driver fixes and updates
In-Reply-To: <5298B49C.1050104@ti.com>
References: <1384960945-14528-1-git-send-email-ivan.khoronzhuk@ti.com>
 <5298B49C.1050104@ti.com>
Message-ID: <5298B652.1050001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 05:37 PM, Santosh Shilimkar wrote:
> Ivan,
> 
> On Wednesday 20 November 2013 10:22 AM, Ivan Khoronzhuk wrote:
>> This series contains fixes and updates of Davinci nand driver, in
>> order to prepare it to be reused for Keystone platform.
>>
>> V1:
>> https://lkml.org/lkml/2013/11/11/352
>>
>> Ivan Khoronzhuk (7):
>>    mtd: nand: davinci: fix driver registration
>>    mtd: nand: davinci: return ENOMEM if memory allocation is failed
>>    mtd: nand: davinci: check required ti,davinci-chipselect property
>>    mtd: nand: davinci: simplify error handling
>>    mtd: nand: davinci: move bindings under mtd
>>    mtd: nand: davinci: extend description of bindings
>>    mtd: nand: davinci: adjust DT properties to MTD generic
>>
>>   .../devicetree/bindings/arm/davinci/nand.txt       |   46 ----------
>>   .../devicetree/bindings/mtd/davinci-nand.txt       |   92 ++++++++++++++++++++
>>   drivers/mtd/nand/davinci_nand.c                    |   68 +++++++--------
>>   3 files changed, 126 insertions(+), 80 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/arm/davinci/nand.txt
>>   create mode 100644 Documentation/devicetree/bindings/mtd/davinci-nand.txt
>>
> Can you please update the series with pending comments and
> send a refreshed version.

New series was posted week ago https://lkml.org/lkml/2013/11/21/182
"[PATCH v2 00/10] Reuse davinci-nand driver for Keystone arch"

Now we will need to remove one patch form it, which will go alone
as discussed - no other comments were provided.

Patch:
 "[PATCH v2 09/10] mtd: nand: davinci: don't set timings if AEMIF is used"

replaced by:
 https://lkml.org/lkml/2013/11/27/256
 "[PATCH v2] ARM: davinci: aemif: get rid of davinci-nand driver dependency on aemif"

Regards,
- grygorii
