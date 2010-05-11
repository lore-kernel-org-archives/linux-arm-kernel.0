From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 11 May 2010 12:14:47 +0900
Subject: [PATCHv4 1/4] procfs: Introduce socinfo under /proc
In-Reply-To: <20100510125548.GB11804@besouro.research.nokia.com>
References: <1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-3-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-1-git-send-email-eduardo.valentin@nokia.com>
	<1273487857-32281-2-git-send-email-eduardo.valentin@nokia.com>
	<20100510111259.GA14680@linux-sh.org>
	<20100510123514.GA11804@besouro.research.nokia.com>
	<20100510123902.GA15293@linux-sh.org>
	<20100510125548.GB11804@besouro.research.nokia.com>
Message-ID: <20100511031447.GB20453@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 03:55:49PM +0300, Eduardo Valentin wrote:
> On Mon, May 10, 2010 at 02:39:02PM +0200, ext Paul Mundt wrote:
> > Note that in the cpuinfo case there is often special handling for the
> > single (or boot CPU) case, such as printing out a descriptor for the
> > machine type and so on. You might be better off just extending cpuinfo
> > rather than introducing another /proc abstraction, presumably your
> > socinfo string will be fixed regardless of whether it's SMP or not.
> 
> Yeah, I wouldn't expect it to change if it SMP or not. It should be fixed.
> Previous version of this change was actually extending ARM cpuinfo. The previous
> thread starts here:
> http://marc.info/?l=linux-omap&m=127304890312365&w=2
> 
> But, the point of moving that to specific file was that soc info is not really cpu info.
> 
It's up to you of course, but adding an extra file because of SoC/CPU
ambiguity seems pretty ugly. Almost all architectures already include
machine type descriptors in their cpuinfo output (as ARM does also) and
if you can justify that then certainly adding in some SoC-specific bits
isn't exactly much of a stretch.

These days you should have a pretty strong justification for adding new
procfs files, and this is certainly not one of them.
