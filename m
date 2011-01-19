From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 14:54:25 +0000
Subject: [PATCH v2 0/8] Switch ARM platforms from integrator-flash to
	physmap
In-Reply-To: <1294409399-19245-1-git-send-email-marc.zyngier@arm.com>
References: <1294409399-19245-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110119145425.GF31652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 02:09:51PM +0000, Marc Zyngier wrote:
> As the integrator-flash driver is mostly a duplicate of physmap,
> move all users of this driver to physmap and get rid of the
> then unused driver.

Does MTD guarantee that the vpp will be turned off whenever the physmap
module is removed?  If not, can it?

The reason is that enabling VPP enables the programming voltage for all
flash devices on these platforms - including the flash devices which
hold FPGA/CPLD image.  We really don't want VPP left on for no reason,
as it means you can render the hardware dead if you corrupt the flash
holding the FPGA/CPLD image.

I've done exactly that to one of my boards before now.
