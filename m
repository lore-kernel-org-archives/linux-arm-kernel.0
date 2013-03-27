From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Mar 2013 10:57:57 +0000
Subject: [PATCH 4/4] ARM: atomics: don't use exclusives for atomic64
 read/set with LPAE
In-Reply-To: <1364235581-17900-5-git-send-email-will.deacon@arm.com>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-5-git-send-email-will.deacon@arm.com>
Message-ID: <20130327105757.GE801@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:19:41PM +0000, Will Deacon wrote:
> To ease page table updates with 64-bit descriptors, CPUs implementing
> LPAE are required to implement ldrd/strd as atomic operations.
> 
> This patch uses these accessors instead of the exclusive variants when
> performing atomic64_{read,set} on LPAE systems.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
