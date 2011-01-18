From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 23:42:15 +0000
Subject: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
In-Reply-To: <AANLkTikPm8_vxjF7P84q7kHq+XSvLyF+jToFt=COs8Mj@mail.gmail.com>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
	<20110114173400.GB22505@n2100.arm.linux.org.uk>
	<AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
	<AANLkTinJPyXKWwbyW05+HUW0LJUxsu=1Exbrr6ut27Kr@mail.gmail.com>
	<AANLkTikPm8_vxjF7P84q7kHq+XSvLyF+jToFt=COs8Mj@mail.gmail.com>
Message-ID: <20110118234215.GB17398@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 01:05:49PM +0100, Jean Pihet wrote:
> Dave, Russell,
> 
> On Mon, Jan 17, 2011 at 4:46 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > One way to work around this is would be to make omap_sram_push() a macro:
> >
> > #define omap_sram_push(funcp, size) \
> > ? ?(typeof(funcp))_do_omap_sram_push((void *)(funcp), size)
> >
> > ... where the definition of _do_omap_sram_push() is the same is the
> > existing definition of omap_sram_push(). ?Providing
> > _do_omap_sram_push() is not called directly, this should now be
> > type-safe.
> >
> Ok I reworked the patch from your suggestions. Indeed a few functions
> types mismatch have been spotted and corrected using the fncpy API.
> 
> New patch sent as '[PATCH v2] OMAP: use fncpy to copy the PM code
> functions to SRAM'.

Looks good, thanks.  Next problem to sort out is who's taking the
patches...
