From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2009 08:51:37 +0000
Subject: [PATCH] Use definition for cmpxchg swi
In-Reply-To: <alpine.LFD.2.00.0911082033580.16711@xanadu.home>
References: <20091108200459.GA32760@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911082033580.16711@xanadu.home>
Message-ID: <20091109085137.GA14453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 08, 2009 at 08:42:51PM -0500, Nicolas Pitre wrote:
> On Sun, 8 Nov 2009, Russell King - ARM Linux wrote:
> 
> > Use a definition for the cmpxchg SWI instead of hard-coding the number.
> 
> Well...  Initially I didn't use a definition in unistd.h because I 
> didn't want user space to "see" it and assume this was part of the 
> kernel ABI since this is actually just an implementation detail that 
> depends on a particular kernel configuration.

The ifdef __KERNEL__ is sufficient for that - kernel headers are now
stripped of code within these defines during 'make installheaders'.
