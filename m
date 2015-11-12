From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 14:24:57 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <mvmk2pny2js.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <4796230.MStNPjWNEu@wuerfel> <mvmk2pny2js.fsf@hawking.suse.de>
Message-ID: <16446627.b0Lo936ZJj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 10:44:55 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > What do you mean with 32-bit off_t?
> 
> An ABI with 32-bit off_t, ie. all currently implemented 32-bit ABIs.
> 
> > Do you mean that glibc emulates a 32-bit off_t on top of the 64-bit
> > __kernel_loff_t?
> 
> Glibc is bridging the user-space ABI to the kernel ABI.

Ok, but why?

The kernel headers for all recent architectures (arc, c6x, h8300,
hexagon, metag, nios2, openrisc, tile and unicore32) deliberately
leave out the __kernel_off_t based system calls to simplify the
ABI in a way that we never have to support a 32-bit off_t
in user space.

Are there programs that require using a 32-bit off_t by default
on 32-bit architectures but not on 64-bit architectures?
Did the previous version of the ilp32 patch set also emulate
this the same way?

	Arnd
