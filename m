From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Oct 2012 20:24:49 +0300
Subject: [PATCH] arm: sched: stop sched_clock() during suspend
In-Reply-To: <20121023160331.GF28061@n2100.arm.linux.org.uk>
References: <1350906877-19410-1-git-send-email-balbi@ti.com>
 <873916h1yi.fsf@deeprootsystems.com>
 <CACRpkdY6ox+iJAGdSD=e7Yj55TzDWqOmLqu2fSRXvKJxqwfkhQ@mail.gmail.com>
 <20121023092231.GE28061@n2100.arm.linux.org.uk>
 <87a9vdclxe.fsf@deeprootsystems.com>
 <20121023160331.GF28061@n2100.arm.linux.org.uk>
Message-ID: <20121023172449.GA32517@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 23, 2012 at 05:03:31PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 07:17:33AM -0700, Kevin Hilman wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > No, printk() does not need this.  You think it does, but it doesn't.  What
> > > we have is a difference between ARM and x86, and this difference is breaking
> > > the scheduler.
> > >
> > > The fact that the printk timestamp increments while suspended is a bug.  It
> > > doesn't on x86.
> > 
> > Russell, I agree that it's a bug, but does it qualify as a something
> > you're willing to take for v3.7-rc?
> 
> Definitely.  Our current behaviour across suspend for the scheduler is
> wrong.  This is one of the questions I had when I created the sched_clock
> stuff - but no one at the time could answer.  So, now that we have our
> answer, let's get it fixed to conform.

I have just pushed the patch the your patch system, hope I did it all
right.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/827d4ccb/attachment-0001.sig>
