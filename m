From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jun 2012 20:19:33 +0100
Subject: [PATCH 3/3] arm: mach-mvebu: system-controller only registers
 restart if device exists
In-Reply-To: <1340814406-26010-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
 <1340814406-26010-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20120627191932.GE25319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 05:26:46PM +0100, Ben Dooks wrote:
> Change to only registering the restart hook if the device exists
> and can be enumerated in the device tree. Remove the header definiton
> and the restart entry in the machine file.

NAK.  Please use the .restart method in the machine description rather
than directly using arm_pm_restart.  Thanks.

arm_pm_restart only continues to exist because I could not work out how
to stop AT91 from using it.
