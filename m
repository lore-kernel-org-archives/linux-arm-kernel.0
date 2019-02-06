Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA56C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDA6217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xw4esuiR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="Bm/DvvMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDA6217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P73iAaQgSY0KGJWAnUVAo+xDS/Bv6lZMNc08ifuIbYA=; b=Xw4esuiRW6Uhdf
	QCYy6MORxifKblKGcCocG0u2pbcS7MtLi6ZjQYYEkUCIVvLWR1v/UibHRaHQI2VmDyou4JrrFLqeh
	f20r7H+cIIQ6hawIp3OODuOwPOlQr+vfwPkA2NK+uUIXQ69rrr7upsjjYYO4/7P9WLSvaNx8/0UpR
	YFE5ZkJ6K41P9kcBP51FE/o7n4GIMgW9vmfFQZIzJ5SCTIQHW1tT87BxWcpl+BahHYAZg2rC+vlnq
	1FC6deEJtSsvVObK6MThgFbLAcP2rENUO6NhoQXww7h4J6zVtkORJn0mE7LlrFdwvbtWf7HxsZ+Uu
	xf4OqkK3Bwo08LJeX89g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grKsm-0001WP-FY; Wed, 06 Feb 2019 10:56:44 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grKsd-0001Vt-9l
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 10:56:42 +0000
Received: by mail-wm1-x343.google.com with SMTP id y139so1949474wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qUZb4HrZa8QTpzE5LEkLOjgsHLhVrt9pprptVcmqvmA=;
 b=Bm/DvvMkQbuTlLA1CaySox1nryyRT8C2lvILUjmX0NIL+J+bXbaH7XUP5ZzfmLQ/gp
 N8m3f0e1kGLuGurHGFLeWHNI3wAwc6ijbtsK7pXhpNyLgSBddZ7JpU52ayTSCws+ww6+
 cCPBy+TxGvf6i+cGuxI+MrY0MM3cRYbTo3VeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qUZb4HrZa8QTpzE5LEkLOjgsHLhVrt9pprptVcmqvmA=;
 b=lPfu0xS0NgtaxF3pCbcvfvjAph3i2DeZEF6HCuZVv9h6LEatA1NN5Qrl3jS74+/GxR
 EX/c3jXknKUilINgTs0oqedoaRswjmG0tS4X3xWDf2Ld99fT9hwHxdnjcI0967M7yDps
 X+rpXae+8KsBUREaVjJp9Y1Gt69aBMd82g+USDIh7Ew0NL5N6kCrM6UNMdGxivIO2DRg
 1//MDLQXHKRQmCcrMzJb1jhyERpwHIGzCSMk6LJQbYVc89FVt//tlc5cdvvYAJjQbLwO
 bFrWeec9BV1LAQschkmUR2iUzgmwHf/RgQ5b+hpVNAyZLatNMV6NMCrM7r0urLkfHxmM
 9thg==
X-Gm-Message-State: AHQUAuY0M/b2G+AjfSr7Bsn1Xf3APFDhVttm3kYLzefSE0XQoJJk8axz
 dTMhb6e4D7rhQf6gXJ7Hwlivxmx4cLEVsGRkVT/KwA==
X-Google-Smtp-Source: AHgI3IZkiJ5TdUfp7O+ibv6YcxucJCPOubFICGdOIdILfLrImQPRX0gpoSJ+5UnFROgjfUBWGdz5wH7+6YUTowpPXnw=
X-Received: by 2002:a7b:c458:: with SMTP id l24mr2821358wmi.143.1549450590388; 
 Wed, 06 Feb 2019 02:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-2-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0wA5=juO0PnuMKY_mJSPD12W09Vy+buW_EyQAKzZkjKw@mail.gmail.com>
 <20190205174316.GA12956@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190205174316.GA12956@e107981-ln.cambridge.arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Wed, 6 Feb 2019 16:29:06 +0530
Message-ID: <CAFZiPx3v3-L4h83-hjSq5eeHd_c2vdwx3cyjqeTuRiPeMsRzFQ@mail.gmail.com>
Subject: Re: [PATCHv3 01/27] PCI: mobiveil: uniform the register accessors
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_025635_353868_7739BC2D 
X-CRM114-Status: GOOD (  25.28  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Z.q. Hou" <zhiqiang.hou@nxp.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Mingkai Hu <mingkai.hu@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Lorenzo,

On Tue, Feb 5, 2019 at 11:13 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Feb 05, 2019 at 11:09:19AM +0530, Subrahmanya Lingappa wrote:
> > Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>
> I have a feeling you do not read what I write.

My apologies, I do read. I am new to reviewing process and trying to learn here.
>
> Please never top-post.
>
I'll make sure not to top-post now on-wards.
>
> Read this, especially the email etiquette section:
>
> https://kernelnewbies.org/PatchCulture
>
I read it.

Thank you.
> >
> >
> >
> > On Tue, Jan 29, 2019 at 1:38 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > It's confused that R/W some registers by csr_readl()/csr_writel(),
> > > while others by read_paged_register()/write_paged_register().
> > > Actually the low 3KB of 4KB PCIe configure space can be accessed
> > > directly and high 1KB is paging area. So this patch uniformed the
> > > register accessors to csr_readl() and csr_writel() by comparing
> > > the register offset with page access boundary 3KB in the accessor
> > > internal.
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > > ---
> > > V3:
> > >  - No change
> > >
> > >  drivers/pci/controller/pcie-mobiveil.c | 179 +++++++++++++++++--------
> > >  1 file changed, 124 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > > index 77052a0712d0..d55c7e780c6e 100644
> > > --- a/drivers/pci/controller/pcie-mobiveil.c
> > > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > > @@ -47,7 +47,6 @@
> > >  #define  PAGE_SEL_SHIFT        13
> > >  #define  PAGE_SEL_MASK         0x3f
> > >  #define  PAGE_LO_MASK          0x3ff
> > > -#define  PAGE_SEL_EN           0xc00
> > >  #define  PAGE_SEL_OFFSET_SHIFT 10
> > >
> > >  #define PAB_AXI_PIO_CTRL       0x0840
> > > @@ -117,6 +116,12 @@
> > >  #define LINK_WAIT_MIN  90000
> > >  #define LINK_WAIT_MAX  100000
> > >
> > > +#define PAGED_ADDR_BNDRY                       0xc00
> > > +#define OFFSET_TO_PAGE_ADDR(off)               \
> > > +       ((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
> > > +#define OFFSET_TO_PAGE_IDX(off)                        \
> > > +       ((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
> > > +
> > >  struct mobiveil_msi {                  /* MSI information */
> > >         struct mutex lock;              /* protect bitmap variable */
> > >         struct irq_domain *msi_domain;
> > > @@ -145,15 +150,119 @@ struct mobiveil_pcie {
> > >         struct mobiveil_msi msi;
> > >  };
> > >
> > > -static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
> > > -               const u32 reg)
> > > +/*
> > > + * mobiveil_pcie_sel_page - routine to access paged register
> > > + *
> > > + * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
> > > + * for this scheme to work extracted higher 6 bits of the offset will be
> > > + * written to pg_sel field of PAB_CTRL register and rest of the lower 10
> > > + * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
> > > + */
> > > +static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
> > >  {
> > > -       writel_relaxed(value, pcie->csr_axi_slave_base + reg);
> > > +       u32 val;
> > > +
> > > +       val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
> > > +       val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
> > > +       val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
> > > +
> > > +       writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
> > >  }
> > >
> > > -static inline u32 csr_readl(struct mobiveil_pcie *pcie, const u32 reg)
> > > +static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
> > >  {
> > > -       return readl_relaxed(pcie->csr_axi_slave_base + reg);
> > > +       if (off < PAGED_ADDR_BNDRY) {
> > > +               /* For directly accessed registers, clear the pg_sel field */
> > > +               mobiveil_pcie_sel_page(pcie, 0);
> > > +               return pcie->csr_axi_slave_base + off;
> > > +       }
> > > +
> > > +       mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
> > > +       return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
> > > +}
> > > +
> > > +static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
> > > +{
> > > +       if ((uintptr_t)addr & (size - 1)) {
> > > +               *val = 0;
> > > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > > +       }
> > > +
> > > +       switch (size) {
> > > +       case 4:
> > > +               *val = readl(addr);
> > > +               break;
> > > +       case 2:
> > > +               *val = readw(addr);
> > > +               break;
> > > +       case 1:
> > > +               *val = readb(addr);
> > > +               break;
> > > +       default:
> > > +               *val = 0;
> > > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > > +       }
> > > +
> > > +       return PCIBIOS_SUCCESSFUL;
> > > +}
> > > +
> > > +static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
> > > +{
> > > +       if ((uintptr_t)addr & (size - 1))
> > > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > > +
> > > +       switch (size) {
> > > +       case 4:
> > > +               writel(val, addr);
> > > +               break;
> > > +       case 2:
> > > +               writew(val, addr);
> > > +               break;
> > > +       case 1:
> > > +               writeb(val, addr);
> > > +               break;
> > > +       default:
> > > +               return PCIBIOS_BAD_REGISTER_NUMBER;
> > > +       }
> > > +
> > > +       return PCIBIOS_SUCCESSFUL;
> > > +}
> > > +
> > > +static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> > > +{
> > > +       void *addr;
> > > +       u32 val;
> > > +       int ret;
> > > +
> > > +       addr = mobiveil_pcie_comp_addr(pcie, off);
> > > +
> > > +       ret = mobiveil_pcie_read(addr, size, &val);
> > > +       if (ret)
> > > +               dev_err(&pcie->pdev->dev, "read CSR address failed\n");
> > > +
> > > +       return val;
> > > +}
> > > +
> > > +static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
> > > +{
> > > +       void *addr;
> > > +       int ret;
> > > +
> > > +       addr = mobiveil_pcie_comp_addr(pcie, off);
> > > +
> > > +       ret = mobiveil_pcie_write(addr, size, val);
> > > +       if (ret)
> > > +               dev_err(&pcie->pdev->dev, "write CSR address failed\n");
> > > +}
> > > +
> > > +static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
> > > +{
> > > +       return csr_read(pcie, off, 0x4);
> > > +}
> > > +
> > > +static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
> > > +{
> > > +       csr_write(pcie, val, off, 0x4);
> > >  }
> > >
> > >  static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
> > > @@ -342,45 +451,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
> > >         return 0;
> > >  }
> > >
> > > -/*
> > > - * select_paged_register - routine to access paged register of root complex
> > > - *
> > > - * registers of RC are paged, for this scheme to work
> > > - * extracted higher 6 bits of the offset will be written to pg_sel
> > > - * field of PAB_CTRL register and rest of the lower 10 bits enabled with
> > > - * PAGE_SEL_EN are used as offset of the register.
> > > - */
> > > -static void select_paged_register(struct mobiveil_pcie *pcie, u32 offset)
> > > -{
> > > -       int pab_ctrl_dw, pg_sel;
> > > -
> > > -       /* clear pg_sel field */
> > > -       pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
> > > -       pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
> > > -
> > > -       /* set pg_sel field */
> > > -       pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
> > > -       pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
> > > -       csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
> > > -}
> > > -
> > > -static void write_paged_register(struct mobiveil_pcie *pcie,
> > > -               u32 val, u32 offset)
> > > -{
> > > -       u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
> > > -
> > > -       select_paged_register(pcie, offset);
> > > -       csr_writel(pcie, val, off);
> > > -}
> > > -
> > > -static u32 read_paged_register(struct mobiveil_pcie *pcie, u32 offset)
> > > -{
> > > -       u32 off = (offset & PAGE_LO_MASK) | PAGE_SEL_EN;
> > > -
> > > -       select_paged_register(pcie, offset);
> > > -       return csr_readl(pcie, off);
> > > -}
> > > -
> > >  static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> > >                 int pci_addr, u32 type, u64 size)
> > >  {
> > > @@ -397,19 +467,19 @@ static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> > >         pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> > >         csr_writel(pcie,
> > >                 pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
> > > -       amap_ctrl_dw = read_paged_register(pcie, PAB_PEX_AMAP_CTRL(win_num));
> > > +       amap_ctrl_dw = csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> > >         amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
> > >         amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
> > >
> > > -       write_paged_register(pcie, amap_ctrl_dw | lower_32_bits(size64),
> > > -                               PAB_PEX_AMAP_CTRL(win_num));
> > > +       csr_writel(pcie, amap_ctrl_dw | lower_32_bits(size64),
> > > +                  PAB_PEX_AMAP_CTRL(win_num));
> > >
> > > -       write_paged_register(pcie, upper_32_bits(size64),
> > > -                               PAB_EXT_PEX_AMAP_SIZEN(win_num));
> > > +       csr_writel(pcie, upper_32_bits(size64),
> > > +                  PAB_EXT_PEX_AMAP_SIZEN(win_num));
> > >
> > > -       write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> > > -       write_paged_register(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> > > -       write_paged_register(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> > > +       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_AXI_WIN(win_num));
> > > +       csr_writel(pcie, pci_addr, PAB_PEX_AMAP_PEX_WIN_L(win_num));
> > > +       csr_writel(pcie, 0, PAB_PEX_AMAP_PEX_WIN_H(win_num));
> > >  }
> > >
> > >  /*
> > > @@ -437,8 +507,7 @@ static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> > >         csr_writel(pcie, 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> > >                         lower_32_bits(size64), PAB_AXI_AMAP_CTRL(win_num));
> > >
> > > -       write_paged_register(pcie, upper_32_bits(size64),
> > > -                               PAB_EXT_AXI_AMAP_SIZE(win_num));
> > > +       csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
> > >
> > >         /*
> > >          * program AXI window base with appropriate value in
> > > --
> > > 2.17.1
> > >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
