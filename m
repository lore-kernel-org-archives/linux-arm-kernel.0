From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Feb 2018 18:55:30 +0000
Subject: [PATCH] arm64: proc: Set PTE_NG for table entries to avoid
 traversing them twice
In-Reply-To: <1518527649-18358-1-git-send-email-will.deacon@arm.com>
References: <1518527649-18358-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180214185529.2ogkbjkid6q4u4p6@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 01:14:09PM +0000, Will Deacon wrote:
> When KASAN is enabled, the swapper page table contains many identical
> mappings of the zero page, which can lead to a stall during boot whilst
> the G -> nG code continually walks the same page table entries looking
> for global mappings.
> 
> This patch sets the nG bit (bit 11, which is IGNORED) in table entries
> after processing the subtree so we can easily skip them if we see them
> a second time.
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for -rc2. Thanks.
