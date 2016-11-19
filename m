From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 19 Nov 2016 12:47:02 +0530
Subject: [PATCH] arm: spin one more cycle in timer-based delays
In-Reply-To: <582F0DD2.3030805@free.fr>
References: <582B0F61.6030903@free.fr> <20161118120630.GJ13470@arm.com>
 <20161118125409.GK1041@n2100.armlinux.org.uk>
 <582F0DD2.3030805@free.fr>
Message-ID: <20161119071702.GA25647@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mason,

On Fri, Nov 18, 2016 at 03:18:58PM +0100, Mason wrote:
> On 18/11/2016 13:54, Russell King - ARM Linux wrote:

> > So, NAK on this change.  udelay is not super-accurate.
> 
> usleep_range() fixed this issue recently.
> 6c5e9059692567740a4ee51530dffe51a4b9584d
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=6c5e9059692567740a4ee51530dffe51a4b9584d

But the above "timers: Fix usleep_range() in the context of
wake_up_process()" is to avoid wakeup causing premature return than
about being precise, no ?

With conflicting opinion on delay/sleep fn's from the players, the one
in gallery would get confused.

But Linus has mentioned udelay as not meant to be precise, okay ?

Regards
afzal
