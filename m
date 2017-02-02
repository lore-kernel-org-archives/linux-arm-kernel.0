From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 2 Feb 2017 20:21:13 +0100
Subject: [PATCH 5/7] arm64: arch_timer: work around Hisilicon erratum
 161010101
In-Reply-To: <1485865196-12742-6-git-send-email-mark.rutland@arm.com>
References: <1485865196-12742-1-git-send-email-mark.rutland@arm.com>
 <1485865196-12742-6-git-send-email-mark.rutland@arm.com>
Message-ID: <20170202192113.GA2138@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:19:54PM +0000, Mark Rutland wrote:
> From: Ding Tianhong <dingtianhong@huawei.com>
> 
> Erratum Hisilicon-161010101 says that the ARM generic timer counter "has
> the potential to contain an erroneous value when the timer value
> changes". Accesses to TVAL (both read and write) are also affected due
> to the implicit counter read. Accesses to CVAL are not affected.
> 
> The workaround is to reread the system count registers until the value
> of the second read is larger than the first one by less than 32, the
> system counter can be guaranteed not to return wrong value twice by
> back-to-back read and the error value is always larger than the correct
> one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> [Mark: split patch, fix Kconfig, reword commit message]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
