From: dan@debian.org (Daniel Jacobowitz)
Date: Wed, 3 Feb 2010 10:19:31 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <4B699010.6010203@parrot.com>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<4B699010.6010203@parrot.com>
Message-ID: <20100203151931.GA1159@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 04:02:40PM +0100, Matthieu CASTET wrote:
> An annoying things about software breakpoints is that gdb doesn't
> understand arm kernel helper (for atomic operation/tls). And when it try
> to set breakpoint here it fails...

This is fixed in current GDB; it knows how to step out of the helper
page automatically.  If you're still seeing a problem with GDB 7.0,
could you file a bug?

On a related note, it would be Very Helpful(TM) if someone would
implement read-only access to the helper page via ptrace!  Not as
helpful as a visible vDSO with symbol names would be, but it would
still make things a lot easier.

-- 
Daniel Jacobowitz
CodeSourcery
