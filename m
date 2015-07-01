From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 01 Jul 2015 14:07:12 +0100
Subject: [PATCH] arm64: Don't report clear pmds and puds as huge
In-Reply-To: <1435752511-7079-1-git-send-email-christoffer.dall@linaro.org>
References: <1435752511-7079-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <5593E600.2090107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/15 13:08, Christoffer Dall wrote:
> The current pmd_huge() and pud_huge() functions simply check if the table
> bit is not set and reports the entries as huge in that case.  This is
> counter-intuitive as a clear pmd/pud cannot also be a huge pmd/pud, and
> it is inconsistent with at least arm and x86.
> 
> To prevent others from making the same mistake as me in looking at code
> that calls these functions and to fix an issue with KVM on arm64 that
> causes memory corruption due to incorrect page reference counting
> resulting from this mistake, let's change the behavior.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

FWIW:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
