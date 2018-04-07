From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 7 Apr 2018 11:07:54 +0200
Subject: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
In-Reply-To: <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
Message-ID: <20180407090754.GP4082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 04:50:19PM -0400, Waiman Long wrote:
>   # of threads  4.16 kernel     patched 4.16 kernel
>   ------------  -----------     -------------------
>         1       7,417 kop/s         7,408 kop/s
>         2       5,755 kop/s         4,486 kop/s
>         3       4,214 kop/s         4,169 kop/s
>         4       4,396 kop/s         4,383 kop/s
>        

Interesting, I didn't see that dip in my userspace tests.. I'll have to
try again.
