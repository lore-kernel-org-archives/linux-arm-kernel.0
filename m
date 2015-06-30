From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Jun 2015 18:03:15 +0100
Subject: [PATCH 2/2] arm/arm64: KVM: fix two build failured under
 STRICT_MM_TYPECHECKS
In-Reply-To: <1435680290-13945-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1435680290-13945-1-git-send-email-ard.biesheuvel@linaro.org>
 <1435680290-13945-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150630170315.GL7445@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 06:04:50PM +0200, Ard Biesheuvel wrote:
> This fixes two instances where a pgprot_t is used as the operand
> of a bitwise & operation. In order to comply with STRICT_MM_TYPECHECKS,
> bitwise arithmetic on a pgprot_t should go via the pgprot_val()
> accessor.
> 
> Cc: kvmarm at lists.cs.columbia.edu
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(I guess it will go via the kvm tree)
