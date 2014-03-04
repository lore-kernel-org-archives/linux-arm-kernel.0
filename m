From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Mar 2014 14:05:06 -0500
Subject: [PATCH 4/4] ARM: mvebu: the Armada XP Matrix board has 4 GB
In-Reply-To: <20140304200215.71cf4c13@skate>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1393951022-18114-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140304185512.GQ1872@titan.lakedaemon.net>
 <20140304200215.71cf4c13@skate>
Message-ID: <20140304190506.GR1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 08:02:15PM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 4 Mar 2014 13:55:12 -0500, Jason Cooper wrote:
> > On Tue, Mar 04, 2014 at 05:37:02PM +0100, Thomas Petazzoni wrote:
> > > Since the Armada XP Matrix board has 4 GB of RAM and not 2 GB, we
> > > update the Device Tree to take into account the correct amount of
> > > memory. As noted in the new comment, the last 256 MB of RAM are in
> > > fact not usable, due to the overlap with the MBus Window address
> > > range.
> > 
> > usually the bootloader (DT) or atags_to_fdt overwrites this.  Is there a
> > scenario when that doesn't happen?
> 
> ATAGs booting with CONFIG_ARM_ATAG_DTB_COMPAT disabled. Though mainly
> the intent here is that if the amount of memory is mentioned in the DT,
> it's nicer when it's actually correct :-)

Ok, just wanted to make sure we weren't trying to work around broken
bootloaders (DT aware, wrong idea of size) or something else silly like
that.

thx,

Jason.
