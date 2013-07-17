From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 17 Jul 2013 23:23:43 +0200
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <alpine.LFD.2.03.1307171416490.14924@syhkavp.arg>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374052705.3146.86.camel@hornet>
 <alpine.LFD.2.03.1307170825240.14924@syhkavp.arg>
 <1374067786.3146.123.camel@hornet>
 <alpine.LFD.2.03.1307171014510.14924@syhkavp.arg>
 <1374070811.3146.124.camel@hornet>
 <alpine.LFD.2.03.1307171148160.14924@syhkavp.arg>
 <20130717170038.GP24642@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1307171416490.14924@syhkavp.arg>
Message-ID: <20130717212343.GC19864@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Jul 17, 2013 at 02:29:02PM -0400, Nicolas Pitre wrote:
> On Wed, 17 Jul 2013, Russell King - ARM Linux wrote:
> 
> > On Wed, Jul 17, 2013 at 11:57:55AM -0400, Nicolas Pitre wrote:
> > > The sanest location at this point might simply be 
> > > drivers/platform/vexpress_spc.c or drivers/platform/vexpress/spc.c 
> > > depending on whether or not more such driver glue is expected in the 
> > > vexpress future.  No point putting "arm" in the path, especially if this 
> > > is later reused on arm64.
> > 
> > You wouldn't be making that argument if it were arch/arm64 and arch/arm32 -
> > you'd probably be arguing that "arm" made perfect sense.
> 
> Well... in a sense: yes.  But in the end, having per arch directories 
> under drivers/ is silly.  We already have per arch directories under 
> arch/already.
> 
> > Don't get too hung up on names please, it's really not worth the time
> > and effort being soo pedantic, and being soo pedantic leads to "pointless
> > churn" when someone comes along and wants to pedantically change the
> > names because it no longer matches the users.
> 
> At this point I don't really care about the name.  I just want the damn 
> thing merged upstream.  But after several iterations to either fit one 
> or another maintainers taste, each rework ends up in that maintainer 
> saying: "Now that you've reworked the code, I still don't like it since 
> this no longer fits in my subsystem tree."
FWIW, we asked Pawel to rework the sysreg and config parts of the
vexpress driver, make it an actual MFD driver, and spread the remaining
bits of the code into their respective subsystems. I don't think
this is an eccentric requirement.


> In fact what we'd need at this point is 
> drivers/code_that_no_subsystem_maintainers_wants/.  
Which is what some people think drivers/mfd/ is...
I don't mind merging Lorenzo's SPC driver as it is if he can explain to
me how it will eventually evolve into an actual MFD driver. If that's
not the case, I don't see how I could justify merging it through the
MFD tree.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
