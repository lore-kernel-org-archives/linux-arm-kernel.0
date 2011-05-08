From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 8 May 2011 14:55:54 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <4DC6910F.2020008@hauke-m.de>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<4DC6910F.2020008@hauke-m.de>
Message-ID: <BANLkTi=wtxH6suf8D=nzYKrBjWV9-yAQLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/8 Hauke Mehrtens <hauke@hauke-m.de>:
> On 05/05/2011 11:59 PM, Rafa? Mi?ecki wrote:
> .....
>> --- /dev/null
>> +++ b/drivers/bcma/bcma_private.h
> .....
>> +
>> +#define BCMA_ADDR_BASE ? ? ? ? ? ? ? 0x18000000
>> +#define BCMA_WRAP_BASE ? ? ? ? ? ? ? 0x18100000
>> +
> ......
>> --- /dev/null
>> +++ b/drivers/bcma/scan.h
>> @@ -0,0 +1,56 @@
>> +#ifndef BCMA_SCAN_H_
>> +#define BCMA_SCAN_H_
>> +
>> +#define BCMA_ADDR_BASE ? ? ? ? ? ? ? 0x18000000
>> +#define BCMA_WRAP_BASE ? ? ? ? ? ? ? 0x18100000
>> +
> .....
>
> While graping through the code I found this. BCMA_ADDR_BASE and
> BCMA_WRAP_BASE are defined twice.

Will fix, thx.


> Why are some constants defined in purpose specific headers in
> drivers/bcma/*.h like drivers/bcma/scan.h and some in
> drivers/bcma/bcma_private.h and other in include/linux/bcma/bcma_regs.h ?

What is unclear to you in this split? It says everything. scan.h for
scanning, regs for registers, private for internal functions.

-- 
Rafa?
