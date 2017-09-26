From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Sep 2017 17:16:07 +0100
Subject: [PATCH] arm64: Make sure SPsel is always set
In-Reply-To: <1506437836-18736-1-git-send-email-will.deacon@arm.com>
References: <1506437836-18736-1-git-send-email-will.deacon@arm.com>
Message-ID: <20170926161606.xtzcixvjobtdfayt@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 03:57:16PM +0100, Will Deacon wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> When the kernel is entered at EL2 on an ARMv8.0 system, we construct
> the EL1 pstate and make sure this uses the the EL1 stack pointer
> (we perform an exception return to EL1h).
> 
> But if the kernel is either entered at EL1 or stays at EL2 (because
> we're on a VHE-capable system), we fail to set SPsel, and use whatever
> stack selection the higher exception level has choosen for us.
> 
> Let's not take any chance, and make sure that SPsel is set to one
> before we decide the mode we're going to run in.
> 
> Cc: <stable@vger.kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for 4.14-rc3. Thanks.

-- 
Catalin
