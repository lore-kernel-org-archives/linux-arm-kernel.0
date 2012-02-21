From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2012 17:30:37 +0000
Subject: ARM tracehook support
In-Reply-To: <20120221172408.GJ23133@mudshark.cambridge.arm.com>
References: <4F4268D5.7070103@mentor.com>
 <20120220154748.GG25462@mudshark.cambridge.arm.com>
 <4F428C39.40906@mentor.com> <4F43CF0C.2020301@mentor.com>
 <20120221172408.GJ23133@mudshark.cambridge.arm.com>
Message-ID: <20120221173037.GB1774@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:24:09PM +0000, Will Deacon wrote:
> Ok, if the low-level code doesn't need to interpret arguments then that
> should be fine. sys_arm_fadvise64_64 would be the tricky case, but the
> argument ordering seems to have been chosen explicitly to place the 64-bit
> offsets naturally on even registers, fitting it neatly into 6 registers.

That was done because the standard argument order was impossible to pass
in the available register set with EABI.  It would have meant having to
move the syscall number into r8 or higher, which would've been rather
unfriendly to Thumb code.
