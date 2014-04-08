From: mbohan@codeaurora.org (Michael Bohan)
Date: Mon, 7 Apr 2014 17:35:47 -0700
Subject: memcpy alignment for DEVICE_nGnRnE
In-Reply-To: <20140221105307.GE25363@localhost>
References: <53072343.4080505@marvell.com> <20140221105307.GE25363@localhost>
Message-ID: <20140408003547.GA18321@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Fri, Feb 21, 2014 at 10:53:08AM +0000, Catalin Marinas wrote:
> On Fri, Feb 21, 2014 at 09:58:27AM +0000, Zhou Zhu wrote:
> > We faced one issue using memcpy for memory type DEVICE_nGnRnE 
> > (pgprot_noncached). If the address is not aligned, exception would 
> > happen due to the alignment of this type could not be handled by hardware.
> 
> Indeed, that's expected. This memory type is the equivalent of Strongly
> Ordered.
> 
> > Is there any plan and ongoing patch to support this or we need to keep 
> > address aligned for memcpy using pgprot_noncached memory in drivers?
> 
> You either change the memory type to pgprot_writecombine() or use the
> right API (memcpy_toio/memcpy_fromio, these could be further optimised,
> similar to powerpc for example, but I didn't get there yet).

How should we handle Device Memory with copy_from_user / copy_to_user?
Should we follow the same scheme and create
copy_from_user_io / copy_to_user_io, or rather enforce that the stock
routines handle alignment?

Thanks,
Mike

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
