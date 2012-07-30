From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2012 22:56:17 +0100
Subject: [PATCH] ARM: Sort exception table at compile time
In-Reply-To: <1343683803-15507-1-git-send-email-sboyd@codeaurora.org>
References: <1343683803-15507-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120730215617.GA10335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 02:30:03PM -0700, Stephen Boyd wrote:
> Add the ARM machine identifier to sortextable and select the
> config option so that we can sort the exception table at compile
> time. sortextable relies on a section named __ex_table existing
> in the vmlinux, but ARM's linker script places the exception
> table in the data section. Give the exception table its own
> section so that sortextable can find it.
> 
> This allows us to skip the runtime sorting step during boot.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: David Daney <david.daney@cavium.com>
> ---
> 
> I can't find any information on why the exception table lives in the data
> section. If there's a good reason for that, I'll look into changing
> sortextable to look for the __start___ex_table symbol.

Be careful about the placement of this, especially with XIP.
