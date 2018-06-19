From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 12:19:48 +0100
Subject: [PATCHv3 01/19] arm64: consistently use unsigned long for thread
 flags
In-Reply-To: <20180619104939.likbams3ly5c5ugu@armageddon.cambridge.arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-2-mark.rutland@arm.com>
 <20180619104939.likbams3ly5c5ugu@armageddon.cambridge.arm.com>
Message-ID: <20180619111948.mqrhpd43d7fidmuh@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 11:49:40AM +0100, Catalin Marinas wrote:
> On Mon, Jun 18, 2018 at 01:02:52PM +0100, Mark Rutland wrote:
> > In do_notify_resume, we manipulate thread_flags as a 32-bit unsigned
> > int, whereas thread_info::flags is a 64-bit unsigned long, and elsewhere
> > (e.g. in the entry assembly) we manipulate the flags as a 64-bit
> > quantity.
> > 
> > For consistency, and to avoid problems if we end up with more than 32
> > flags, let's make do_notify_resume take the flags as a 64-bit unsigned
> > long.
> 
> When we get to more than 32 flags, you may want to modify the _TIF_*
> definitions as well to (UL(1) << TIF_*).

Agreed. I can spin a patch or two for a that as a subsequent cleanup.

> In the meantime:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers!

Mark.
