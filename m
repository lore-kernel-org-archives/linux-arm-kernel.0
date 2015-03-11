From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 11 Mar 2015 11:40:16 +0000
Subject: [PATCHv3 0/5] arm-cci400: PMU monitoring support on ARM64
In-Reply-To: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
 (Suzuki K. Poulose's message of "Tue, 10 Mar 2015 15:18:50 +0000")
References: <1426000735-14375-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <9hhsidbyd7j.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Suzuki K. Poulose" <suzuki.poulose@arm.com> writes:

> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> This series enables the PMU monitoring support for CCI400 on ARM64.
> The existing CCI400 driver code is a mix of PMU driver and the MCPM
> driver code. The MCPM driver is only used on ARM(32) and contains
> arm32 assembly and hence can't be built on ARM64. This patch splits
> the code to
>
>  - ARM_CCI400_PORT_CTRL driver - depends on ARM && V7
>  - ARM_CCI400_PMU driver
>
> Accessing the Peripheral ID2 register(PID2) on CCI-400, to detect
> the revision of the chipset, is a secure operation. Hence, it prevents
> us from running this on non-secure platforms. The issue is overcome by
> explicitly mentioning the revision number of the CCI PMU in the device tree
> binding. The device-tree binding has been updated with the new bindings.
>
> i.e,	arm-cci-400-pmu,r0 => revision 0
> 	arm-cci-400-pmu,r1 => revision 1
> 	arm-cci-400-pmu => (old) DEPRECATED
>
> The old binding has been DEPRECATED and must be used only on ARM32
> system with secure access. We don't have a reliable dynamic way to detect
> if the system is running secure. This series tries to use the best safe
> method by relying on the availability of MCPM(as it was prior to the series).
> It is upto the MCPM platform driver to decide, if the system is secure before
> it goes ahead and registers its drivers and pokes the CCI. This series doesn't
> address/solve the problem of MCPM. I will be happy to use a better approach,
> if there is any.
>
> Tested on (non-secure)TC2 and A53x2.
>

For the series,

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Cheers,
Punit

[...]
