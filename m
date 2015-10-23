From: Minghuan.Lian@freescale.com (Lian M.H.)
Date: Fri, 23 Oct 2015 06:02:49 +0000
Subject: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
 LS2080a
In-Reply-To: <CADRPPNQoyzfr=bHOaVRrdxDmamUtTOfJOn=G9bQ=tGrB8b2Z4A@mail.gmail.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
 <20151021213612.GK1583@localhost>
 <CADRPPNSPP1m_7zNF6wEfw9+Bpe=Z_gUA81cSaV4SENVpR34YWQ@mail.gmail.com>
 <20151022180813.GA25693@localhost>
 <CADRPPNQoyzfr=bHOaVRrdxDmamUtTOfJOn=G9bQ=tGrB8b2Z4A@mail.gmail.com>
Message-ID: <DM2PR0301MB064039AF2A51F940B9C7A025E2260@DM2PR0301MB0640.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn and Leo,

> -----Original Message-----
> From: pku.leo at gmail.com [mailto:pku.leo at gmail.com] On Behalf Of Li Yang
> Sent: Friday, October 23, 2015 3:18 AM
> To: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-pci at vger.kernel.org; Jingoo Han
> <jg1.han@samsung.com>; Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>;
> Zang Roy-R61911 <tie-fei.zang@freescale.com>; Yoder Stuart-B08248
> <stuart.yoder@freescale.com>; Lian Minghuan-B31939
> <Minghuan.Lian@freescale.com>; Zhou Wang <wangzhou1@hisilicon.com>;
> Bjorn Helgaas <bhelgaas@google.com>; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and
> LS2080a
> 
> On Thu, Oct 22, 2015 at 1:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Hi Leo,
> >
> > On Thu, Oct 22, 2015 at 12:38:48PM -0500, Li Yang wrote:
> >> On Wed, Oct 21, 2015 at 4:36 PM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> >> > On Fri, Oct 16, 2015 at 03:19:19PM +0800, Minghuan Lian wrote:
> >> >> Both LS1043a and LS2080a are based on ARMv8 64-bit architecture
> >> >> and have similar PCIe implementation. LUT is added to controller.
> >> >> The patch removes the necessary fields from struct ls_pcie.
> >> >>
> >> >> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> >> >> ---
> >> >> This patch is based on v4.3-rc4 and [PATCH v10 3/6]
> >> >> PCI: designware: Add ARM64 support.
> >>
> >> Hi Bjorn,
> >>
> >> Are you also applying this patch
> >> https://patchwork.ozlabs.org/patch/531184/ in this merge windows?
> >> Because the new hardware can only work with the generic ARM64 support
> >> added in the designware pcie driver.
> >
> > I'm reviewing that patch right now, and I do hope to apply it for
> > v4.4.
> >
> > There was no cover letter for this series (Minghuan's Layerscape v4
> > series), and I didn't see any mention of dependencies, so I applied it
> > on top of v4.3-rc1.  Is that the wrong thing to do?  If it depends on
> > the Zhou's v11 series, I can hold the Layerscape branch until after
> > that.
> 
> I don't know if this patch will break anything without Zhou's patch.
> But the new hardware mentioned in the description will not be working without
> the dependent patch.  We should hold this patch until after the generic
> change is merged.  Minghuan, are there any bug fixing patch in the series that
> need to be merged earlier?
> 
[Lian Minghuan-B31939] [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and LS2080a] depended on Zhou's patch. I have described this in this patch. Actually, without zhou's patch, pci_layerscape.c can also be compiled and works well for LS1021A arm32 architecture, just do not support arm64 architecture. 

Thank Bjorn very much, all the PCIe patches have been applied except MSI related patches.

Thanks,
Minghuan
 


> Regards,
> Leo
