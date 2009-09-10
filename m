From: nico@cam.org (Nicolas Pitre)
Date: Thu, 10 Sep 2009 16:57:26 -0400 (EDT)
Subject: ARM linux mailing lists FAQ about floating point support.
In-Reply-To: <4AA9652F.5000007@xenomai.org>
References: <4AA94A40.408@xenomai.org>
	<alpine.LFD.2.00.0909101625120.6044@xanadu.home>
	<4AA9613F.5050103@xenomai.org>
	<alpine.LFD.2.00.0909101634520.6044@xanadu.home>
	<4AA9652F.5000007@xenomai.org>
Message-ID: <alpine.LFD.2.00.0909101652020.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Sep 2009, Gilles Chanteperdrix wrote:

> Nicolas Pitre wrote:
> > On Thu, 10 Sep 2009, Gilles Chanteperdrix wrote:
> > 
> >> Nicolas Pitre wrote:
> >>> On Thu, 10 Sep 2009, Gilles Chanteperdrix wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> It seems the FAQ here:
> >>>> http://www.arm.linux.org.uk/mailinglists/faq.php#f4
> >>>>
> >>>> is a bit outdated, since it does not mention that EABI solves the issue.
> >>> And just how would EABI solve the issue?
> >> By allowing to mix soft-float and hard-float programs with only one libc?
> > 
> > Err... How?
> 
> Well, I read somewhere that EABI allows mixing soft-float and hard-float
> code and must have assumed it was true. But you made me doubt.
> 
> But since compiling both a hard-float program and a soft-float program
> with the same toolchain does not produce any compilation or link-edition
> error, I still tend to think it is true.

Well, actually it seems that gcc can only do -mfloat-abi=softfp and 
surprizingly -mfloat-abi=hard is unimplemented for VFP.  So in that case 
mixing soft and hard float objects is fine.


Nicolas
