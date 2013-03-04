From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Mar 2013 20:47:56 +0200
Subject: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
In-Reply-To: <5134E0BF.7050306@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
 <20130302114742.GA9965@arwen.pp.htv.fi> <5134D484.8070307@ti.com>
 <20130304171159.GB14507@arwen.pp.htv.fi> <5134E0BF.7050306@ti.com>
Message-ID: <20130304184756.GA15203@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 04, 2013 at 11:58:23AM -0600, Jon Hunter wrote:
> >>> while (isr) {
> >>> 	unsigned long bit = __ffs(isr);
> >>>
> >>> 	/* clear this bit */
> >>> 	isr &= ~bit;
> >>>
> >>> 	generic_handle_irq(irq_find_mapping(bank->domain, bit);
> >>> }
> >>>
> >>> this way you will only iterate the amount of bits enabled in the isr
> >>> register.
> >>
> >> Definitely cleaner but I am wondering which approach would be more
> >> efficient from an instruction standpoint. This could definitely be much
> >> more efficient if there is only a couple bits set.
> > 
> > __ffs() is done with CLZ instruction, so it's pretty fast.
> 
> Ok, yes I see that now for ARMv5 onwards. Grant has pushed the patch,
> but may be we can update this as an optimisation separately.

sure, that was my suggestion from the beginning :-) It's clearly subject
to a separate patch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130304/57368795/attachment-0001.sig>
