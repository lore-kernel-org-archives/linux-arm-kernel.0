From: keescook@chromium.org (Kees Cook)
Date: Tue, 30 Jul 2013 12:05:40 -0700
Subject: [ARM ATTEND] catching up on exploit mitigations
Message-ID: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'd like to propose the topic of catching up to x86 exploit
mitigations and security features, and potentially identifying
ARM-unique mitigations/features that could be implemented. Several
years ago, with Nicolas Pitre doing all the real work, I coordinated
getting ARM caught up on things like userspace ASLR and
stack-protector. Recently, based on work by Will Drewry, I ported
seccomp-bpf to ARM. I'd like to continue this kind of thing, and I
think it's overdue to examine this area again. A lot of work has
already been done by grsecurity in this area (see
http://forums.grsecurity.net/viewtopic.php?f=7&t=3292), so it would be
good to start there.

While it may expose my current ignorance of low level ARM mechanics,
I'd like to examine and discuss:

- RO and W^X kernel page table protections (similar to x86's
DEBUG_RODATA and DEBUG_SET_MODULE_RONX; it's not clear to me how much
LPAE and PXN is already handling this, if at all)

- something like x86's SMEP and SMAP (to deter kernel exploitation
from userspace)

- vector table protections (needs to be protected like the x86_64
vsyscall table, RO, etc)

- kernel ASLR (I'm close to having this upstreamable for x86)

- fuzzing (is anyone running trinity or similar on the ARM tree?)

- any other things ... ?

Thanks,

-Kees

-- 
Kees Cook
Chrome OS Security
