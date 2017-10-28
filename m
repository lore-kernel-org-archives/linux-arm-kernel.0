From: cj.chengjian@huawei.com (chengjian (D))
Date: Sat, 28 Oct 2017 14:10:02 +0800
Subject: [PATCH v3 0/5] Switch arm64 over to qrwlock
In-Reply-To: <20171019165332.GD30652@arm.com>
References: <1507810851-306-1-git-send-email-will.deacon@arm.com>
 <20171019165332.GD30652@arm.com>
Message-ID: <1745f003-ea97-bdce-06fd-a5b80e63979f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all.


On 2017/10/20 0:53, Will Deacon wrote:
> I've not had any more feedback on this and the testing results are very
> encouraging so I'd like to merge it for 4.15. However, it might make more
> sense for the whole thing to go via -tip instead.
>
> Ingo, Peter: what do you prefer?
>
> Will
>
>> Will Deacon (5):
>>    kernel/locking: Use struct qrwlock instead of struct __qrwlock
>>    locking/atomic: Add atomic_cond_read_acquire
>>    kernel/locking: Use atomic_cond_read_acquire when spinning in qrwlock
>>    arm64: locking: Move rwlock implementation over to qrwlocks
>>    kernel/locking: Prevent slowpath writers getting held up by fastpath
>>
>>   arch/arm64/Kconfig                      |  17 ++++
>>   arch/arm64/include/asm/Kbuild           |   1 +
>>   arch/arm64/include/asm/spinlock.h       | 164 +-------------------------------
>>   arch/arm64/include/asm/spinlock_types.h |   6 +-
>>   include/asm-generic/atomic-long.h       |   3 +
>>   include/asm-generic/qrwlock.h           |  37 ++-----
>>   include/asm-generic/qrwlock_types.h     |  15 ++-
>>   include/linux/atomic.h                  |   4 +
>>   kernel/locking/qrwlock.c                |  86 +++--------------
>>   9 files changed, 61 insertions(+), 272 deletions(-)
>>
>> -- 
>> 2.1.4

I am very interested in this change.
Can you share the testing result for me?
Or Test methods, especially test suite and so on.

I would like to further test the performance.

Thanks.
     Cheng Jian
