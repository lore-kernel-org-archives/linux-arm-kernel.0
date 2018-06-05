From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jun 2018 16:50:48 +0100
Subject: [PATCH] arm64: cpu_errata: include required headers
In-Reply-To: <20180605115227.1621618-1-arnd@arndb.de>
References: <20180605115227.1621618-1-arnd@arndb.de>
Message-ID: <20180605155048.zz6zjxpmyeoliflj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 01:50:07PM +0200, Arnd Bergmann wrote:
> Without including psci.h and arm-smccc.h, we now get a build failure in
> some configurations:
> 
> arch/arm64/kernel/cpu_errata.c: In function 'arm64_update_smccc_conduit':
> arch/arm64/kernel/cpu_errata.c:278:10: error: 'psci_ops' undeclared (first use in this function); did you mean 'sysfs_ops'?
> 
> arch/arm64/kernel/cpu_errata.c: In function 'arm64_set_ssbd_mitigation':
> arch/arm64/kernel/cpu_errata.c:311:3: error: implicit declaration of function 'arm_smccc_1_1_hvc' [-Werror=implicit-function-declaration]
>    arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This showed up only recently, but I have not bisected what caused it.

I haven't hit it yet, not sure why. I'm queuing the patch anyway.
Thanks.

-- 
Catalin
