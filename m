From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jun 2011 10:00:04 +0100
Subject: [PATCH 1/1] Add Thread Support for the Context ID Register of
	ARM v6 & v7 Architectures
In-Reply-To: <20110627113707.GD16103@n2100.arm.linux.org.uk>
References: <cover.1309163073.git.wolfgang.betz@st.com>
	<3a6d2636489958d097cd013cad646fed012421dd.1309163073.git.wolfgang.betz@st.com>
	<20110627113707.GD16103@n2100.arm.linux.org.uk>
Message-ID: <20110628090004.GA16009@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jun 27, 2011 at 12:37:08PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 27, 2011 at 01:12:27PM +0200, Wolfgang BETZ wrote:
> > The aim of this patch is to enable thread support in the context ID register
> > (CONTEXTIDR) as it comes with ARM architectures v6 & v7.
> > 
> >  On ARMv6 & v7, we have the following structure in the context ID:
> > 
> >    31                         7          0
> >    +-------------------------+-----------+
> >    |      process ID         |   ASID    |
> >    +-------------------------+-----------+
> >    |              context ID             |
> >    +-------------------------------------+
> > 
> > - The ASID is used to tag entries in the CPU caches and TLBs.
> > - The context ID is used by debuggers and trace logic, and
> >   should be unique within all running processes.
> 
> When I added ARMv6 and v7 support to the kernel, I purposely ignored that
> detail because it's silly.

[...]

> How are you working around this issue?

I don't know how you could get around this with current implementations, but
for Cortex-A15 w/ LPAE the ASID lives in the TTBR rather than the context
ID register, so using the PID is straightforward in that case.

Will
