From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 06 May 2018 11:56:44 +1000
Subject: [RFC PATCH] locking/atomics/powerpc: Introduce optimized
 cmpxchg_release() family of APIs for PowerPC
In-Reply-To: <20180505100055.yc4upauxo5etq5ud@gmail.com>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505100055.yc4upauxo5etq5ud@gmail.com>
Message-ID: <cafd11f9b594903ff1f0acc4d7e7f7453aeb971f.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-05-05 at 12:00 +0200, Ingo Molnar wrote:
> This clearly suggests that PPC_RELEASE_BARRIER is in active use and 'lwsync' is 
> the 'release barrier' instruction, if I interpreted that right.

The closest to one we got.

The semantics are that it orders all load/store pairs to cachable
storage except store+load.

Cheers,
Ben.
