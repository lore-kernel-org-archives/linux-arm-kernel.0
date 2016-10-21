From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 21 Oct 2016 16:05:04 +0000
Subject: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL
 pointer
In-Reply-To: <20161021153701.GC9007@localhost>
References: <1476740647-11155-1-git-send-email-leoyang.li@nxp.com>
 <20161021153701.GC9007@localhost>
Message-ID: <AM2PR04MB077062B18CE8197BB7FE77808FD40@AM2PR04MB0770.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas at kernel.org]
> Sent: Friday, October 21, 2016 10:37 AM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Minghuan Lian
> <minghuan.Lian@freescale.com>; Mingkai Hu <mingkai.hu@freescale.com>;
> Roy Zang <tie-fei.zang@freescale.com>; linux-pci at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Stuart Yoder
> <stuart.yoder@nxp.com>
> Subject: Re: [PATCH] PCI: layerscape: Fix kernel panic on accessing NULL pointer
> 
> On Mon, Oct 17, 2016 at 04:44:06PM -0500, Li Yang wrote:
> > Commit fefe6733e added reference to the pcie->drvdata before it is
> > initialized which causes a kernel panic.  Fix the problem by
> > initializing the pcie->drvdata earlier before it is used.
> >
> > Reported-by: Stuart Yoder <stuart.yoder@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> 
> I applied Marc Zyngier's identical patch to for-linus for v4.9.  I don't know which
> was posted first, but I saw Marc's first.  Sorry I didn't at least credit you when I
> applied it.

It's ok.  Seems Marc sent the patch earlier and I didn't notice his patch.  There is no difference as long as the problem is addressed.  :)

Regards,
Leo
