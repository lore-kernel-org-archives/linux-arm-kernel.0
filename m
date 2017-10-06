From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 6 Oct 2017 14:15:21 +0100
Subject: [PATCH v1 1/2] KVM: arm64: handle single-stepping trapped
 instructions
In-Reply-To: <20171006113921.24880-2-alex.bennee@linaro.org>
References: <20171006113921.24880-1-alex.bennee@linaro.org>
 <20171006113921.24880-2-alex.bennee@linaro.org>
Message-ID: <ec903fcc-6e73-40c6-69b0-b37d7d53d431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/10/17 12:39, Alex Benn?e wrote:
> If we are using guest debug to single-step the guest we need to ensure
> we exit after emulating the instruction. This only affects
> instructions completely emulated by the kernel. For userspace emulated
> instructions we need to exit and return to complete the emulation.
> 
> We fake debug.arch.hsr to contain ESR_ELx_EC_SOFTSTP_LOW so QEMU knows
> it was a single-step event (and without altering the userspace ABI).
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Thanks,

-- 
Julien Thierry
