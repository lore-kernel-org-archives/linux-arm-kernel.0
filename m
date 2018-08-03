From: ramana.gcc@googlemail.com (Ramana Radhakrishnan)
Date: Fri, 3 Aug 2018 10:37:29 +0100
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
 <CAJA7tRZbmnZq7RfvQeYEy_a1ZObWqpFpVdvgsXgsioQ3RyPMuA@mail.gmail.com>
 <CAKv+Gu97QvwoLLK_zueiA_gjg_4Q5cqU4YVUyHUVFFfffdyJaw@mail.gmail.com>
Message-ID: <CAJA7tRahXGuPK=ktS5h86MZuV_o5cA3x1JbbyuwVspAHLKdP9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

< snip>

> I guess the semantics of a framebuffer are not strictly defined, but
> the current reality is that it is expected to have memory semantics
> (by Linux/glibc)
>
> Matt is saying fundamental properties of the underlying interconnects
> (AMBA) make that impossible on ARM, but I'd like to understand better
> if that is universally the case, and whether such a system is still
> PCIe compliant.

I don't know that side of the architecture enough to make any
definitive statements.

>
> The discussion about whether memcpy() should rely on unaligned
> accesses, and whether you should use it on device memory is orthogonal
> to that, and not the heart of the matter IMO

Then maybe take libc-alpha off if it isn't relevant.

regards
Ramana
