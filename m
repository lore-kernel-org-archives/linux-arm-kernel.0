From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Oct 2017 11:15:48 +0100
Subject: [PATCH v3 17/28] arm64/sve: Preserve SVE registers around
 kernel-mode NEON use
In-Reply-To: <1507660725-7986-18-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-18-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171012101548.of4cn7re76xsot6k@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:34PM +0100, Dave P Martin wrote:
> Kernel-mode NEON will corrupt the SVE vector registers, due to the
> way they alias the FPSIMD vector registers in the hardware.
> 
> This patch ensures that any live SVE register content for the task
> is saved by kernel_neon_begin().  The data will be restored in the
> usual way on return to userspace.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
