From: rabin@rab.in (Rabin Vincent)
Date: Mon, 31 Oct 2011 20:14:14 +0530
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031143904.GM19187@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<CAH+eYFDM_spE8jg4K5awBPZvPyEmdhSnQ9Zt=v2U4PmFQeRLOw@mail.gmail.com>
	<20111031143904.GM19187@n2100.arm.linux.org.uk>
Message-ID: <CAH+eYFD_XPgbvp828q7508TOPNdP4TK7wiej2aBhPb18WbQ+Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 20:09, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Oct 31, 2011 at 08:03:26PM +0530, Rabin Vincent wrote:
>> The above patch will apply with gnu patch if you use -p0.
>
> $ patch -p0 -i arch_reset-1.diff --dry-run
> patch: **** rejecting absolute target file name: /tmp/cocci-output-380-f841cc-system.h

Works for me, maybe a version difference?

~/kernel/arm$ cat arch_reset-1.diff  | head
--- arch/arm/mach-ep93xx/include/mach/system.h	2011-10-31
20:11:04.496237799 +0530
+++ /tmp/cocci-output-3559-9e5748-system.h	2011-10-31 20:12:08.120235486 +0530
@@ -11,8 +11,6 @@ static inline void arch_idle(void)

 static inline void arch_reset(char mode, const char *cmd)
 {
-	local_irq_disable();
-
 	/*
 	 * Set then clear the SWRST bit to initiate a software reset
~/kernel/arm$ patch -p0 -i arch_reset-1.diff --dry-run
patching file arch/arm/mach-ep93xx/include/mach/system.h
patching file arch/arm/mach-iop32x/include/mach/system.h
patching file arch/arm/mach-ixp2000/include/mach/system.h
~/kernel/arm$ patch --version
patch 2.6.1
Copyright (C) 1988 Larry Wall
Copyright (C) 2003, 2009 Free Software Foundation, Inc.

This program comes with NO WARRANTY, to the extent permitted by law.
You may redistribute copies of this program
under the terms of the GNU General Public License.
For more information about these matters, see the file named COPYING.

written by Larry Wall and Paul Eggert
~/kernel/arm$
