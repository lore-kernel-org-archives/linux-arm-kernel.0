From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 2 May 2017 09:30:26 +0200
Subject: [PATCH] arm64: KVM: Fix decoding of Rt/Rt2 when trapping AArch32
 CP accesses
In-Reply-To: <20170427180648.25159-1-marc.zyngier@arm.com>
References: <20170427180648.25159-1-marc.zyngier@arm.com>
Message-ID: <20170502073026.GD16940@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 07:06:48PM +0100, Marc Zyngier wrote:
> Our 32bit CP14/15 handling inherited some of the ARMv7 code for handling
> the trapped system registers, completely missing the fact that the
> fields for Rt and Rt2 are now 5 bit wide, and not 4...
> 
> Let's fix it, and provide an accessor for the most common Rt case.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

Aplied to kvmarm/queue.

Thanks,
-Christoffer
