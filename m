From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jul 2015 13:41:29 +0200
Subject: Possible regression due to "tick: broadcast: Prevent livelock
 from event handler"
In-Reply-To: <20150703111358.GW7557@n2100.arm.linux.org.uk>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <20150703110249.GV7557@n2100.arm.linux.org.uk>
 <20150703110730.GG1521@katana>
 <20150703111358.GW7557@n2100.arm.linux.org.uk>
Message-ID: <20150703114129.GA10368@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 12:13:58PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 03, 2015 at 01:07:31PM +0200, Wolfram Sang wrote:
> > > Please share your .config file for this case.  Thanks.
> > 
> > Here it goes...
> 
> Please try:
> 
> sed -i s/IRQSOFF_TRACER/TRACE_IRQFLAGS/ arch/arm/kernel/entry-armv.S

Yes, this fixes the lockdep issue with HRTIMERS.

For completeness, it does not fix the freeze without HRTIMERS.

Thanks Russell!

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150703/1b52aad7/attachment.sig>
