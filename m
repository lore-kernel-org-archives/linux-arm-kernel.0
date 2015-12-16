From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 16 Dec 2015 16:55:03 +0000
Subject: [PATCH 1/2] arm-cci500: Rearrange PMU driver for code sharing
 with CCI-550 PMU
In-Reply-To: <1447785040-18599-2-git-send-email-suzuki.poulose@arm.com>
 (Suzuki K. Poulose's message of "Tue, 17 Nov 2015 18:30:39 +0000")
References: <1447785040-18599-1-git-send-email-suzuki.poulose@arm.com>
 <1447785040-18599-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <87poy6tjtk.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Suzuki K. Poulose" <suzuki.poulose@arm.com> writes:

> CCI-550 PMU shares most of the CCI-500 PMU attributes including the
> event format, PMU event codes. The only difference is an additional
> master interface (MI6 - 0xe). Hence we share the driver code for both,
> except for a model specific event validate method.
> This patch renames the common CCI500 symbols to CCI5xx, including the
> Kconfig symbol.
>
> No functional changes to the PMU driver.
>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/bus/Kconfig   |    2 +-
>  drivers/bus/arm-cci.c |  218 +++++++++++++++++++++++++------------------------
>  2 files changed, 112 insertions(+), 108 deletions(-)

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks,
Punit
