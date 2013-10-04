From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 04 Oct 2013 17:34:06 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
In-Reply-To: <20131004162637.GW24303@mudshark.cambridge.arm.com>
References: <1380829403.3804.56.camel@hastur.hellion.org.uk>
 <20131003200712.GG12758@n2100.arm.linux.org.uk>
 <1380870908.27765.24.camel@dagon.hellion.org.uk>
 <20131004160944.GV24303@mudshark.cambridge.arm.com>
 <1380903802.21562.46.camel@kazak.uk.xensource.com>
 <20131004162637.GW24303@mudshark.cambridge.arm.com>
Message-ID: <1380904446.21562.50.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-10-04 at 17:26 +0100, Will Deacon wrote:
> On Fri, Oct 04, 2013 at 05:23:22PM +0100, Ian Campbell wrote:
> > On Fri, 2013-10-04 at 17:09 +0100, Will Deacon wrote:
> > > On Fri, Oct 04, 2013 at 08:15:08AM +0100, Ian Campbell wrote:
> > > > Should/do we expose the actual CPU LPAE capability somewhere?
> > > 
> > > That's the whole point of the HWCAP.
> > 
> > Russell was saying it actually related to the presence of strd/ldrd, how
> > tightly is that tied to the presence of LPAE in theory? In practise it
> > seems closely related...
> 
> Take a gander at the code: we're checking the VMSA version in one of the
> MMFR registers. LPAE implies atomic ldrd/strd, so that's what this is all
> about (and why it ended up being called "lpae").

Yes, I see what you mean (check for VMSA >= 5, which is "adds support
for the Long-descriptor translation table format").

You can determine the presence of ldrd/strd from this but that's a bit
of a red herring in the context. I thought Russell was saying the kernel
was checking for a ldrd/strd bit in some feature register and inferring
the lpae flag in /proc/cpuinfo from that, which was why I was concerned.

> In short, this HWCAP does exactly what you want.

Agreed, thanks.

Ian
