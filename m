From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Jun 2012 10:54:49 +0100
Subject: [RFC/PATCH v5 5/7] ARM: ARM11 MPCore: cpu_v6_dcache_clean_area
 needs RFO
In-Reply-To: <20120613094528.GB31722@n2100.arm.linux.org.uk>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-6-git-send-email-gdavis@mvista.com>
 <20120613093218.GC29492@arm.com>
 <20120613093634.GA31722@n2100.arm.linux.org.uk>
 <20120613094127.GE29492@arm.com>
 <20120613094528.GB31722@n2100.arm.linux.org.uk>
Message-ID: <20120613095449.GG29492@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 10:45:28AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 13, 2012 at 10:41:27AM +0100, Catalin Marinas wrote:
> > On Wed, Jun 13, 2012 at 10:36:34AM +0100, Russell King - ARM Linux wrote:
> > > On Wed, Jun 13, 2012 at 10:32:18AM +0100, Catalin Marinas wrote:
> > > > Alternatively, we could disable the interrupts around RFO and D-cache
> > > > cleaning (inside the loop), though I think the preempt disabling is
> > > > faster.
> > > 
> > > It also has the *important* effect that it doesn't cause problems with
> > > interrupt latency, which is a real concern if you have peripherals
> > > requiring quick servicing.
> > 
> > I was suggesting just disabling the interrupts inside the loop around
> > RFO and D-cache cleaning, so only for a single cache line (and not the
> > whole range) which would not introduce noticeable interrupt latency.
> 
> But would slow down the loop, probably significantly.

Yes, indeed.

-- 
Catalin
