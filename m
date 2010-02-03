From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 15:30:25 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203151931.GA1159@caradoc.them.org>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<4B699010.6010203@parrot.com>
	<20100203151931.GA1159@caradoc.them.org>
Message-ID: <20100203153025.GA29749@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 10:19:31AM -0500, Daniel Jacobowitz wrote:
> On a related note, it would be Very Helpful(TM) if someone would
> implement read-only access to the helper page via ptrace!  Not as
> helpful as a visible vDSO with symbol names would be, but it would
> still make things a lot easier.

Apart from the TLS value which can be obtained by PTRACE_GET_THREAD_AREA,
the contents of the page is constant across all processes on all CPUs.
