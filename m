From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Sep 2014 16:45:29 +0100
Subject: [PATCHv4 2/2] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <540493DC.20909@codeaurora.org>
References: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
 <1408477303-2640-3-git-send-email-lauraa@codeaurora.org>
 <20140826144023.GA22256@localhost> <540493DC.20909@codeaurora.org>
Message-ID: <20140901154529.GF24594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 04:42:20PM +0100, Laura Abbott wrote:
> On 8/26/2014 7:40 AM, Catalin Marinas wrote:
> > On Tue, Aug 19, 2014 at 08:41:43PM +0100, Laura Abbott wrote:
> >> --- /dev/null
> >> +++ b/arch/arm64/mm/pageattr.c
> > [...]
> >> +static int change_memory_common(unsigned long addr, int numpages,
> >> +				pgprot_t set_mask, pgprot_t clear_mask)
> >> +{
> >> +	unsigned long start = addr;
> >> +	unsigned long size = PAGE_SIZE*numpages;
> >> +	unsigned long end = start + size;
> >> +	int ret;
> >> +	struct page_change_data data;
> >> +
> >> +	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
> >> +		addr &= PAGE_MASK;
> >> +		WARN_ON_ONCE(1);
> >> +	}
> >> +
> >> +	if (!is_module_address(start) || !is_module_address(end))
> >> +		return -EINVAL;
> >
> > Minor thing, "end" is exclusive here. Do you still get the right check
> > with is_module_address(end)?
> >
> 
> No, You are correct. I'll talk to Will to get that fixed up.

I already had a crack at fixing it:

  https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=devel&id=a8b974874c4770860c2a356adb9397d38f6c2b70

How did I do?

Will
