From: longman@redhat.com (Waiman Long)
Date: Wed, 11 Apr 2018 15:13:16 -0400
Subject: [PATCH v2 09/13] locking/qspinlock: Merge struct __qspinlock into
 struct qspinlock
In-Reply-To: <1523469680-17699-10-git-send-email-will.deacon@arm.com>
References: <1523469680-17699-1-git-send-email-will.deacon@arm.com>
 <1523469680-17699-10-git-send-email-will.deacon@arm.com>
Message-ID: <2e517a58-be06-5d1d-0e27-67c2c3a9d3d7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2018 02:01 PM, Will Deacon wrote:
> struct __qspinlock provides a handy union of fields so that
> subcomponents of the lockword can be accessed by name, without having to
> manage shifts and masks explicitly and take endianness into account.
>
> This is useful in qspinlock.h and also potentially in arch headers, so
> move the struct __qspinlock into struct qspinlock and kill the extra
> definition.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Acked-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

I think you are using the new qspinlock structure in some of your
earlier patches like patch 4. So you may want to move that earlier in
the series to avoid bisection problem.

Cheers,
Longman
