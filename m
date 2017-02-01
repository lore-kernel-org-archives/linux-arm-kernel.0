From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 1 Feb 2017 11:14:13 +0100
Subject: [PATCH 4/7] arm64: arch_timer: introduce generic errata handling
 infrastructure
In-Reply-To: <1485865196-12742-5-git-send-email-mark.rutland@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
 <1485865196-12742-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20170201101413.GN2206@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:19:53PM +0000, Mark Rutland wrote:
> From: Ding Tianhong <dingtianhong@huawei.com>
> 
> Currently we have code inline in the arch timer probe path to cater for
> Freescale erratum A-008585, complete with ifdeffery. This is a little
> ugly, and will get worse as we try to add more errata handling.
> 
> This patch refactors the handling of Freescale erratum A-008585. Now the
> erratum is described in a generic arch_timer_erratum_workaround
> structure, and the probe path can iterate over these to detect errata
> and enable workarounds.
> 
> This will simplify the addition and maintenance of code handling
> Hisilicon erratum 161010101.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> [Mark: split patch, correct Kconfig, reword commit message]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
