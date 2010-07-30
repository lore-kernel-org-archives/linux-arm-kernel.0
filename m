From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jul 2010 08:19:10 +0100
Subject: [PATCH 2/3] arm: mm: do not set missing flags on ScorpionMP
In-Reply-To: <1280443366.27035.14.camel@c-dwalke-linux.qualcomm.com>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
	<1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
	<20100724082334.GB15571@n2100.arm.linux.org.uk>
	<1280354280.21185.10.camel@c-dwalke-linux.qualcomm.com>
	<20100728223603.GB6729@n2100.arm.linux.org.uk>
	<1280357495.21185.26.camel@c-dwalke-linux.qualcomm.com>
	<20100729071818.GC6729@n2100.arm.linux.org.uk>
	<1280443366.27035.14.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100730071910.GC29746@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 03:42:46PM -0700, Daniel Walker wrote:
> On Thu, 2010-07-29 at 08:18 +0100, Russell King - ARM Linux wrote:
> > On Wed, Jul 28, 2010 at 03:51:35PM -0700, Daniel Walker wrote:
> > > @@ -326,6 +327,29 @@ cpu_elf_name:
> > >  
> > >  	.section ".proc.info.init", #alloc, #execinstr
> > >  
> > > +	.type   __v7_msm_proc_info, #object
> > > +__v7_msm_proc_info:
> > > +	.long	0x000f0000		@ Required ID value
> > > +	.long	0x000f0000		@ Mask for ID
> > 
> > Almost - is there no more specific ID value for your CPU?
> 
> Here's one with a more specific cpu id. Would you be willing to take
> this for 2.6.36 or are you pretty much done taking pull requests?

Yes, but if its just for this patch, is there much point to a pull
request?
