From: madalin.bucur@nxp.com (Madalin-cristian Bucur)
Date: Thu, 15 Mar 2018 09:32:35 +0000
Subject: [PATCH 0/5] DPAA Ethernet fixes
In-Reply-To: <1521052994.4790.148.camel@infinera.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
 <1521052994.4790.148.camel@infinera.com>
Message-ID: <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Joakim Tjernlund [mailto:Joakim.Tjernlund at infinera.com]
> Sent: Wednesday, March 14, 2018 8:43 PM
> To: davem at davemloft.net; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>
> 
> On Wed, 2018-03-14 at 08:37 -0500, Madalin Bucur wrote:
> > Hi,
> >
> > This patch set is addressing several issues in the DPAA Ethernet
> > driver suite:
> >
> >  - module unload crash caused by wrong reference to device being left
> >    in the cleanup code after the DSA related changes
> >  - scheduling wile atomic bug in QMan code revealed during dpaa_eth
> >    module unload
> >  - a couple of error counter fixes, a duplicated init in dpaa_eth.
> 
> hmm, some of these(all?) bugs are in stable too, CC: stable perhaps?

Hi Jocke,

I did not check that, they should be added.

Thanks,
Madalin

> >
> > Madalin
> >
> > Camelia Groza (3):
> >   dpaa_eth: remove duplicate initialization
> >   dpaa_eth: increment the RX dropped counter when needed
> >   dpaa_eth: remove duplicate increment of the tx_errors counter
> >
> > Madalin Bucur (2):
> >   soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
> >   dpaa_eth: fix error in dpaa_remove()
> >
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  8 ++++----
> >  drivers/soc/fsl/qbman/qman.c                   | 28 +++++---------------------
> >  2 files changed, 9 insertions(+), 27 deletions(-)
> >
> > --
> > 2.1.0
> >
