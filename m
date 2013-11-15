From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Nov 2013 13:39:49 +0000
Subject: [PATCH 4/6] arm64: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <1384457866-16135-5-git-send-email-santosh.shilimkar@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131115133948.GB1217@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 07:37:44PM +0000, Santosh Shilimkar wrote:
> Slab allocator can allocate memory beyond the lowmem watermark
> which can lead to false failure of virt_addr_valid().
> 
> So drop the check. The issue was seen with percpu_alloc()
> in KVM code which was allocating memory beyond lowmem watermark.
> 
> Am not completly sure whether this is the right fix and if it could
> impact any other user of virt_addr_valid(). Without this fix as
> pointed out the KVM init was failing in my testing.

Do you have a problem on arm64? There is no lowmem watermark here.

-- 
Catalin
