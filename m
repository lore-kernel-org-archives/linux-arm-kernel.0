From: dan@debian.org (Daniel Jacobowitz)
Date: Wed, 3 Feb 2010 12:45:32 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203163522.GA29306@n2100.arm.linux.org.uk>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<4B699010.6010203@parrot.com>
	<20100203151931.GA1159@caradoc.them.org>
	<20100203153025.GA29749@n2100.arm.linux.org.uk>
	<20100203153501.GA1944@caradoc.them.org>
	<20100203163522.GA29306@n2100.arm.linux.org.uk>
Message-ID: <20100203174532.GB10898@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 04:35:22PM +0000, Russell King - ARM Linux wrote:
> Well, we could siphon off the PEEK calls, and special case them at
> the arch layer - it'll basically be the same hack as what you're
> suggesting, only in the kernel instead.
> 
> So really the question is whether we want a hack for this in the
> kernel or in userspace.

Agreed.  In my opinion, this is a useful thing to have in the kernel,
in order to keep the existing PTRACE_PEEKTEXT API more consistent
between architectures.  Arguments in the other direction?

-- 
Daniel Jacobowitz
CodeSourcery
