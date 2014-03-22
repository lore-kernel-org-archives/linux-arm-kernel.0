From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sat, 22 Mar 2014 14:31:21 -0700
Subject: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
In-Reply-To: <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <1395523881.2143.58.camel@dabdike.int.hansenpartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2014-03-22 at 11:13 -0700, Laura Abbott wrote:
> Rather than have architectures #define ARCH_HAS_SG_CHAIN in an architecture
> specific scatterlist.h, make it a proper Kconfig option and use that
> instead. At same time, remove the header files are are now mostly
> useless and just include asm-generic/scatterlist.h.

Well, the transformation looks fine.  Perhaps part of the reason for the
lack of response is that there's no compelling reason in the change log
above for doing this.  The usual reason for eliminating ARCH_HAS is that
it's hiding something that would be better expressed a different way
(that's actually intuitive to grep) or that it's expressing something
that should be configurable.  Neither of these reasons apply in this
case, because SG_CHAIN definitely is a property of the architecture not
the config space and it's not really hiding anything.

Perhaps now might be the time to ask which are the remaining
architectures that cannot do SG chaining and then we can fix them and
pull the whole thing out.

James
