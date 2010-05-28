From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 02:08:51 +0100
Subject: defining ARM machine type properly
In-Reply-To: <4BFE8AF3.4060304@gmail.com>
References: <4BFD8E7A.6050103@gmail.com>
	<20100527010742.GH7248@trinity.fluff.org>
	<4BFE8AF3.4060304@gmail.com>
Message-ID: <20100528010851.GN4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 11:08:35AM -0400, f. achkar wrote:
> On 05/26/2010 09:07 PM, Ben Dooks wrote:
> > On Wed, May 26, 2010 at 05:11:22PM -0400, f. achkar wrote:
> >   
> >> hi,
> >> I'm trying to port smdk2450 arch to the a new kernel 2.6.32-9, I did the
> >>     
> > I suspect what you are doing is trying to port it to a machine that
> > was loosley based on the SMDK2450 and that whoever did the uboot port
> > failed to understand that when the hardware changes then the machine
> > number needs to change too.
> >
> >   
> >> initial work as per various googled documents, but somehow the current
> >> initial Image is failing at arch/arm/kernel/head-common.S :
> >> '__lookup_processor_type', and eventually goes to '__error_a' of the
> >> same file! this seems to be related to the definition of machine_type as
> >> defined in :
> >> include/asm-arm/mach-types.h  and arch/arm/tools/mach-types*
> >> I checked where the definition goes in  include/asm-arm/mach-types.h by
> >> inserting
> >>     
> > you probably wanted to enable the debugging in the head code.
> >
> >   
> >> #error 2223XX
> >> into various parts of that header and seems fine at the point.
> >> nevertheless I'm not 100 sure
> >> I wonder if the is a definitive reference to guide in this matter,
> >> better yet a check-list like procedure??
> >> thanks,
> >> ferar
> >>     
> > How about downloading the latest kernel, with nice fresh S3C2450 support
> > in it?
> >   
> which version is that? 2.6.34 does not contain such support!
> thanks

2.6.34-git

core support is in, hopefully core peripheral support can be sorted out
and released as soon as possible.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
