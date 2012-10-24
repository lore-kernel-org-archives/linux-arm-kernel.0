From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Oct 2012 15:53:34 -0700
Subject: [PATCH 2/7] ARM: hw_breakpoint: fix monitor mode detection with
 v7.1
In-Reply-To: <1350487901-3108-3-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
 <1350487901-3108-3-git-send-email-will.deacon@arm.com>
Message-ID: <5088716E.3060802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/12 08:31, Will Deacon wrote:
> Detecting whether halting debug is enabled is no longer possible via
> the DBGDSCR in v7.1, returning an UNKNOWN value for the HDBGen bit via
> CP14 when the OS lock is clear.
>
> This patch removes the halting mode check and ensures that accesses to
> the internal and external views of the DBGDSCR are serialised with an
> instruction barrier.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
