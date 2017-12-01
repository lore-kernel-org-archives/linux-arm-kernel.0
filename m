From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 1 Dec 2017 11:12:08 +0900
Subject: [PATCH 1/5] mtd: nand: use usual return values for the ->erase()
 hook
In-Reply-To: <20171130230246.61a9ed19@xps13>
References: <20171130170132.27522-1-miquel.raynal@free-electrons.com>
 <20171130170132.27522-2-miquel.raynal@free-electrons.com>
 <20171130215113.458d616f@bbrezillon>
 <20171130230246.61a9ed19@xps13>
Message-ID: <CAK7LNASxa4GCnutU4LZhVjV4sK3YLZ+RkewvyY0P4rZENpoOwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-01 7:02 GMT+09:00 Miquel RAYNAL <miquel.raynal@free-electrons.com>:
>> > diff --git a/drivers/mtd/nand/nand_base.c
>> > b/drivers/mtd/nand/nand_base.c index 630048f5abdc..4d1f2bda6095
>> > 100644 --- a/drivers/mtd/nand/nand_base.c
>> > +++ b/drivers/mtd/nand/nand_base.c
>> > @@ -3077,7 +3077,7 @@ int nand_erase_nand(struct mtd_info *mtd,
>> > struct erase_info *instr, status = chip->erase(mtd, page &
>> > chip->pagemask);
>> >             /* See if block erase succeeded */
>> > -           if (status & NAND_STATUS_FAIL) {
>> > +           if (status) {
>> >                     pr_debug("%s: failed erase, page 0x%08x\n",
>> >                                     __func__, page);
>> >                     instr->state = MTD_ERASE_FAILED;
>>
>> You forgot to patch single_erase() accordingly.
>
> Right, sorry about that, I will fix that.
>

Assuming single_erase() will be fixed,


For denali.c

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>





-- 
Best Regards
Masahiro Yamada
