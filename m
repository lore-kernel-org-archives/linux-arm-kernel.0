From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Sep 2011 19:05:16 -0700
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <4E83D25C.6020306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/11 18:23, Stephen Boyd wrote:
> DEBUG_ICEDCC support is just another DEBUG_LL choice and
> selecting it along with other DEBUG_LL options doesn't make
> much sense. Put it into the DEBUG_LL choice to avoid confusion.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>

Chatting with David Brown made me realize that this patch now forces
ICEDCC for anybody who selects DEBUG_LL and hasn't moved to adding a
Kconfig in the choice menu. I'm not sure if that actually matters since
it may be incentive to put your machine of choice into this menu.

Otherwise, we may want to drop this until a later point, or just leave
it out of the choice menu altogether.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
