From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Fri, 5 Oct 2018 20:40:03 +0200
Subject: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
In-Reply-To: <20181005150538.17006.qmail@cr.yp.to>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
 <CAHmME9rp0Fi5ObK5oi8FHj1_nK5hP4T2Bq7_dAmzq4OQ0mp0uw@mail.gmail.com>
 <20181005150538.17006.qmail@cr.yp.to>
Message-ID: <20181005184001.GA10106@zx2c4.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Dan,

On Fri, Oct 05, 2018 at 03:05:38PM -0000, D. J. Bernstein wrote:
> Of course, there are other ARM microarchitectures, and there are many
> cases where different microarchitectures prefer different optimizations.
> The kernel already has boot-time benchmarks for different optimizations
> for raid6, and should do the same for crypto code, so that implementors
> can focus on each microarchitecture separately rather than living in the
> barbaric world of having to choose which CPUs to favor.

I've been playing a bit with some code to do this sort of thing,
choosing a set of implementations to enable or disable by trying all the
combinations, and then calculating a quick median. I don't know if I'll
submit that for the initial merge of this patchset -- and in fact all
the current implementations I'm proposing are pretty much okay on
microarchitectures -- but down the line this could be useful as a
mechanism.

Jason
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/5046b070/attachment.sig>
