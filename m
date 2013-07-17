From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jul 2013 14:29:02 -0400 (EDT)
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <20130717170038.GP24642@n2100.arm.linux.org.uk>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374052705.3146.86.camel@hornet>
 <alpine.LFD.2.03.1307170825240.14924@syhkavp.arg>
 <1374067786.3146.123.camel@hornet>
 <alpine.LFD.2.03.1307171014510.14924@syhkavp.arg>
 <1374070811.3146.124.camel@hornet>
 <alpine.LFD.2.03.1307171148160.14924@syhkavp.arg>
 <20130717170038.GP24642@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1307171416490.14924@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jul 2013, Russell King - ARM Linux wrote:

> On Wed, Jul 17, 2013 at 11:57:55AM -0400, Nicolas Pitre wrote:
> > The sanest location at this point might simply be 
> > drivers/platform/vexpress_spc.c or drivers/platform/vexpress/spc.c 
> > depending on whether or not more such driver glue is expected in the 
> > vexpress future.  No point putting "arm" in the path, especially if this 
> > is later reused on arm64.
> 
> You wouldn't be making that argument if it were arch/arm64 and arch/arm32 -
> you'd probably be arguing that "arm" made perfect sense.

Well... in a sense: yes.  But in the end, having per arch directories 
under drivers/ is silly.  We already have per arch directories under 
arch/already.

> Don't get too hung up on names please, it's really not worth the time
> and effort being soo pedantic, and being soo pedantic leads to "pointless
> churn" when someone comes along and wants to pedantically change the
> names because it no longer matches the users.

At this point I don't really care about the name.  I just want the damn 
thing merged upstream.  But after several iterations to either fit one 
or another maintainers taste, each rework ends up in that maintainer 
saying: "Now that you've reworked the code, I still don't like it since 
this no longer fits in my subsystem tree."

In fact what we'd need at this point is 
drivers/code_that_no_subsystem_maintainers_wants/.  This is becoming 
overly ridiculous.


Nicolas
