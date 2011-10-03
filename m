From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 03 Oct 2011 14:33:30 +0100
Subject: [PATCH] ARM: debug: provide dummy default option for DEBUG_LL
	UART choice
In-Reply-To: <1317374927-4997-1-git-send-email-will.deacon@arm.com>
References: <1317374927-4997-1-git-send-email-will.deacon@arm.com>
Message-ID: <4E89B9AA.8030406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/11 10:28, Will Deacon wrote:
> Defaulting to DEBUG_ICEDCC will cause systems to hang during boot unless
> a hardware debugger is listening to the debug comms. channel.
> 
> This patch adds a dummy UART option as the default DEBUG_LL choice which
> requires the platform to do the right thing.
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> This came out of discussion on the list yesterday but I thought I'd better
> post a patch before sending to Russell.

This fixes my OMAP4 boot problems (where DEBUG_ICEDCC got silently
selected). Tested on -next-20110930.

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
