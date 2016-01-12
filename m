From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 12 Jan 2016 10:27:11 +0100
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <56945366.2090504@imgtec.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
Message-ID: <20160112092711.GP6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:

> This statement doesn't fit MIPS barriers variations. Moreover, there is a
> reason to extend that even more specific, at least for smp_store_release and
> smp_load_acquire, look into
> 
>     http://patchwork.linux-mips.org/patch/10506/

Dude, that's one horrible patch.

1) you do not make such things selectable; either the hardware needs
them or it doesn't. If it does you _must_ use them, however unlikely.

2) the changelog _completely_ fails to explain the sync 0x11 and sync
0x12 semantics nor does it provide a publicly accessible link to
documentation that does.

3) it really should have explained what you did with
smp_llsc_mb/smp_mb__before_llsc() in _detail_.

And I agree that ideally it should be split into parts.

Seriously, this is _NOT_ OK.
