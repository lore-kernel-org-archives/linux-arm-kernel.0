From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Nov 2014 12:55:43 +0100
Subject: [PATCH v3 11/19] arm/arm64: KVM: refactor MMIO accessors
In-Reply-To: <1414776414-13426-12-git-send-email-andre.przywara@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-12-git-send-email-andre.przywara@arm.com>
Message-ID: <20141104115543.GM16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 05:26:46PM +0000, Andre Przywara wrote:
> The MMIO accessors for GICD_I[CS]ENABLER, GICD_I[CS]PENDR and
> GICD_ICFGR behave very similar in GICv3, although the way the
> affected vCPU is determined differs.

They behave similarly to each other (the registers) or similarly to how
they are implemented for GICv2?

> Factor out a generic, backend-facing implementation and use small
> wrappers in the current GICv2 emulation to ease code sharing later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I can't really understand the motivation from your commit message, but
the code looks fine and I suppose I'll realize the motivation later:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
