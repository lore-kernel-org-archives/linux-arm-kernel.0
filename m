From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 29 Jan 2016 17:30:46 +0000
Subject: [PATCH 0/3] UEFI stub pre-boot compat checks
In-Reply-To: <1454000549-9189-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454000549-9189-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56ABA1C6.5090307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 17:02, Ard Biesheuvel wrote:
> As discussed earlier today [1], and last year [2], it makes sense for the
> UEFI stub to perform some basic checks on the hardware for missing features
> that would prevent the kernel from booting to a state where it can even
> complain about this.
>
> So implements this for ARM, to check on LPAE builds whether the CPU supports
> it (patch #1), and for arm64, to check whether the build time granule is
> implemented by the CPU (patch #2). Patch #3 wires it up into the shared init
> code.
>
> [1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/472880
> [2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/447370

Ard,

Thanks for the quick solution. I tested this on Juno for 16K granule.
So, for arm64:

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Cheers
Suzuki
