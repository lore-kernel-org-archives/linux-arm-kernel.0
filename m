From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Apr 2017 16:56:04 +0100
Subject: [PATCH] arm64: cpufeature: Make ID reg accessor naming less
 counterintuitive
In-Reply-To: <1490282079-2724-1-git-send-email-Dave.Martin@arm.com>
References: <1490282079-2724-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170404155603.GC19969@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 03:14:39PM +0000, Dave P Martin wrote:
> read_system_reg() can readily be confused with read_sysreg(),
> whereas these are really quite different in their meaning.
> 
> This patches attempts to reduce the ambiguity be reserving "sysreg"
> for the actual system register accessors.
> 
> read_system_reg() is instead renamed to read_sanitised_ftr_reg(),
> to make it more obvious that the Linux-defined sanitised feature
> register cache is being accessed here, not the underlying
> architectural system registers.
> 
> cpufeature.c's internal __raw_read_system_reg() function is renamed
> in line with its actual purpose: a form of read_sysreg() that
> indexes on (non-compiletime-constant) encoding rather than symbolic
> register name.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Queued for 4.12

-- 
Catalin
