From: sam@ravnborg.org (Sam Ravnborg)
Date: Mon, 1 Apr 2013 23:58:34 +0200
Subject: [PATCH 1/2] Allow constructor name selection by architecture.
In-Reply-To: <87F2CC87-0FAF-49CB-AE70-423FB063A0E5@mvista.com>
References: <1338230018-31052-1-git-send-email-vincent.sanders@collabora.co.uk>
 <1338230018-31052-2-git-send-email-vincent.sanders@collabora.co.uk>
 <20120528203005.GA20560@merkur.ravnborg.org>
 <20120529090614.GD12217@n2100.arm.linux.org.uk>
 <20120606101253.GM8262@n2100.arm.linux.org.uk>
 <87F2CC87-0FAF-49CB-AE70-423FB063A0E5@mvista.com>
Message-ID: <20130401215834.GA5972@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 05:47:38PM -0400, George G. Davis wrote:
> On Jun 6, 2012, at 6:12 AM, Russell King - ARM Linux wrote:
> > On Tue, May 29, 2012 at 10:06:14AM +0100, Russell King - ARM Linux wrote:
> >> On Mon, May 28, 2012 at 10:30:05PM +0200, Sam Ravnborg wrote:
> >>> On Mon, May 28, 2012 at 07:33:37PM +0100, Vincent Sanders wrote:
> >>>> From: Vincent Sanders <vince@collabora.co.uk>
> >>>> 
> >>>> The constructor symbol name is different between platforms. Allow this
> >>>> to be selected by configuration and set suitable default values.
> >>>> 
> >>>> Signed-off-by: Vincent Sanders <vincent.sanders@collabora.co.uk>
> >>>> ---
> >>>> include/asm-generic/vmlinux.lds.h |    6 +++---
> >>>> init/Kconfig                      |    6 ++++++
> >>>> kernel/module.c                   |    2 +-
> >>>> 3 files changed, 10 insertions(+), 4 deletions(-)
> >>>> 
> >>>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> >>>> index 8aeadf6..fd34808 100644
> >>>> --- a/include/asm-generic/vmlinux.lds.h
> >>>> +++ b/include/asm-generic/vmlinux.lds.h
> >>>> @@ -471,9 +471,9 @@
> >>>> 	}
> >>>> 
> >>>> #ifdef CONFIG_CONSTRUCTORS
> >>>> -#define KERNEL_CTORS()	. = ALIGN(8);			   \
> >>>> -			VMLINUX_SYMBOL(__ctors_start) = .; \
> >>>> -			*(.ctors)			   \
> >>>> +#define KERNEL_CTORS()	. = ALIGN(8);					\
> >>>> +			VMLINUX_SYMBOL(__ctors_start) = .;		\
> >>>> +			*(CONFIG_CONSTRUCTORS_NAME)			\
> >>>> 			VMLINUX_SYMBOL(__ctors_end) = .;
> >>> 
> >>> What is wrong with adding both "standard" names for ctors uncnditionally?
> >>> Like this:
> >>>> 			*(.ctors)			   \
> >>>> +			*(.init_array)			   \
> >> 
> >> That doesn't get rid of CONFIG_CONSTRUCTORS_NAME, because it's needed
> >> in the module code.  Do you have a suggestion to solve that as well?
> > 
> > Ping.
> 
> Pinging this back to life.  I'd like to see GCOV for ARM eABI finally make it upstream.
> So, any objections to this?  Should it be resubmitted?

Why is CONFIG_CONSTRUCTORS_NAME needed in module code?

	Sam
