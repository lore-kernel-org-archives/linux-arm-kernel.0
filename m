From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 8 Aug 2018 14:58:15 +0000
Subject: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
In-Reply-To: <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
 <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
 <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
 <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
Message-ID: <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-08-08 at 15:19 +0100, Lorenzo Pieralisi wrote:
> On Wed, Aug 08, 2018 at 11:37:14AM +0000, Leonard Crestez wrote:
> > On Wed, 2018-08-08 at 12:14 +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Aug 08, 2018 at 10:53:52AM +0000, Leonard Crestez wrote:
> > > > On Tue, 2018-07-24 at 19:14 +0300, Leonard Crestez wrote:
> > > > > Changes since v2:
> > > > >  * Print with dev_info if link fails on resume (Lucas)
> > > > >  * Add a comment on imx7d pci irq mappings (Andrey)
> > > > >  * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)
> > > > > 
> > > > > The ltssm_disable does not return an error because it can't be usefully
> > > > > handled, reversing partial suspend is a nightmare and unlikely to work.
> > > > > 
> > > > >  * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)
> > > > > 
> > > > > Series is against linux-next tag next-20180724 where the reset patch was
> > > > > already accepted. The imx7d.dtsi patch is also useful standalone.
> > > > 
> > > > This is a gentle reminder that this series was reviewed by Lucas two
> > > > weeks ago but not yet included.
> > > 
> > > Does this series have a functional dependency on the reset fix ? If yes
> > > we can have a bisection proplem depending on which tree gets merged
> > > first.
> > 
> > Yes, without the reset fix I expect hangs.
> > 
> > Maybe the reset fix should be pulled in the pci tree? I don't know how
> > these issues are sorted out.
> 
> Well either I pull that fix into the PCI tree (but it is already -rc8
> and I can't guarantee v4.19 inclusion - I shall try) or I can ack these
> patches and Philippe will send them upstream on my behalf, atop the
> reset fix above.
> 
> When will the reset fix will be sent to Linus ? Please let me know
> how you want to proceed.

I have some other unsent changes for imx pci+dts+reset standing by.
Since these changes qualify more as "pm features" than fixes I don't
really mind skipping 4.19.

Pulling pci features into the reset tree doesn't make much sense to me.

Maybe this kind of stuff could go through Shawn's tree? There shouldn't
be any interaction with non-imx stuff.
