From: andrea.adami@gmail.com (Andrea Adami)
Date: Mon, 14 Aug 2017 15:40:58 +0200
Subject: [PATCH v4 2/9] mtd: nand: sharpsl.h: support partition parser
 types
In-Reply-To: <20170813094019.2fced1d1@bbrezillon>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
 <1498681836-3765-3-git-send-email-andrea.adami@gmail.com>
 <20170813094019.2fced1d1@bbrezillon>
Message-ID: <CAAQYJAsYNUB5G4jw7-P2jFq3i0PdUejpvwA9XC-Wyv4nVDPVMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 13, 2017 at 9:40 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Le Wed, 28 Jun 2017 22:30:29 +0200,
> Andrea Adami <andrea.adami@gmail.com> a ?crit :
>
> Please add a commit message explaining why you're doing that.
>
Sure, I have added a short text.

>> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
>> ---
>>  include/linux/mtd/sharpsl.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
>> index 65e91d0..c0e0be2 100644
>> --- a/include/linux/mtd/sharpsl.h
>> +++ b/include/linux/mtd/sharpsl.h
>> @@ -17,4 +17,5 @@ struct sharpsl_nand_platform_data {
>>       const struct mtd_ooblayout_ops *ecc_layout;
>>       struct mtd_partition    *partitions;
>>       unsigned int            nr_partitions;
>> +     const char *const       *types; /* names of parsers to use if any */
>
> types is not really descriptive here. How about 'part_parsers' or
> something clearly reflecting the purpose of this field.

I took this line somewhere from a pending mtd patch.
I wasn't convinced of the name and   part_parsers   is better.

>
> BTW, try to avoid putting comments on the same line.
Yeah, we talked about these janitoring needs. Removed.

>
>>  };
>

Please review v5 (coming soon).

Thanks
Andrea
