From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jun 2017 19:16:03 +0100
Subject: [PATCH 2/2] arm64: Export save_stack_trace_tsk()
In-Reply-To: <20170613174406.GH9184@arm.com>
References: <20170613085029.GA5374@arm.com>
 <20170613173308.6653-1-dustinb@codeaurora.org>
 <20170613173308.6653-2-dustinb@codeaurora.org>
 <20170613174406.GH9184@arm.com>
Message-ID: <20170613181603.GE4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 06:44:06PM +0100, Will Deacon wrote:
> On Tue, Jun 13, 2017 at 10:33:08AM -0700, Dustin Brown wrote:
> > To aid in debugging driver modules, export save_stack_trace_tsk() for
> > the ARM64 architecture.
> > ---
> >  arch/arm64/kernel/stacktrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Please can you repost with your Signed-off-by line added to the patch? I
> can't merge anything from you without that.

I think it would also be a good thing to have a little more information
about how this is being used in driver modules.

If it's for ad-hoc debugging, then I see no reason for it to be merged
into mainline kernels just for the utility of people adding code to
drivers to perform that debug - they might as well temporarily add the
export at the same time IMHO.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
