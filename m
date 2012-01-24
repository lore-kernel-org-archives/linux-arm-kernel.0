From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Tue, 24 Jan 2012 14:22:28 +0530
Subject: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the suspend
 is not implemented
In-Reply-To: <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>	<1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
 <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
Message-ID: <4F1E714C.8090206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 January 2012 01:39 PM, Brian Norris wrote:
> Hi,
>
> On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> ...
>>  include/linux/mtd/mtd.h |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
>> index 1a81fde..c717bb6 100644
>> --- a/include/linux/mtd/mtd.h
>> +++ b/include/linux/mtd/mtd.h
>> @@ -427,9 +427,9 @@ static inline int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>>
>>  static inline int mtd_suspend(struct mtd_info *mtd)
>>  {
>> -       if (!mtd->suspend)
>> -               return -EOPNOTSUPP;
>> -       return mtd->suspend(mtd);
>> +       if (mtd->suspend)
>> +               return mtd->suspend(mtd);
>> +       return 0;
>>  }
>>
>>  static inline void mtd_resume(struct mtd_info *mtd)
> I believe this fix is already accounted for in Artem Bityutskiy's
> l2-mtd-2.6 repository as:
>
> commit 091a7fe219ee8d3e76be9e02221433af10c6f574
> mtd: fix MTD suspend
> (http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/091a7fe219ee8d3e76be9e02221433af10c6f574)
>
> However, the bug made it into the 3.3 merge window, so shouldn't this
> bugfix be sent upstream immediately?
OK thanks for pointing that.
> Brian
