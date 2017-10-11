From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Oct 2017 15:28:19 +0100
Subject: [PATCH v3 07/28] arm64/sve: Low-level SVE architectural state
 manipulation functions
In-Reply-To: <1507660725-7986-8-git-send-email-Dave.Martin@arm.com>
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-8-git-send-email-Dave.Martin@arm.com>
Message-ID: <20171011142819.jheh4jwb347demj6@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 07:38:24PM +0100, Dave P Martin wrote:
> Manipulating the SVE architectural state, including the vector and
> predicate registers, first-fault register and the vector length,
> requires the use of dedicated instructions added by SVE.
> 
> This patch adds suitable assembly functions for saving and
> restoring the SVE registers and querying the vector length.
> Setting of the vector length is done as part of register restore.
> 
> Since people building kernels may not all get an SVE-enabled
> toolchain for a while, this patch uses macros that generate
> explicit opcodes in place of assembler mnemonics.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(not adding reviewed-by as I haven't checked the instruction encodings,
I just trust you to be correct ;))
