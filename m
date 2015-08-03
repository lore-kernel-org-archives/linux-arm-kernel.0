From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Aug 2015 08:58:48 +0100
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
In-Reply-To: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20150803075848.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 02:59:56PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> According to ACPI SPEC, it supports ARM boards to use "GPIO-signaled
> ACPI Events". These events can be used for input events. And to QEMU, it
> uses GPIO PL061 controller for input events.
> 
> These two patches add platform driver support for PL061 probed by DT or
> ACPI.

This certainly is incorrect for DT, and is probably wrong for ACPI too.
DT creates amba devices, so binds via the amba device driver.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
