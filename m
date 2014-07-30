From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 30 Jul 2014 08:29:13 -0700
Subject: [PATCH] ARM: smp_scu: Enable standby mode
In-Reply-To: <20140730094332.GC12239@arm.com>
References: <1406654463-15475-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140730094332.GC12239@arm.com>
Message-ID: <0551c7f6-ea12-426d-8941-2fe1a2e4676d@BN1BFFO11FD013.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-30 at 10:43AM +0100, Will Deacon wrote:
> On Tue, Jul 29, 2014 at 06:21:03PM +0100, Soren Brinkmann wrote:
> > Enable the SCU standby mode.
> > From documentation:
> >   When set, SCU CLK is turned off when all processors are in WFI mode,
> >   there is no pending request on the ACP (if implemented), and there is
> >   no remaining activity in the SCU.
> > 
> >   When SCU CLK is off, ARREADYS, AWREADYS and WREADYS on the ACP are forced
> >   LOW. The clock is turned on when any processor leaves WFI mode, or if
> >   there is a new request on the ACP.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > Hi,
> > 
> > I am working on some PM related patches for Zynq. One of them is
> > enabling the SCU standby mode. I was wondering whether this is probably
> > something that I should not do in platform specific code, but rather in
> > the common code for everybody?
> 
> Take a look at Shawn's patches for this:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/275326.html

Great, so that is already coming. Is that patch already applied
somewhere?

	Thanks,
	S?ren
