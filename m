From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Mar 2014 20:02:15 +0100
Subject: [PATCH 4/4] ARM: mvebu: the Armada XP Matrix board has 4 GB
In-Reply-To: <20140304185512.GQ1872@titan.lakedaemon.net>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1393951022-18114-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140304185512.GQ1872@titan.lakedaemon.net>
Message-ID: <20140304200215.71cf4c13@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 4 Mar 2014 13:55:12 -0500, Jason Cooper wrote:
> On Tue, Mar 04, 2014 at 05:37:02PM +0100, Thomas Petazzoni wrote:
> > Since the Armada XP Matrix board has 4 GB of RAM and not 2 GB, we
> > update the Device Tree to take into account the correct amount of
> > memory. As noted in the new comment, the last 256 MB of RAM are in
> > fact not usable, due to the overlap with the MBus Window address
> > range.
> 
> usually the bootloader (DT) or atags_to_fdt overwrites this.  Is there a
> scenario when that doesn't happen?

ATAGs booting with CONFIG_ARM_ATAG_DTB_COMPAT disabled. Though mainly
the intent here is that if the amount of memory is mentioned in the DT,
it's nicer when it's actually correct :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
