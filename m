From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:39:44 +0000
Subject: [PATCH 1/6] arm64: barriers: allow dsb macro to take option
 parameter
In-Reply-To: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140206113944.GI29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:30:48AM +0000, Will Deacon wrote:
> The dsb instruction takes an option specifying both the target access
> types and shareability domain.
> 
> This patch allows such an option to be passed to the dsb macro,
> resulting in potentially more efficient code. Currently the option is
> ignored until all callers are updated (unlike ARM, the option is
> mandated by the assembler).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Catalin -- I'd like to get this simple change in for 3.14, since it's a
>            blocker for actually implementing the barrier options (we
> 	   need to move all of the callers over before making the switch).

OK, no problem. Applied.

-- 
Catalin
