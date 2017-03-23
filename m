From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Mar 2017 15:37:51 +0000
Subject: [PATCH] arm64: cpufeature: Make ID reg accessor naming less
 counterintuitive
In-Reply-To: <1490282079-2724-1-git-send-email-Dave.Martin@arm.com>
References: <1490282079-2724-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170323153750.GJ9287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 03:14:39PM +0000, Dave Martin wrote:
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

As discussed in the other thread [1], the read_sanitised_ftr_reg() makes
sense to me. I'm also happy with the __read_sysreg_by_encoding() change.

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/496305.html
