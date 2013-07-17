From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 18 Jul 2013 00:47:29 +0200
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <alpine.LFD.2.03.1307171758591.14924@syhkavp.arg>
References: <1374052705.3146.86.camel@hornet>
 <alpine.LFD.2.03.1307170825240.14924@syhkavp.arg>
 <1374067786.3146.123.camel@hornet>
 <alpine.LFD.2.03.1307171014510.14924@syhkavp.arg>
 <1374070811.3146.124.camel@hornet>
 <alpine.LFD.2.03.1307171148160.14924@syhkavp.arg>
 <20130717170038.GP24642@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1307171416490.14924@syhkavp.arg>
 <20130717212343.GC19864@zurbaran>
 <alpine.LFD.2.03.1307171758591.14924@syhkavp.arg>
Message-ID: <20130717224729.GA20652@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 06:22:46PM -0400, Nicolas Pitre wrote:
> On Wed, 17 Jul 2013, Samuel Ortiz wrote:
> 
> > On Wed, Jul 17, 2013 at 02:29:02PM -0400, Nicolas Pitre wrote:
> > > At this point I don't really care about the name.  I just want the damn 
> > > thing merged upstream.  But after several iterations to either fit one 
> > > or another maintainers taste, each rework ends up in that maintainer 
> > > saying: "Now that you've reworked the code, I still don't like it since 
> > > this no longer fits in my subsystem tree."
> > FWIW, we asked Pawel to rework the sysreg and config parts of the
> > vexpress driver, make it an actual MFD driver, and spread the remaining
> > bits of the code into their respective subsystems. I don't think
> > this is an eccentric requirement.
> 
> I agree.  However the code that Lorenzo just posted can't be deprived 
> of any more sysreg/config parts.  
Yes, and I appreciate Lorenzo's effort here.


> Even the larger code you reviewed before is completely useless without 
> _additional_ drivers to go on top which are indeed waiting after this 
> code to be merged before they are submitted to their respective 
> subsystems.
Right. And merging this code in the right place is exactly what we're
doing here.

 
> And those additional drivers are way more interesting than this dumb 
> register access arbitrator.  
Yes, they're a lot smarter hence the requirement to have them live into
their respective subsystems where the right maintainer can provide
relevant reviews on them.

> > I don't mind merging Lorenzo's SPC driver as it is if he can explain to
> > me how it will eventually evolve into an actual MFD driver. If that's
> > not the case, I don't see how I could justify merging it through the
> > MFD tree.
> 
> Maybe the misunderstanding is about what actually is a MFD driver.
That's possible. I agree it should be documented properly.

> So I'll follow existing precedents in the kernel and move Lorenzo's code 
> to drivers/platform/vexpress/.
Thanks for that.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
