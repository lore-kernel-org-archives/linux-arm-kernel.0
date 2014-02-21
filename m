From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Feb 2014 10:53:08 +0000
Subject: memcpy alignment for DEVICE_nGnRnE
In-Reply-To: <53072343.4080505@marvell.com>
References: <53072343.4080505@marvell.com>
Message-ID: <20140221105307.GE25363@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On Fri, Feb 21, 2014 at 09:58:27AM +0000, Zhou Zhu wrote:
> We faced one issue using memcpy for memory type DEVICE_nGnRnE 
> (pgprot_noncached). If the address is not aligned, exception would 
> happen due to the alignment of this type could not be handled by hardware.

Indeed, that's expected. This memory type is the equivalent of Strongly
Ordered.

> Is there any plan and ongoing patch to support this or we need to keep 
> address aligned for memcpy using pgprot_noncached memory in drivers?

You either change the memory type to pgprot_writecombine() or use the
right API (memcpy_toio/memcpy_fromio, these could be further optimised,
similar to powerpc for example, but I didn't get there yet).

-- 
Catalin
