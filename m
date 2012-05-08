From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 8 May 2012 08:12:33 +0300
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120507183611.GA725@kroah.com>
References: <201205070859.29174.arnd@arndb.de>
 <20120507.122333.2024326166703361049.hdoyu@nvidia.com>
 <201205071024.48958.arnd@arndb.de>
 <20120507.143647.508182574757518311.hdoyu@nvidia.com>
 <20120507183611.GA725@kroah.com>
Message-ID: <20120508081233.8883eb8ec2a8bc99b4039334@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 May 2012 20:36:11 +0200
"gregkh at linuxfoundation.org" <gregkh@linuxfoundation.org> wrote:

> On Mon, May 07, 2012 at 01:36:47PM +0200, Hiroshi Doyu wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > Subject: Re: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
> > Date: Mon, 7 May 2012 12:24:48 +0200
> > Message-ID: <201205071024.48958.arnd@arndb.de>
> > 
> > > On Monday 07 May 2012, Hiroshi Doyu wrote:
> > > > Tegra doesn't enable ARM_AMBA and Tegra doesn't use the following
> > > > "drivers/amba/bus.c" right now. I needed to make this directory
> > > > available to ones without ARM_AMBA enabled.
> > > 
> > > Ah, right. I looked at arch/arm/Kconfig earlier to see if
> > > tegra enabled ARM_AMBA but was accidentally looking
> > > at ARCH_INtegraTOR when grepping for TEGRA ;-)
> > > 
> > > Your proposed solution sounds good then.
> > 
> > Thank you for reviewing patches & ACK. Attached the update one here,
> > instead of sending a while series again.
> > 
> > >From 16cc2b0fab00c33cd24bb5c43c45a4cda646ad42 Mon Sep 17 00:00:00 2001
> > From: Hiroshi DOYU <hdoyu@nvidia.com>
> > Date: Wed, 18 Apr 2012 11:41:56 +0300
> > Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
> > 
> > Tegra AHB Bus conforms to the AMBA Specification (Rev 2.0) Advanced
> > High-performance Bus (AHB) architecture.
> > 
> > The AHB Arbiter controls AHB bus master arbitration. This effectively
> > forms a second level of arbitration for access to the memory
> > controller through the AHB Slave Memory device. The AHB pre-fetch
> > logic can be configured to enhance performance for devices doing
> > sequential access. Each AHB master is assigned to either the high or
> > low priority bin. Both Tegra20/30 have this AHB bus.
> > 
> > Some of configuration params could be passed from DT too if needed.
> > 
> > Change-Id: I184e0e1ce033e76881353a4bb99234e2850e99c2
> 
> What nonsense is this?  Please never put that in a patch you want
> accepted upstream, as it makes no sense and we just have to edit it out
> by hand, making us grumpy...

Sorry, my bad.

Stephen, would you mind removing that line when you take them in?
