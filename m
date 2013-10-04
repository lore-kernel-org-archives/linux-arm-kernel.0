From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Oct 2013 17:26:38 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
In-Reply-To: <1380903802.21562.46.camel@kazak.uk.xensource.com>
References: <1380829403.3804.56.camel@hastur.hellion.org.uk>
 <20131003200712.GG12758@n2100.arm.linux.org.uk>
 <1380870908.27765.24.camel@dagon.hellion.org.uk>
 <20131004160944.GV24303@mudshark.cambridge.arm.com>
 <1380903802.21562.46.camel@kazak.uk.xensource.com>
Message-ID: <20131004162637.GW24303@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 05:23:22PM +0100, Ian Campbell wrote:
> On Fri, 2013-10-04 at 17:09 +0100, Will Deacon wrote:
> > On Fri, Oct 04, 2013 at 08:15:08AM +0100, Ian Campbell wrote:
> > > Should/do we expose the actual CPU LPAE capability somewhere?
> > 
> > That's the whole point of the HWCAP.
> 
> Russell was saying it actually related to the presence of strd/ldrd, how
> tightly is that tied to the presence of LPAE in theory? In practise it
> seems closely related...

Take a gander at the code: we're checking the VMSA version in one of the
MMFR registers. LPAE implies atomic ldrd/strd, so that's what this is all
about (and why it ended up being called "lpae").

In short, this HWCAP does exactly what you want.

Will
