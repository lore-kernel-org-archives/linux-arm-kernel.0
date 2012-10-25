From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Oct 2012 13:27:55 +0100
Subject: [PATCHv3] ARM: Sort exception table at compile time
In-Reply-To: <1351125882-13046-1-git-send-email-sboyd@codeaurora.org>
References: <1351125882-13046-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20121025122754.GF11267@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 01:44:42AM +0100, Stephen Boyd wrote:
> Add the ARM machine identifier to sortextable and select the
> config option so that we can sort the exception table at compile
> time. sortextable relies on a section named __ex_table existing
> in the vmlinux, but ARM's linker script places the exception
> table in the data section. Give the exception table its own
> section so that sortextable can find it.
> 
> This allows us to skip the sorting step during boot.
> 
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Just had a play with this for my A15 platform and it seems to work fine when
targetting either ARM or Thumb-2 kernels.

Tested-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
