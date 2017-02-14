From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 14 Feb 2017 14:29:19 +0000
Subject: [PATCH] PCI: Xilinx NWL: Remove mask for messages not supported
 by AXI
In-Reply-To: <20170210202536.GI29169@bhelgaas-glaptop.roam.corp.google.com>
References: <1485853170-31940-1-git-send-email-bharatku@xilinx.com>
 <20170210202536.GI29169@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <8520D5D51A55D047800579B094147198263E9378@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Jan 31, 2017 at 02:29:30PM +0530, Bharat Kumar Gogada wrote:
> > - Removing support for vendor defined messages which are not
> > suppoerted by AXI
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> 
> Applied to pci/host-xilinx for v4.11, thanks.
> 
Thanks Bjorn.
> Bharat, get_maintainer.pl lists you as a contributor, but not as a maintainer of
> this file.  Should we update MAINTAINERS so it does?
Yes, Please update MAINTAINERS list.
> 
>   $ ./scripts/get_maintainer.pl drivers/pci/host/pcie-xilinx-nwl.c
>   Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI
> SUBSYSTEM,commit_signer:11/11=100%,authored:5/11=45%,added_lines:71/9
> 99=7%,removed_lines:58/132=44%)
>   Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ
> ARCHITECTURE)
>   "S?ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer:ARM/ZYNQ
> ARCHITECTURE)
>   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> (commit_signer:4/11=36%,authored:4/11=36%,added_lines:924/999=92%,remo
> ved_lines:23/132=17%)
>   Rob Herring <robh@kernel.org> (commit_signer:1/11=9%)
>   Colin Ian King <colin.king@canonical.com>
> (commit_signer:1/11=9%,authored:1/11=9%)
>   Paul Gortmaker <paul.gortmaker@windriver.com>
> (commit_signer:1/11=9%,authored:1/11=9%,removed_lines:50/132=38%)
>   linux-pci at vger.kernel.org (open list:PCI SUBSYSTEM)
>   linux-arm-kernel at lists.infradead.org (moderated list:ARM/ZYNQ
> ARCHITECTURE)
>   linux-kernel at vger.kernel.org (open list)
> 
> 
> > ---
> >  drivers/pci/host/pcie-xilinx-nwl.c |   14 +-------------
> >  1 files changed, 1 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > index 76dd094..651486a 100644
> > --- a/drivers/pci/host/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> > @@ -62,21 +62,9 @@
> >  #define CFG_ENABLE_PM_MSG_FWD		BIT(1)
> >  #define CFG_ENABLE_INT_MSG_FWD		BIT(2)
> >  #define CFG_ENABLE_ERR_MSG_FWD		BIT(3)
> > -#define CFG_ENABLE_SLT_MSG_FWD		BIT(5)
> > -#define CFG_ENABLE_VEN_MSG_FWD		BIT(7)
> > -#define CFG_ENABLE_OTH_MSG_FWD		BIT(13)
> > -#define CFG_ENABLE_VEN_MSG_EN		BIT(14)
> > -#define CFG_ENABLE_VEN_MSG_VEN_INV	BIT(15)
> > -#define CFG_ENABLE_VEN_MSG_VEN_ID	GENMASK(31, 16)
> >  #define CFG_ENABLE_MSG_FILTER_MASK	(CFG_ENABLE_PM_MSG_FWD
> | \
> >  					CFG_ENABLE_INT_MSG_FWD | \
> > -					CFG_ENABLE_ERR_MSG_FWD | \
> > -					CFG_ENABLE_SLT_MSG_FWD | \
> > -					CFG_ENABLE_VEN_MSG_FWD | \
> > -					CFG_ENABLE_OTH_MSG_FWD | \
> > -					CFG_ENABLE_VEN_MSG_EN | \
> > -					CFG_ENABLE_VEN_MSG_VEN_INV | \
> > -					CFG_ENABLE_VEN_MSG_VEN_ID)
> > +					CFG_ENABLE_ERR_MSG_FWD)
> >
> >  /* Misc interrupt status mask bits */
> >  #define MSGF_MISC_SR_RXMSG_AVAIL	BIT(0)
> > --
> > 1.7.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
