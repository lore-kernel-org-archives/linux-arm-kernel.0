From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2012 17:03:31 +0100
Subject: [PATCH] arm: sched: stop sched_clock() during suspend
In-Reply-To: <87a9vdclxe.fsf@deeprootsystems.com>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
 <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
 <20121023092231.GE28061@n2100.arm.linux.org.uk>
 <87a9vdclxe.fsf@deeprootsystems.com>
Message-ID: <20121023160331.GF28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 07:17:33AM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > No, printk() does not need this.  You think it does, but it doesn't.  What
> > we have is a difference between ARM and x86, and this difference is breaking
> > the scheduler.
> >
> > The fact that the printk timestamp increments while suspended is a bug.  It
> > doesn't on x86.
> 
> Russell, I agree that it's a bug, but does it qualify as a something
> you're willing to take for v3.7-rc?

Definitely.  Our current behaviour across suspend for the scheduler is
wrong.  This is one of the questions I had when I created the sched_clock
stuff - but no one at the time could answer.  So, now that we have our
answer, let's get it fixed to conform.
