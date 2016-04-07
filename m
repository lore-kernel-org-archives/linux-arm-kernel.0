From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 7 Apr 2016 08:14:00 +0000
Subject: [PATCH v2] PCI: designware: move remaining rc setup code to
 dw_pcie_setup_rc()
In-Reply-To: <CAHM4w1khRn4xbWbj5Qk-p5DMGjEdWfgr1W1OSsXPFVaYenFa8A@mail.gmail.com>
References: <1458128433-3020-1-git-send-email-jszhang@marvell.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED40E52@lhreml503-mbs>
 <CAHM4w1khRn4xbWbj5Qk-p5DMGjEdWfgr1W1OSsXPFVaYenFa8A@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED43F7E@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush

Many thanks for quick replying

> -----Original Message-----
> From: Pratyush Anand [mailto:pratyush.anand at gmail.com]
> Sent: 07 April 2016 07:59
> To: Gabriele Paoloni
> Cc: Jisheng Zhang; jingoohan1 at gmail.com; bhelgaas at google.com; linux-
> pci at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2] PCI: designware: move remaining rc setup code
> to dw_pcie_setup_rc()
> 
> Hi Gab,
> 
> Thanks for bringing it.
> 
> 
> On Wed, Apr 6, 2016 at 8:20 PM, Gabriele Paoloni
> <gabriele.paoloni@huawei.com> wrote:
> > Hi, sorry to be late on this
> >
> >> -----Original Message-----
> >> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> >> owner at vger.kernel.org] On Behalf Of Jisheng Zhang
> >> Sent: 16 March 2016 11:41
> >> To: jingoohan1 at gmail.com; pratyush.anand at gmail.com;
> bhelgaas at google.com
> >> Cc: linux-pci at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> arm-
> >> kernel at lists.infradead.org; Jisheng Zhang
> >> Subject: [PATCH v2] PCI: designware: move remaining rc setup code to
> >> dw_pcie_setup_rc()
> >>
> >> dw_pcie_setup_rc(), as its name indicates, setups the RC. But
> current
> >> dw_pcie_host_init() also contains some necessary rc setup code.
> >>
> >> Another reason: the host may lost power during suspend to ram, the
> RC
> >> need to be re-setup after resume. The rc can't be correctly resumed
> >> without the rc setup code in dw_pcie_host_init().
> >>
> >> So this patch moves the code to dw_pcie_setup_rc() to address the
> above
> >> two issues. After this patch, each pcie designware driver users
> could
> >> call dw_pcie_setup_rc() to re-setup rc when resume back.
> >
> > I think this patch breaks the Hisilicon driver...
> >
> > Our driver performs linkup setup in UEFI therefore we do not call
> > dw_pcie_setup_rc(), we only call dw_pcie_host_init().
> >
> > Maybe better to group the part of code to be moved in as separate
> > function...
> >
> > Thanks and sorry for late reply.
> >
> 
> I am just wondering, should n't then what ever we do in
> dw_pcie_setup_rc() be done in your boot loader and not just link up.

Currently the HiSilicon driver does not call dw_pcie_setup_rc() at all;
so everything is done in dw_pcie_setup_rc() is done in bootloader.

I guess your question is if we can execute in bootloader the part of
code the this patch has moved to in "dw_pcie_setup_rc()". I think the
problem here is that even if it was possible we would break backward
compatibility with previous bootloaders...

Thanks

Gab 


> 
> ~Pratyush
