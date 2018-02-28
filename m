From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Feb 2018 14:27:29 +0000
Subject: [PATCH] arm_pmu: Use disable_irq_nosync when disabling SPI in
 CPU teardown hook
In-Reply-To: <CAMuHMdWdua0+wsaMnkqRceOO=C5r23F-8jdnkwuR6kLBpUPb2g@mail.gmail.com>
References: <1519661456-30445-1-git-send-email-will.deacon@arm.com>
 <20180228135704.vuhk5mb6mqgc6jlr@lakrids.cambridge.arm.com>
 <CAMuHMdWdua0+wsaMnkqRceOO=C5r23F-8jdnkwuR6kLBpUPb2g@mail.gmail.com>
Message-ID: <20180228142729.GA11580@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 03:23:28PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 28, 2018 at 2:57 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Feb 26, 2018 at 04:10:56PM +0000, Will Deacon wrote:
> >> Commit 6de3f79112cc ("arm_pmu: explicitly enable/disable SPIs at hotplug")
> >> moved all of the arm_pmu IRQ enable/disable calls to the CPU hotplug hooks,
> >> regardless of whether they are implemented as PPIs or SPIs. This can
> >> lead to us sleeping from atomic context due to disable_irq blocking:
> >
> >> Acked-by: Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> > I think something went wrong here when you applied the tag. ;)
> 
> In case of respinning:
> Fixes: 6de3f79112cc26bf ("arm_pmu: explicitly enable/disable SPIs at hotplug")

This is already pushed to fixes/core, so I'll leave it up to Catalin whether
he wants to rebase it for that.

Will
