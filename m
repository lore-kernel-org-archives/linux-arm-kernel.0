From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 Jul 2018 23:16:40 +0900
Subject: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
In-Reply-To: <20180725144717.604d3197@xps13>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-5-miquel.raynal@bootlin.com>
 <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
 <20180725115116.1fb38fe3@bbrezillon> <20180725144717.604d3197@xps13>
Message-ID: <CAK7LNASmSOi9mygxD2PLmYJ=br2qdK_UtECYZXFNavmUc4OA1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-25 21:47 GMT+09:00 Miquel Raynal <miquel.raynal@bootlin.com>:
> Hi Boris,
>
> Boris Brezillon <boris.brezillon@bootlin.com> wrote on Wed, 25 Jul 2018
> 11:51:16 +0200:
>
>> On Wed, 25 Jul 2018 18:42:44 +0900
>> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>
>> >
>> > You need to remove kfree(denali->buf)
>> > from denali_remove(), right?
>>
>> Absolutely.
>>
>> >
>> > void denali_remove(struct denali_nand_info *denali)
>> > {
>> >         struct mtd_info *mtd = nand_to_mtd(&denali->nand);
>> >
>> >         nand_release(mtd);
>> >         kfree(denali->buf);       <---- REMOVE !!
>> >         denali_disable_irq(denali);
>> > }
>> >
>> >
>> > Otherwise, denali_remove() will free denali->buf twice
>> > because kfree(denali->buf) is called from denali_detach_chip().
>>
>
> Absolutely, thanks for reviewing!
>
> I'll apply with this changed.
>
> Miqu?l


Assuming you will fix this,

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
