From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Aug 2015 10:49:23 +0100
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
In-Reply-To: <55BF33AD.5040502@huawei.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <20150803075848.GH7557@n2100.arm.linux.org.uk>
 <55BF33AD.5040502@huawei.com>
Message-ID: <20150803094923.GI7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 05:26:05PM +0800, Shannon Zhao wrote:
> Hi Russell,
> 
> On 2015/8/3 15:58, Russell King - ARM Linux wrote:
> > On Mon, Aug 03, 2015 at 02:59:56PM +0800, Shannon Zhao wrote:
> >> From: Shannon Zhao <shannon.zhao@linaro.org>
> >>
> >> According to ACPI SPEC, it supports ARM boards to use "GPIO-signaled
> >> ACPI Events". These events can be used for input events. And to QEMU, it
> >> uses GPIO PL061 controller for input events.
> >>
> >> These two patches add platform driver support for PL061 probed by DT or
> >> ACPI.
> > 
> > This certainly is incorrect for DT, and is probably wrong for ACPI too.
> > DT creates amba devices, so binds via the amba device driver.
> > 
> 
> Oh, sorry. The changes for DT are not necessary. But for ACPI I think it
> needs to convert pl061 to platform device since ACPI doesn't support
> AMBA devices. The Pl011 also does the same thing to support ACPI
> probing. See drivers/tty/serial/amba-pl011.c

Maybe rather than having every AMBA driver also converted to a platform
driver (which GregKH hates) maybe ACPI should support the AMBA bus
instead?

Greg?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
