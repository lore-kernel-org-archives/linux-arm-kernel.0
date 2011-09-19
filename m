From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 19:25:44 +0100
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <CAPnjgZ1JDGt7Dzp9VrRKKApeZ9RT9oqry+UkQZwVCw1P+t9pew@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<CAH+eYFBSiL44CMOpgED+TAOTUH_dQMaKKu=hC3ynG0Y2nQ8ekw@mail.gmail.com>
	<CAB-zwWi1K8y8fHzy0hgcFPgSfhMrZNfoKQ9xuU00Y1sLg6ZBmw@mail.gmail.com>
	<20110919144313.GU16381@n2100.arm.linux.org.uk>
	<20110919165943.GX16381@n2100.arm.linux.org.uk>
	<CAPnjgZ1JDGt7Dzp9VrRKKApeZ9RT9oqry+UkQZwVCw1P+t9pew@mail.gmail.com>
Message-ID: <20110919182544.GY16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 11:02:08AM -0700, Simon Glass wrote:
> Hi Russell,
> 
> On Mon, Sep 19, 2011 at 9:59 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Sep 19, 2011 at 03:43:13PM +0100, Russell King - ARM Linux wrote:
> >> On Mon, Sep 19, 2011 at 09:26:49AM -0500, Ramirez Luna, Omar wrote:
> >> > Hi
> >> >
> >> > On Sat, Sep 17, 2011 at 1:07 AM, Rabin Vincent <rabin@rab.in> wrote:
> >> > > If the "Use generic BUG() handler" patch is only scheduled for the next
> >> > > merge window and not for 3.1, can this patch be merged instead for 3.1
> >> > > and -stable? ?This problem is easily seen with GCC 4.6.
> >> >
> >> > I can send it for both and let the maintainers decide.
> >> >
> >> > Russell, do you give your ack?
> >>
> >> I think it's too large a change for -stable and 3.1 - let's get it into
> >> 3.2 first, and make sure no one sees any regressions there. ?Then we can
> >> think about submitting it to stable once its proven itself.
> >
> > And we're seeing link failures with the patch in the kernel, so it's
> > *definitely* not stable material as it stands, even if the current code
> > is a problem for GCC 4.6.
> >
> > Regressions trump bug fixes.
> 
> Can you point me to the link failures please?

There's two emails during the last couple of months on lakml:

	3.1-rc1 link failure

	Link failures due to __bug_table in current -next

The former I looked into and came to the conclusion that the only way to
solve it is to stop using asm-generic/vmlinux.lds.S in its entirety and
go back to hand-coding ARMs vmlinux.lds file.  No one's come forward
with any better suggestion to fix this, so I'm getting very close to
having to make a decision over this.  I think I'm going to have to drop
the generic bug support for the time being.
