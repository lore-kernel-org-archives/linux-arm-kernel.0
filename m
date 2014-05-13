From: nikolay.borisov@arm.com (Nikolay Borisov)
Date: Tue, 13 May 2014 15:57:57 +0100
Subject: [PATCH 2/7] ARM: Introduce arm_get_current_stack_frame()
In-Reply-To: <20140513145526.GX32718@rric.localhost>
References: <1399974418-4995-1-git-send-email-Nikolay.Borisov@arm.com>
 <1399974418-4995-3-git-send-email-Nikolay.Borisov@arm.com>
 <20140513145526.GX32718@rric.localhost>
Message-ID: <000501cf6ebb$ba64ed70$2f2ec850$@borisov@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Robert Richter [mailto:rric.net at gmail.com] On Behalf Of Robert
> Richter
> Sent: 13 May 2014 15:55
> To: Nikolay Borisov
> Cc: linux-arm-kernel at lists.infradead.org; Dave P Martin; Will Deacon;
> anurag19aggarwal at gmail.com; a.p.zijlstra at chello.nl;
> sebastian.hesselbarth at gmail.com
> Subject: Re: [PATCH 2/7] ARM: Introduce arm_get_current_stack_frame()
> 
> On 13.05.14 10:46:53, Nikolay Borisov wrote:
> >  #define instruction_pointer(regs)	(regs)->ARM_pc
> > +#define frame_pointer(regs)				\
> > +	IS_ENABLED(CONFIG_THUMB2_KERNEL) ? regs->ARM_r7 \
> > +	: regs->ARM_fp					\
> 
> (regs)->... should be used here both.
> 

Yeah, I fixed it already in my local version. Thanks. 
> -Robert
