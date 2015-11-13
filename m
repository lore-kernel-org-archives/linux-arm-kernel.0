From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 16:34:10 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <mvm4mgrxrbt.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <16446627.b0Lo936ZJj@wuerfel> <mvm4mgrxrbt.fsf@hawking.suse.de>
Message-ID: <3810107.ZiMyX4Iloo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 14:47:18 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Thursday 12 November 2015 10:44:55 Andreas Schwab wrote:
> >> Arnd Bergmann <arnd@arndb.de> writes:
> >> 
> >> > What do you mean with 32-bit off_t?
> >> 
> >> An ABI with 32-bit off_t, ie. all currently implemented 32-bit ABIs.
> >> 
> >> > Do you mean that glibc emulates a 32-bit off_t on top of the 64-bit
> >> > __kernel_loff_t?
> >> 
> >> Glibc is bridging the user-space ABI to the kernel ABI.
> >
> > Ok, but why?
> 
> That's how the ABI is defined right now.  I didn't make that up.

Ok, I guess it will remain a mystery then.

Should we perhaps define __ARCH_WANT_SYSCALL_OFF_T for the unistd.h
file then, so we provide both the off_t and the loff_t based syscalls?

That would avoid the extra wrapper in glibc when using a 32-bit
off_t if that is the preferred mode for user space.

	Arnd
