From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Dec 2016 10:00:15 +0000
Subject: [PATCH 1/1] arm64: mm: add config options for page table
 configuration
In-Reply-To: <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
References: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
 <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
Message-ID: <20161208100014.GE33075@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 11:40:00AM -0800, Scott Branden wrote:
> Make MAX_PHYSMEM_BITS and SECTIONS_SIZE_BITS configurable by adding
> config options.
> Default to current settings currently defined in sparesmem.h.
> For systems wishing to save memory the config options can be overridden.
> Example, changing MAX_PHYSMEM_BITS from 48 to 36 at the same time as
> changing SECTION_SIZE_BITS from 30 to 26 frees 13MB of memory.

I'm not keen on such change, it's a big departure from the single Image
aims. I would rather reduce SECTION_SIZE_BITS permanently where
feasible, like in this patch:

http://lkml.kernel.org/r/1465821119-3384-1-git-send-email-jszhang at marvell.com

-- 
Catalin
