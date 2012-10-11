From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Oct 2012 14:59:26 +0100
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <5076CA43.9070503@gmail.com>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121011130955.GP4625@n2100.arm.linux.org.uk> <5076CA43.9070503@gmail.com>
Message-ID: <20121011135925.GR4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 08:31:47AM -0500, Rob Herring wrote:
> This only affects v7 cores. It should not vary for v7 cores as unaligned
> access is a required feature. So how is it going to vary on v7 CPUs?
> We've got bigger problems if there are v7 cores that don't handle
> unaligned accesses.

Oh, and this gives me a third reason to NAK this patch.  Why only ensure
that the A bit is clear for v7 CPUs?  Why not v6, v5, v4 too?  Why does
ARMv7 get this special treatment?

Any argument you can make for clearing the bit on ARMv7 also applies to
the other architectures too, but not even that negates my point (2) which
is far more fundamental.
