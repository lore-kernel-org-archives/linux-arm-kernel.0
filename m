From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 12:45:28 +0100
Subject: [PATCHv3 05/19] arm64: kill change_cpacr()
In-Reply-To: <20180618120310.39527-6-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-6-mark.rutland@arm.com>
Message-ID: <20180619114528.zk6p6vnyhtzh7oqn@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:56PM +0100, Mark Rutland wrote:
> Now that we have sysreg_clear_set(), we can use this instead of
> change_cpacr().
> 
> Note that the order of the set and clear arguments differs between
> change_cpacr() and sysreg_clear_set(), so these are flipped as part of
> the conversion. Also, sve_user_enable() redundantly clears
> CPACR_EL1_ZEN_EL0EN before setting it; this is removed for clarity.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
