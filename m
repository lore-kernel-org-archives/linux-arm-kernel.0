From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 22:35:03 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111215816.GA1068@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
Message-ID: <20100111223503.GD7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 04:58:16PM -0500, Daniel Jacobowitz wrote:
> The problem I'm solving is that of stepping through IT blocks.  We
> shouldn't use the BKPT instruction, which would interfere with an
> attached hardware debugger.  The undefined instruction pattern
> currently used as a breakpoint will not trigger an exception if the IT
> block flags prevent its execution.  And without adding most of a
> Thumb-2 simulator to GDB, we can't statically predict what the
> next instruction will do to the CPSR flags, so we don't know which
> of the following instructions in the IT block will be executed.

Can't you read the CPSR in gdb, and look at the IT state bits?  See
A2.5.2 and CPSR register format in the ARM ARM.
