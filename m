From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Mar 2011 14:44:59 -0400 (EDT)
Subject: [PATCH] Fix ldrd/strd emulation for kprobes/ARM
In-Reply-To: <20110329183151.GA18135@n2100.arm.linux.org.uk>
References: <1301087944.2744.85.camel@computer2.home>
	<1301327765-6996-1-git-send-email-viktor.rosendahl@nokia.com>
	<alpine.LFD.2.00.1103281822170.11889@xanadu.home>
	<4D91C1EF.1040102@nokia.com>
	<alpine.LFD.2.00.1103291235380.11889@xanadu.home>
	<20110329183151.GA18135@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1103291441160.11889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Mar 2011, Russell King - ARM Linux wrote:

> On Tue, Mar 29, 2011 at 12:55:27PM -0400, Nicolas Pitre wrote:
> > Sorry, I meant r15-indexed with a write back.
> 
> I believe that's unpredictable.  So actually you can make kprobes do
> anything you like with it - no one should ever generate an instruction
> which read-modify-writes the PC.

Indeed.  Hence my suggestion to simply refuse and abort the placement of 
a probe on such instructions and keep the actual emulation code free of 
tests for those odd cases.  In practice this shouldn't affect anyone.


Nicolas
