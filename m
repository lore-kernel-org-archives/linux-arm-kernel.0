From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Jun 2018 17:24:41 +0100
Subject: [PATCH] arm64: mm: Ensure writes to swapper are ordered wrt
 subsequent cache maintenance
In-Reply-To: <1529681025-20850-1-git-send-email-will.deacon@arm.com>
References: <1529681025-20850-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180622162440.nwbzygwb7k4juuqb@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 04:23:45PM +0100, Will Deacon wrote:
> When rewriting swapper using nG mappings, we must performance cache
> maintenance around each page table access in order to avoid coherency
> problems with the host's cacheable alias under KVM. To ensure correct
> ordering of the maintenance with respect to Device memory accesses made
> with the Stage-1 MMU disabled, DMBs need to be added between the
> maintenance and the corresponding memory access.
> 
> This patch adds a missing DMB between writing a new page table entry and
> performing a clean+invalidate on the same line.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
