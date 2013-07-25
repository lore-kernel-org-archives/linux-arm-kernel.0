From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 18:48:46 +0100
Subject: [PATCH 4/6] ARM: locks: prefetch the destination word for write
 prior to strex
In-Reply-To: <20130725174555.GK12827@mudshark.cambridge.arm.com>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-5-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1307231609170.15022@syhkavp.arg>
 <20130724111841.GD11072@mudshark.cambridge.arm.com>
 <51F160EA.6030800@codeaurora.org> <51F1626C.3050008@codeaurora.org>
 <20130725174555.GK12827@mudshark.cambridge.arm.com>
Message-ID: <20130725174846.GL12827@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 06:45:55PM +0100, Will Deacon wrote:
> On Thu, Jul 25, 2013 at 06:37:48PM +0100, Stephen Boyd wrote:
> > Oh joy. Why is rwlock's lock member marked volatile?
> 
> Yeah, that was the problematic guy. However, I had to fix that anyway in
> this patch because otherwise the definition for prefetchw when
> !ARCH_HAS_PREFETCHW (which expands to __builtin_prefetch(x,1)) will explode.

Just realised you're still looking at v1, which doesn't have any changes to
the rwlocks. I posted v2 here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186411.html

Enjoy.

Will
