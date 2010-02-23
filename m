From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 19:09:30 +0000
Subject: [RFC PATCH 05/12] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1266952018.24069.21.camel@c-dwalke-linux.qualcomm.com>
References: <1264719577-5436-6-git-send-email-dwalker@codeaurora.org>
	<1264763482.4242.50.camel@pc1117.cambridge.arm.com>
	<1266950168.24069.1.camel@c-dwalke-linux.qualcomm.com>
	<20100223190254.GB26434@n2100.arm.linux.org.uk>
	<1266952018.24069.21.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100223190930.GC26434@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 11:06:58AM -0800, Daniel Walker wrote:
> On Tue, 2010-02-23 at 19:02 +0000, Russell King - ARM Linux wrote:
> 
> > > > Can you not use hook_fault_code() and move the do_imprecise_ext() to a
> > > > platform-specific file (under arch/arm/mach-* maybe)?
> > > > 
> > > 
> > > How do you mean? I'm not sure how we would move this into
> > > arch/arm/mach- ..
> > 
> > Err, exactly as Catalin says.  Use hook_fault_code() to hook into the
> > fault table at run time, just like platforms which have to handle
> > imprecise exceptions on PCI and the alignment fault handler do.
> 
> 
> "Can you not use hook_fault_code()"
> 
> Typo maybe ?

I don't think so.  It's a request for you to use hook_fault_code().
