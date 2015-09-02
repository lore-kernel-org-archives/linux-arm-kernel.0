From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 2 Sep 2015 11:55:10 +0200
Subject: [PATCH 00/14] arm64: 16K translation granule support
In-Reply-To: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
References: <1439465645-22584-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CAKv+Gu-fbC9hFj4cvGWd4sEvxPaR-nfgWS7C+e+jdRTGKOtp4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2015 at 13:33, Suzuki K. Poulose <suzuki.poulose@arm.com> wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> This series enables the 16K page size support on Linux for arm64.
> This series adds support for 48bit VA(4 level), 47bit VA(3 level) and
> 36bit VA(2 level) with 16K. 16K was a late addition to the architecture
> and is not implemented by all CPUs. Added a check to ensure the
> selected granule size is supported by the CPU, failing which the CPU
> won't proceed with booting.
>
> KVM bits have been tested on a fast model with GICv3 using Andre's kvmtool
> with gicv3 support[1].
>
> Patches 1-7 cleans up the kernel page size handling code.
> Patches 8-11 Fixes some issues with the KVM bits, mainly the fake PGD
>              handling code.
> Patch 12    Adds a check to ensure the CPU supports the selected granule size.
> Patch 13-14 Adds the 16k page size support bits.
>
> This series applies on top of for-next/core branch of the aarch64 tree and is
> also available here:
>
>         git://linux-arm.org/linux-skp.git  16k/v1
>


Hi Suzuki,

I have given this a spin on the FVP Base model to check UEFI booting,
and everything seems to work fine. (I tested 2-level and 3-level)
I didn't test the KVM changes, so for all patches except those:

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Regards,
Ard.
