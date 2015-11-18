From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Nov 2015 12:14:50 +0000
Subject: [PATCHv2] arm64: Fix R/O permissions in mark_rodata_ro
In-Reply-To: <1447359670-23652-1-git-send-email-labbott@fedoraproject.org>
References: <CAKv+Gu8Z7bkogGUGcNbuSoEbUBAwVmtFNhX9VcbypucaUGd+HQ@mail.gmail.com>
 <1447359670-23652-1-git-send-email-labbott@fedoraproject.org>
Message-ID: <20151118121450.GF27495@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 12:21:10PM -0800, Laura Abbott wrote:
> The permissions in mark_rodata_ro trigger a build error
> with STRICT_MM_TYPECHECKS. Fix this by introducing
> PAGE_KERNEL_ROX for the same reasons as PAGE_KERNEL_RO.
> From Ard:
> 
> "PAGE_KERNEL_EXEC has PTE_WRITE set as well, making the range
> writeable under the ARMv8.1 DBM feature, that manages the
> dirty bit in hardware (writing to a page with the PTE_RDONLY
> and PTE_WRITE bits both set will clear the PTE_RDONLY bit in that case)"
> 
> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>

Applied. Thanks.

-- 
Catalin
