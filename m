From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Aug 2018 09:20:00 -0700
Subject: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <CA+55aFxNs5B=j_g_OpAd=Xp_iiO_+idT-ogd_WM2EcL_6brbqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
>
> I hacked up this RFC on the back of the recent changes to the mmu_gather
> stuff in mainline. It's had a bit of testing and it looks pretty good so
> far.

Looks good to me.

Apart from the arm64-specific question I had, I wonder whether we need
to have that single "freed_tables" bit at all, since you wanted to
have the four individual bits for the different levels.

Even if somebody doesn't care about the individual bits, it's
generally exactly as cheap to test four bits as it is to test one, so
it seems unnecessary to have that summary bit.

             Linus
