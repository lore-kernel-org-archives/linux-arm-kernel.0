From: horms@verge.net.au (Simon Horman)
Date: Sat, 17 May 2014 10:28:28 +0900
Subject: [PATCH 0/5] remove Genmai Reference from Legacy support
In-Reply-To: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
References: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140517012828.GA25731@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 02:10:11PM +0200, Wolfram Sang wrote:
> Here is the series to remove Genmai Reference from Legacy support since we now
> have CCF in multiplatform. Removal is done very similar to Marzen and the
> commit messages are largely from that series. Thanks a lot!
> 
> Technically, only the first patch fixes the unbootable Genmai-Reference-with-
> Legacy-constellation. The other patches clean up the leftovers. Simon, I think
> you know best when to push which patches?

Thanks. I appreciate the way you have arranged the series.

I have decided to take all of the patches and expedited a pull-request
(without the usual cooling off period in next, so if it blows up we will
have some egg on our faces :^).

> 
> The series has been tested with/without multiplatform on a genmai board. The
> branch is based on my r7s-ccf branch and can also be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf-with-fixup
> 
> Thanks,
> 
>    Wolfram
> 
> Wolfram Sang (5):
>   ARM: shmobile: Remove non-multiplatform Genmai reference support
>   ARM: shmobile: genmai-reference: Remove legacy clock support
>   ARM: shmobile: Sync Genmai DTS with Genmai reference DTS
>   ARM: shmobile: Let Genmai multiplatform boot with Genmai DTB
>   ARM: shmobile: Remove Genmai reference DTS
> 
>  arch/arm/boot/dts/Makefile                      |  3 +-
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts | 59 -------------------------
>  arch/arm/boot/dts/r7s72100-genmai.dts           | 30 ++++++++++++-
>  arch/arm/mach-shmobile/Kconfig                  | 11 -----
>  arch/arm/mach-shmobile/Makefile                 |  1 -
>  arch/arm/mach-shmobile/Makefile.boot            |  1 -
>  arch/arm/mach-shmobile/board-genmai-reference.c |  8 +---
>  7 files changed, 31 insertions(+), 82 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/r7s72100-genmai-reference.dts
> 
> -- 
> 1.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
