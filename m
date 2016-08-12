From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2016 15:23:25 +0100
Subject: [PATCH] arm: add an option for erratum 657417
In-Reply-To: <6bc288d9-6bea-1ee2-572f-d397221adaff@arm.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk>
 <6bc288d9-6bea-1ee2-572f-d397221adaff@arm.com>
Message-ID: <20160812142325.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 03:17:06PM +0100, Robin Murphy wrote:
> On 12/08/16 13:33, Russell King - ARM Linux wrote:
> > On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
> >> This patch adds an option which defaults to "y" in cases where we
> >> could possibly be running Cortex A8 and using Thumb2 instructions.
> >> In reality the workaround might not be required at all for the kernel
> >> if virtual instruction memory is linear in physical memory.
> > 
> > Hmm.
> > 
> > The main kernel image is guaranteed to be contiguous in physical memory
> > for all sorts of reasons, so this really isn't a concern for the kernel
> > itself.
> 
> I'm not sure being contiguous matters much - looking at the errata doc,
> the implication is that the branch is supposed to use bits 31:12 of the
> address of the first page, but under the erratum conditions ends up
> taking bits 31:12 of the address of the _second_ page instead. There
> doesn't seem to be any importance of where those pages actually are
> relative to each other.

I've not actually looked at the errata document - I need to jump through
all sorts of stupid hoops to get it through the ARM website.  Ever since
I requested a change of my email address, it now wants all sorts of
personal information that I'm refusing to type in again.  I've no idea
why ARM Ltd wiped out all that information just because I asked for my
email address to be changed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
