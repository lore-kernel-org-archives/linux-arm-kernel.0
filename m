From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Jul 2014 12:13:30 +0100
Subject: HYP panic with 3.16-rc5, arm64 + 64k pages
In-Reply-To: <20140718084030.GA9548@arm.com>
References: <20140717152808.GO21153@arm.com> <53C8086E.5060903@amd.com>
 <20140718084030.GA9548@arm.com>
Message-ID: <20140718111330.GC1818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 09:40:30AM +0100, Will Deacon wrote:
> On Thu, Jul 17, 2014 at 06:31:26PM +0100, Joel Schopp wrote:
> > Not a lot to go on there.  If you get desperate you can configure FTRACE
> > and pass "ftrace=function ftrace_dump_on_oops" as additional additional
> > kernel command line arguments.  If you get really desperate you can do
> > the same on the host.  Just beware the output is really long.
> 
> Cheers for the replies. It could be that I'm tickling something with kvmtool
> that qemu doesn't do, so I'll add some traces and try to figure out some more
> information later on today.

FWIW I just reproduced this issue but, this time, I didn't see a HYP panic.
The guest stopped at exactly the same point, but I then see a screaming
timer interrupt on the host. The weird part is that the screaming interrupt
is a PPI on physical CPU0, whilst the vcpus are affined to cores 4 and 5
(it's a Juno, so I've pinned the guest to the big cores).

I'll keep digging...

Will
