From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Jul 2011 11:37:20 -0400 (EDT)
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace
 boot_params
In-Reply-To: <4E159A72.1070503@mvista.com>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<4E159A72.1070503@mvista.com>
Message-ID: <alpine.LFD.2.00.1107071136390.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Sergei Shtylyov wrote:

> Hello.
> 
> On 06-07-2011 6:46, Nicolas Pitre wrote:
> 
> > The boot_params member of the mdesc structure is used to provide a
> > default physical address for the ATAG list.  Since this value is fixed
> > at compile time and often based on ARCH_PHYS_OFFSET, it gets in the way
> > of runtime PHYS_OFFSET usage.
> 
> > Let's introduce atag_offset which should contains only the relative
> > offset from start of memory instead of an absolute value, in preparation
> > to move all instance of boot_params over to it.
> 
> > Signed-off-by: Nicolas Pitre<nicolas.pitre@linaro.org>
> [...]
> 
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index e0db84d..4cc3e2b 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -816,6 +816,8 @@ static struct machine_desc * __init
> > setup_machine_tags(unsigned int nr)
> > 
> >   	if (__atags_pointer)
> >   		tags = phys_to_virt(__atags_pointer);
> > +	else if(mdesc->atag_offset)
> 
>    Should be space after *if* -- checkpatch.pl should have complained.

Indeed, thanks.


Nicolas
