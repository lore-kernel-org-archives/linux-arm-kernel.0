From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 07:48:30 -0800
Subject: [GIT PULL] kill plat-nomadik and convert Nomadik+Ux500 to
 SPARSE_IRQ
In-Reply-To: <CACRpkdY9ppMQ5UG5WRCJQSbme82HJACF8pz9v4SVbC6_CUt+2g@mail.gmail.com>
References: <CACRpkdY9ppMQ5UG5WRCJQSbme82HJACF8pz9v4SVbC6_CUt+2g@mail.gmail.com>
Message-ID: <20121106154830.GF30580@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 10:25:41AM +0100, Linus Walleij wrote:
> Hi ARM SoC maintainers,
> 
> this pull request will move all headers away from plat-nomadik, move the
> timer driver to drivers/clocksource, delete plat-nomadik and then convert
> Nomadik and Ux500 to SPARSE_IRQ. I consider this a big piece of
> cleanup that we need to move ahead with single zImage.
> 
> As discussed with Arnd in Copenhagen here is a pull request including a few
> patches that are for obvious reasons also in the pinctrl tree. We will have
> to fix this up in the merge window as the end result is the removal of the
> plat-nomadik directory which means there will be massive collissions if we
> try to pretend the changes are orthogonal.
> 
> The patches have all been circulated to relevant subsystem maintainers,
> but I have not recieved an ACK from Samuel Ortiz, Mike Turquette yet,
> nor from the clocksource maintainer.
> 
> However they have had time to review the patches and they're basically
> only changing #include <> statements and so I think we should move ahead
> with this anyway. I'm a bit uncertain about the clocksource though, it should
> be straight-forward.
> 
> Waiting for weeks for ACKs before being able to merge to ARM SoC
> will delay any linux-next testing which slows down everything :-(
> 
> Signed tag per below.
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:
> 
>   Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> tags/kill-plat-sparse-irq
> 
> for you to fetch changes up to c3b9d1db23c4ebd4d8a0964ebcf5f27d4eb8fa3f:
> 
>   ARM: plat-nomadik: convert platforms to SPARSE_IRQ (2012-11-05 09:55:34 +0100)


I pulled this into next/multiplatform. Could have gone in next/cleanup I guess,
but the lines are blurring a bit since this is partially staging for
multiplatform enablement.


Thanks,

-Olof
