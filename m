From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Dec 2015 10:17:51 +0000
Subject: [PATCH v12 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <1449708562.24127.39.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>
 <56586679.8060403@arm.com>
 <20151130052843.GG23908@dhcppc13.redhat.com>
 <20151130104027.7eeaa273@why.wild-wind.fr.eu.org>
 <1449097050.6139.80.camel@infradead.org>
 <20151203093212.GC7023@arm.com>
 <1449708562.24127.39.camel@infradead.org>
Message-ID: <20151210101751.GA21134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 04:49:22PM -0800, Geoff Levand wrote:
> On Thu, 2015-12-03 at 09:32 +0000, Will Deacon wrote:
> > On Wed, Dec 02, 2015 at 02:57:30PM -0800, Geoff Levand wrote:
> > > On Mon, 2015-11-30 at 10:40 +0000, Marc Zyngier wrote:
> > > 
> > > > All that can be solved in C, and mostly at compile time. Using an
> > > > assembler trampoline is complicating things for no good reason:
> > > 
> > > I added this into my kexec-v12.1 branch.  After some more testing I'll
> > > post a v13 to the list.
> > 
> > You may well need some notrace annotations if you want to run C code
> > here. Can you give it a spin with things like ftrace and kprobes?
> 
> I tested ftrace with and without the notrace annotation on
> cpu_soft_restart() and could do kexec re-boots either way.
> 
> When cpu_soft_restart() is called we've only done setup_mm_for_reboot(),
> so I would think C code should still be OK.

Yeah, you're right. I mistakenly thought that cpu_soft_restart was running
at the idmap address as opposed to the kernel virtual address.

Will
