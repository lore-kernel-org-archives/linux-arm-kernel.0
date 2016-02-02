From: rabin@rab.in (Rabin Vincent)
Date: Tue, 2 Feb 2016 18:25:31 +0100
Subject: [PATCH v2] recordmcount: arm: Implement make_nop
In-Reply-To: <1454371583-9064-1-git-send-email-sboyd@codeaurora.org>
References: <1454371583-9064-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160202172531.GA9044@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 04:06:23PM -0800, Stephen Boyd wrote:
> In similar spirit to x86 and arm64 support, add a make_nop_arm()
> to replace calls to mcount with nops in sections that aren't
> traced.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Changes from v1:
>  * Replace with nops instead of pops
>  * Check for BE or LE kernel with elf headers
>  * Drop mcount style check because now we look at the previous
>    instruction to determine if it's a push (__gnu_mcount_nc) or not (mcount).

Acked-by: Rabin Vincent <rabin@rab.in>
