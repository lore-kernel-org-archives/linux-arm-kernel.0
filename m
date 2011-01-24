From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 10:30:43 +0000
Subject: [PATCH 5/5] ARM: smp: Skip secondary cpu calibration to
	speed-up boot
In-Reply-To: <1295859080-15259-6-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110124103043.GB18459@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 02:21:19PM +0530, Santosh Shilimkar wrote:
> On some architectures, secondary cores shares clock with primiary
> core and hence scale together. Hence secondary core lpj calibration
> is not necessary and can be skipped to save considerable time.
> 
> This can speed up the secondary cpu boot and hotplug cpu online
> paths.

I still point out that this will be a user visible change in /proc/cpuinfo.
