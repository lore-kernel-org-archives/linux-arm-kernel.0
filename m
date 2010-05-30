From: bbb.lst@gmail.com (Bjoern Brandenburg)
Date: Sun, 30 May 2010 17:38:46 -0400
Subject: 2.6.34 hangs during boot on PB11MPCore
In-Reply-To: <AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
References: <AANLkTin9n6HDdiTnQoQ9mrmuzSR8JhZVq7uPgU86yqgU@mail.gmail.com>
	<20100530073652.GX2695@buzzloop.caiaq.de>
	<AANLkTimUF5iiGnc6RnN5C3sy-R6DAqHZNf6ZEu2o3W9P@mail.gmail.com>
	<AANLkTikdvjg52v-3AKUBukGO2FCp3fENGoYgpZZ2xVtT@mail.gmail.com>
Message-ID: <AANLkTilMtEpt5hRfF_hszpU_AxZm7H93bkhqUacGWZc9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 30, 2010 at 5:05 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
> On Sun, May 30, 2010 at 3:27 PM, Bjoern Brandenburg <bbb.lst@gmail.com> wrote:
>>
>> I'll try to see if I can pinpoint what was dropped between 2.6.33-arm1
>> and 2.6.34-arm.
>
> Progress: I can get 2.6.34-arm to boot with all 4 CPUs after
> cherry-picking the following commits (which seemed relevant but
> absent):
>
> 60060ca ARM: Handle instruction cache maintenance fault ?properly
> 3f64e83 ARM errata: Eviction Buffer not empty after Cache Sync on L220
> 3b009b5 ARM: change definition of cpu_relax() for ARM11MPCore
>
> Let's see which is the critical one...

It's 3f64e83 "ARM errata: Eviction Buffer not empty after Cache Sync
on L220" [1]. With this commit cherry-picked (on top of the 'rebased'
branch in ARM's repository, i.e., 2.6.34-arm), the system boots to X11
and runs some simple FS tests; the other ones don't make a difference.

Are there plans for getting this and the other patches in the
'rebased' branch into mainline (for .35 or .36)?

- Bj?rn

[1]  http://linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=3f64e83e9935106acd3264a350260d74c618f263
