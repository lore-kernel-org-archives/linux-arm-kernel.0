From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Fri, 09 May 2014 16:11:23 -0700
Subject: [PATCH RFC v3 4/6] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
In-Reply-To: <1399399483-17112-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <536d609c.0458440a.0ea9.77a3@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lorenzo Pieralisi (2014-05-06 11:04:41)
> This patch implements the cpu_suspend cpu operations method through
> the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
> index passed by the cpu_suspend core call into a valid PSCI state according to
> the PSCI states initialized at boot by the PSCI suspend backend.
> 
> Entry point is set to cpu_resume physical address, that represents the
> default kernel execution address following a CPU reset.
> 
> Idle state indices missing a DT node description are initialized to power
> state standby WFI so that if called by the idle driver they provide the
> default behaviour.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Reviewed-by: Sebastian Capella <sebastian.capella@linaro.org>

Thanks!

Sebastian
