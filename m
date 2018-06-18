From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Jun 2018 18:12:30 +0100
Subject: [PATCH] arm64: make secondary_start_kernel() notrace
In-Reply-To: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
References: <1528794457-14129-1-git-send-email-zhizhouzhang@asrmicro.com>
Message-ID: <20180618171230.tmqkyv4w62mt5diq@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 05:07:37PM +0800, Zhizhou Zhang wrote:
> We can't call function trace hook before setup percpu offset.
> When entering secondary_start_kernel(), percpu offset has not
> been initialized.  So this lead hotplug malfunction.
> Here is the flow to reproduce this bug:
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo function > /sys/kernel/debug/tracing/current_tracer
> echo 1 > /sys/kernel/debug/tracing/tracing_on
> echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>

Queued for 4.18. Thanks.

-- 
Catalin
