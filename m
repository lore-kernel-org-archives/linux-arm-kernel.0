From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 12 Feb 2015 07:09:22 -0800
Subject: [PATCH v2] ARM: dts: zynq: Add OCM node
In-Reply-To: <20150212150709.GG1522@leverpostej>
References: <6df19b400e314ef8228be475bb8ba83765683016.1423737765.git.michal.simek@xilinx.com>
 <20150212105443.GB1522@leverpostej>
 <c64e7b4bf78649049cea3dceecea453c@BN1AFFO11FD014.protection.gbl>
 <5c1602f83c594a72aac78c245f1830fa@BL2FFO11FD052.protection.gbl>
 <20150212150709.GG1522@leverpostej>
Message-ID: <2ddf1ba832284ebaa67cea12985d6ece@BN1AFFO11FD005.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-02-12 at 03:07PM +0000, Mark Rutland wrote:
> On Thu, Feb 12, 2015 at 02:58:36PM +0000, S?ren Brinkmann wrote:
> > On Thu, 2015-02-12 at 12:01PM +0100, Michal Simek wrote:
> > > On 02/12/2015 11:54 AM, Mark Rutland wrote:
> > > > On Thu, Feb 12, 2015 at 10:42:47AM +0000, Michal Simek wrote:
> > > >> Add OCM node for all zynq boards. OCM location
> > > >> can changed but for all current boards this
> > > >> is the location where OCM is.`
> > > >>
> > > >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > > >> ---
> > > >>
> > > >> Changes in v2:
> > > >> - Move node to board file suggested by Mark
> > > >>
> > > >> This patch is done based on discussion here.
> > > >> https://lkml.org/lkml/2014/12/1/396
> > > >>
> > > >> Mark: I expect you won't like amba bus reference or
> > > >> am I wrong?
> > > > 
> > > > I'm fine with dropping things onto a bus in this way. If we're happy to
> > > > do it for other nodes I don't see why busses should be special.
> > > 
> > > Wonderful. I will give people some time to comment this style.
> > 
> > Given that the location is discoverable, wouldn't it make sense to let
> > 'reg' point to the ctrl/cfg registers in the SLCR and let the driver
> > handle the whereabouts of the OCM location? (but I guess this is going
> > in circles now, such a proposal was on the table at some point, IIRC).
> > But I'd prefer:
> > 	memory-controller at 0xfffc0000 { /* the address here would of course not match all configurations */
> 
> I'd really prefer that we keep the unit-address and reg consistent.
> 
> Given that the address may change on a per-board basis, it simply has to
> live in the board file.

It's not a per-board but rather per use-case configuration.

	Soren
