From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 02 Jun 2015 14:23:37 -0700
Subject: [PATCH v2 0/2] Fix cpuidle on qcom's THUMB2 kernels
In-Reply-To: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Tue, 2 Jun 2015 12:12:56 -0700")
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <7hr3ptajom.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> I split this patch into two now that we have the cpu_resume_arm()
> wrapper. The first patch could go through rmk's tree and then be
> provided at some stable branch so that the second patch could go
> through arm-soc. Or the two patches could go through arm-soc and
> be squashed into one patch or stay split out. Either way, we have a
> cross maintainer dependency here that needs to be resolved.

Tested-by: Kevin Hilman <khilman@linaro.org>

Boot tested on top of next-20150602 using multi_v7_defconfig +
CONFIG_THUMB2_KERNEL=y on a handful of qcom 8x[678]4 platforms[1] 

These platforms were all failing to boot this config with plain
next-20150602[2] and are all booting fine with this series.

Kevin

[1]
qcom-apq8064-ifc6410
qcom-apq8064-cm-qs600
qcom-apq8074-dragonboard
qcom-msm8974-sony-xperia-honami
qcom-apq8084-ifc6540

[2] http://kernelci.org/boot/all/job/next/kernel/next-20150602/
