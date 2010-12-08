From: david-b@pacbell.net (David Brownell)
Date: Wed, 8 Dec 2010 08:38:28 -0800 (PST)
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
In-Reply-To: <AANLkTin8r4-ooAUsf-T5SnM_QDHdY_c3XfRL4o=nZkHC@mail.gmail.com>
Message-ID: <603978.51278.qm@web180303.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So to recapitulate ... you're agreeing with me on
my key point -- that ARM1156, a V6T2 core with
 Thumb2 support (used in fact to introduce
Thumb2), should  work for some in-kernel Thumb2
usage, degree TBD, but obviously the v7 cores
are more capable (with SIMD support in T2, etc).

And no, *I* never said anything about a V7M Linux,
that was your words.  I'm used to the advantages of using MMUs with fork() and mprotect(), etc.


But the updated reason you gave for not allowing V6T2 is
that it's an uncommon architecture (one core, not
widely manufactured today) ... not impossibility.

In short, the basic premise of $PATCH is wrong, as
I pointed out, but there may be other reasons to
merge it, related to V6T2 chip availability not the
actual architecture specs from ARM.

A similar argument would be that making the ASM code
cope with core variants would get ugly/messy.  At
least the GNU assembler is, as I recall, aware of
which instructions which cores support, so it would
provide clean errors if given instructions that are
Thumb2 (some flavor) but not accepted by the target.
But Linux code shouldn't trigger such errors in the
first place, even if they're a good backstop (and
that implies ugly core-driven conditional code.
