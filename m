From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 May 2012 09:55:29 +0100
Subject: [PATCH] ARM: Fix restoration of IP scratch register when
 auditing syscalls
In-Reply-To: <20120503030312.GM6871@ZenIV.linux.org.uk>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
 <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
 <20120430100746.GA11080@mudshark.cambridge.arm.com>
 <20120430190015.GV24211@n2100.arm.linux.org.uk>
 <4FA1F499.8000408@jonmasters.org>
 <20120503030312.GM6871@ZenIV.linux.org.uk>
Message-ID: <20120503085528.GA30175@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On Thu, May 03, 2012 at 04:03:12AM +0100, Al Viro wrote:
> How about splitting the damn thing into syscall_trace_enter() and
> syscall_trace_exit(), losing the "why" argument along with all possible
> confusion as to which audit hook to call?

That could certainly pan out to be slightly cleaner but I'd rather approach
it separately given that this stuff should go into the -stable trees and the
current fix is nicely self-contained.

I'll post some follow up patches.

Cheers,

Will
