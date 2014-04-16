From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Apr 2014 14:35:12 +0800
Subject: [PATCH 1/2] ahci: imx: use macros to define registers and bits
In-Reply-To: <20140415160317.GM1863@htj.dyndns.org>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <20140415160317.GM1863@htj.dyndns.org>
Message-ID: <20140416063510.GH2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 12:03:17PM -0400, Tejun Heo wrote:
> On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> > Comparing to enums, macros are more conventional to be used for
> > registers and bits definition.  Let's switch to macros.
> > 
> > While at it, the names of the registers and bit-fields are updated to
> > have proper namespace prefix and match the hardware reference manual.
> > 
> > No functional change is involved.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> 
> Please don't switch to defines.  A lot of libata constants use enums
> and they tend to have more advantages anyway.

I'm seeing a lot of ata drivers use defines though.  And I'm not sure I
understand the advantages of using enums over defines in ahci_imx
driver, where register offset and bit position are defined in the same
'enum' without a particular enum type.

enum {
	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
};

To me it's a misuse of enum.

Shawn
