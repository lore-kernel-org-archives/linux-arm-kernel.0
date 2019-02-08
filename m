Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A3DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:49:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5452086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZycAQBKf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="eh/Bg0jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5452086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nrEzzMt7aRbWTwwUfsazA27PHyo0aPFQjX3Lr68I+z4=; b=ZycAQBKfcCuXee
	niABNdPtJqUd8E0Jv1HF1qnoyoK9yPy47Dk3udScfItht/przHK6YbAD4TYSjHZUPVTtgOhzdhr8P
	wh8zyHVLKUkLztd8ILWx1Y12cfX6n9riGN0N5E3fBbk2VrUrH11rp8cN4hu6bm/TgykNTxoApvQgH
	C3jYU/ikrri3MdEmzTws5vjWKJdiKIBw918P6McY8M+va9z6Mj8b62EZc7LJXSVjzLKmcA2wFrNkP
	jzNy063fSaf2ORjZ8qBYtowHtlcCNDP2LlXLCiq1yKxDjd1TowQTYSHKuByZnkgoJdE1fMQPqnfWV
	ohxwjBtQ9mcUPbCtIvrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5bK-00067Q-SW; Fri, 08 Feb 2019 12:49:50 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5bH-00066n-Fb
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:49:49 +0000
Received: by mail-wm1-x342.google.com with SMTP id z5so3308878wmf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mobiveil.co.in; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xPcDhdgRfeCUFb0NzA1yOiOvgeXq4mBndVeTfOEslgQ=;
 b=eh/Bg0jU9RaDR1LBeR3Gh1Q56m8LdqeMCjFymtwr+4RLIQKymhUKmPy7h8cE2dnt6I
 MY2BcxyhOc37PCKHC09QEvo6SDg9KssZE/fXVFmu9gRRmyMIwtzLjj6dvRIoXbuJj/lf
 F8RLPay1V2SCqepLMtout4X3rx5JR/99Q+y4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xPcDhdgRfeCUFb0NzA1yOiOvgeXq4mBndVeTfOEslgQ=;
 b=M3gOw2lXzevlVLme8r0IZRH6TxDyF8FyUxRN2Er8Az5XoG7mtdAHN+POjxSPgfIk3R
 YElsLK9LGaUzkOpSstdqJld10VqVsGJYv62Rwuj2SfUUkREdOIR/RdS/WURYSjaPNuSb
 W00CBrIQ3W21O0iirey++6aFTL1yx2VyB3kC2Zh8bIwT/m5SefcfKkbzocaD+Eorj2Mx
 5BI1bIjV3njJpGcLyE5rmMZPH9JhhHsD5IyGI3KbHziCeU6LzOvuM6jpJr72ymhYUHOG
 BHrivdM6nV21kdKAHZ9nnE3m4XtNCWLxehGadaESm7dWTFxzIG/L00Vx4AtdupPOGKMf
 5VXA==
X-Gm-Message-State: AHQUAuYH3FKtCWJS3Y7MhMtTz6Hc0xvwXp7Ucj2gXS2HNKkM4CZfu1H/
 sBEafikHLI6G+xfSBe6LTwglRz0sD+hfOpvvbdEw/w==
X-Google-Smtp-Source: AHgI3IY+i3iPNRf0lkCuV77xZsU23QrAtPoJon2X4xtGpT07Tf9p//8oHrYpsx85i6UZ8C+QSMmSG3ErzybDAESBhrE=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr11858445wme.82.1549630185604; 
 Fri, 08 Feb 2019 04:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-25-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-25-Zhiqiang.Hou@nxp.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 8 Feb 2019 18:22:24 +0530
Message-ID: <CAFZiPx0Qv6LN6mi4Z9fta2X=Rh85uk7bYGPHmncy=XYgBQOnAw@mail.gmail.com>
Subject: Re: [PATCHv3 24/27] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
To: "Z.q. Hou" <zhiqiang.hou@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_044947_524099_949C00BB 
X-CRM114-Status: GOOD (  19.82  )
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
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
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

ZQ,

On Tue, Jan 29, 2019 at 1:41 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> PCIe configuration access to non-existent function triggered
> SERROR interrupt exception.
>
> Workaround:
> Disable error reporting on AXI bus during the Vendor ID read
> transactions in enumeration.
>
> This ERRATA is only for LX2160A Rev1.0, and it will be fixed
> in Rev2.0.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V3:
>  - Integrated without change from http://patchwork.ozlabs.org/patch/1006790/
>
>  .../controller/mobiveil/pci-layerscape-gen4.c | 37 +++++++++++++++++++
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 17 ++++++++-
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 ++
>  3 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> index 174cbcac4059..d2c5dbbd5e3c 100644
> --- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -22,8 +22,13 @@
>
>  #include "pcie-mobiveil.h"
>
> +#define REV_1_0                                (0x10)
> +
>  /* LUT and PF control registers */
>  #define PCIE_LUT_OFF                   (0x80000)
> +#define PCIE_LUT_GCR                   (0x28)
> +#define PCIE_LUT_GCR_RRE               (0)
> +
>  #define PCIE_PF_OFF                    (0xc0000)
>  #define PCIE_PF_INT_STAT               (0x18)
>  #define PF_INT_STAT_PABRST             (31)
> @@ -41,6 +46,7 @@ struct ls_pcie_g4 {
>         struct mobiveil_pcie *pci;
>         struct delayed_work dwork;
>         int irq;
> +       u8 rev;
>  };
>
>  static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
> @@ -76,6 +82,15 @@ static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie)
>         return header_type == PCI_HEADER_TYPE_BRIDGE;
>  }
>
> +static int ls_pcie_g4_host_init(struct mobiveil_pcie *pci)
> +{
> +       struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
> +
> +       pcie->rev = csr_readb(pci, PCI_REVISION_ID);
> +
> +       return 0;
> +}
> +
>  static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
>  {
>         struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
> @@ -188,12 +203,34 @@ static void ls_pcie_g4_reset(struct work_struct *work)
>         ls_pcie_g4_reinit_hw(pcie);
>  }
>
> +static int ls_pcie_g4_read_other_conf(struct pci_bus *bus, unsigned int devfn,
> +                                  int where, int size, u32 *val)
> +{
> +       struct mobiveil_pcie *pci = bus->sysdata;
> +       struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
> +       int ret;
> +
> +       if (pcie->rev == REV_1_0 && where == PCI_VENDOR_ID)
> +               ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
> +                                     0 << PCIE_LUT_GCR_RRE);
> +
> +       ret = pci_generic_config_read(bus, devfn, where, size, val);
> +
> +       if (pcie->rev == REV_1_0 && where == PCI_VENDOR_ID)
> +               ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
> +                                     1 << PCIE_LUT_GCR_RRE);
> +
> +       return ret;
> +}
> +
>  static struct mobiveil_rp_ops ls_pcie_g4_rp_ops = {
>         .interrupt_init = ls_pcie_g4_interrupt_init,
> +       .read_other_conf = ls_pcie_g4_read_other_conf,
>  };
>
>  static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
>         .link_up = ls_pcie_g4_link_up,
> +       .host_init = ls_pcie_g4_host_init,
>  };
>
>  static int __init ls_pcie_g4_probe(struct platform_device *pdev)
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index e8d0c4989013..5f51bc2dd6d7 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -79,9 +79,20 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
>         return pcie->rp.config_axi_slave_base + where;
>  }
>
> +static int mobiveil_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +                                    int where, int size, u32 *val)
> +{
> +       struct mobiveil_pcie *pcie = bus->sysdata;
> +       struct root_port *rp = &pcie->rp;
> +
> +       if (bus->number > rp->root_bus_nr && rp->ops->read_other_conf)
> +               return rp->ops->read_other_conf(bus, devfn, where, size, val);
> +
> +       return pci_generic_config_read(bus, devfn, where, size, val);
> +}
>  static struct pci_ops mobiveil_pcie_ops = {
>         .map_bus = mobiveil_pcie_map_bus,
> -       .read = pci_generic_config_read,
> +       .read = mobiveil_pcie_config_read,
>         .write = pci_generic_config_write,
>  };
>
> @@ -309,6 +320,10 @@ int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
>         value |= (PCI_CLASS_BRIDGE_PCI << 16);
>         csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
>
> +       /* Platform specific host init */
> +       if (pcie->ops->host_init)
> +               return pcie->ops->host_init(pcie);
> +
>         return 0;
>  }
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 0ccd6cee5f8f..ab43de5e4b2b 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -145,6 +145,8 @@ struct mobiveil_msi {                       /* MSI information */
>
>  struct mobiveil_rp_ops {
>         int (*interrupt_init)(struct mobiveil_pcie *pcie);
> +       int (*read_other_conf)(struct pci_bus *bus, unsigned int devfn,
> +                              int where, int size, u32 *val);
>  };
>
>  struct root_port {
> @@ -160,6 +162,7 @@ struct root_port {
>
>  struct mobiveil_pab_ops {
>         int (*link_up)(struct mobiveil_pcie *pcie);
> +       int (*host_init)(struct mobiveil_pcie *pcie);
>  };
>
>  struct mobiveil_pcie {
> --
> 2.17.1
>
can we have an english brief than having a internal cryptic
number:A-011577, on the patch title?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
