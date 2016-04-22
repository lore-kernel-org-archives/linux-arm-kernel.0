From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 09:54:12 +0100
Subject: [RFC PATCH] arm64: Fix EL1/EL2 early init inconsistencies with VHE
In-Reply-To: <1461002246-25314-1-git-send-email-Dave.Martin@arm.com>
References: <1461002246-25314-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20160422085411.GA2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 06:57:26PM +0100, Dave P Martin wrote:
> When using the Virtualisation Host Extensions, EL1 is not used in
> the host and requires no separate configuration.
> 
> In addition, with VHE enabled, non-hyp-specific EL2 configuration
> that does not need to be done early will be done anyway in
> __cpu_setup via the _EL1 system register aliases.  In particular,
> the layout and definition of CPTR_EL2 are changed by enabling VHE
> so that they resemble CPACR_EL1, so existing code to initialise
> CPTR_EL2 becomes architecturally wrong in this case.
> 
> This patch simply skips the affected initialisation code in the
> non-VHE case.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

I queued this for 4.6 (with Marc's ack). Thanks.

-- 
Catalin
