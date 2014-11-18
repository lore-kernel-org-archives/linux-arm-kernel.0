From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Nov 2014 23:02:55 +0000
Subject: [PATCH RFC 3/3] ARM: reduce size of page table directory for
 short mode
In-Reply-To: <20141118191104.GD4042@n2100.arm.linux.org.uk>
References: <20141118165313.9958.1242.stgit@buzz>
 <20141118165325.9958.84370.stgit@buzz>
 <20141118181412.GO28279@e104818-lin.cambridge.arm.com>
 <20141118191104.GD4042@n2100.arm.linux.org.uk>
Message-ID: <20141118230255.GA3841@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 07:11:04PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 18, 2014 at 06:14:12PM +0000, Catalin Marinas wrote:
> > Actually, with LPAE you can save a pmd and pte allocated for the vectors
> > page at 0xffff0000. So you can save 8K per task here. Similarly with the
> > classic MMU, you can save another 4K for the vectors page pte.
> 
> No.  For any CPU which has high vectors (approximately ARMv5 and up),
> there is no "vectors page pte".  The vectors page PTE is only allocated
> when we need low vectors.

You are right. The kernel pgd entries are copied by pgd_alloc, so no
need for additional pmd/pte allocations (they would be shared).

-- 
Catalin
