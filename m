Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46048C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:08:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECAD21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dTylZ4mE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbm18p51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECAD21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IsUpz03PLAskToGp2kBAvagb8pyRkawdXQE61PbzHjY=; b=dTylZ4mEmKs+ov
	tZbyBkLclgWF0ja2xzew8RUspNP2zbjZKGYt4i1sPxgQsAgP82dTzEdo9qQjCznmSoOzQ5oacwJxU
	BHXsu3z4z8AzpmoKh74VSAqnPCA/Tl1YrcqWqa89LXMblFmLr0w+zYWw4azvgjLmTYtQpYRZ37gL1
	LPvuLJ3S5J3VdCHKCmlS8V3Dfb5/aOpGQISh85l5aZ191MHoq1t9eRxQGlB6+x3vUxzaez8z0BO9k
	0NPWvEcFZRbKD0uRO8j/xjhmH+6vgqi2YSOn0AkSLgxgMy9QTixFhz+l7jTS/UfNoNRM8e/TCMeP5
	w1u9R21YjhkO9WNyoPwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZdSA-0006yf-Sv; Wed, 19 Dec 2018 15:08:06 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZdS5-0006x6-Hs
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:08:05 +0000
Received: by mail-ot1-x341.google.com with SMTP id 40so19386298oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VbKqp4NchEsk0Y5pDvdp0xLoLpKUrrKeIL2kRETgat4=;
 b=vbm18p51VNbfayvQaSLvBsDz1tDzt531L9luy0YF2BXDewxaLjhcIUgQgsQIOa08aE
 KLlppkBXUQpak9WjYAJ+B7os2j4eNLehJT96+1Bt2LyXf3gTtoDoH16z7TdMmzTTahit
 h1JwsJe4uBf3Ec+a8yxbaVDE60iwh6DjyoN0R/DvwXDhiupVyNy22uua+qp2XQ+JzYQY
 Egrr7xjX85vwBR1dAESmzmL8hwiiCVLxZB8gYc8Ob3MCF6i2afHEZMXblPqNPfwHX7gI
 s4D2Mm9+w1qaySCKimLq5emGOUGUPRLaD4eLDnVOp6dtd5PBL4w4Za+aZQ9lymdDw7IL
 Nb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VbKqp4NchEsk0Y5pDvdp0xLoLpKUrrKeIL2kRETgat4=;
 b=ksxeCgNyv0Vufb6/1C4lx96onaZPLMdAGAOWYdjM+hmH/i9Netg+Wcuv8Hou/CnsjY
 y9COZYFjx/8WBnTuDHRv8OKI2A/G3OVA851dpoCF/3UxSPe3mYCCl9ai+bLBECAPK+s6
 YiJ74QGIeWkTep56cbHtAF8+Z6WUI1xEcXMDYMdLnayoKC2Hx+NW1k+QBM8+498ly5oi
 qAi5yJAR74rcBR98N/r2CHvoG/0kZIJDCUFZ698QIqKNOAVu668ZujELaqb5L4LitZNC
 j5KwUpHIHlJ1BpQCwv/+uZi1kDNPwJ2Zwx7ilJr/ADTFgmBLn2lC1GasQqILdmZAr/87
 4hfA==
X-Gm-Message-State: AA+aEWagCnZcw+i/ORmUbMvnI48y1J0cIA7GiupuLc2KH22E/D3z+LUq
 IqsnniflNVDpBgf6PhjcZ1b6d38Dgp9SHg4mjxv1dKYZmNc=
X-Google-Smtp-Source: AFSGD/VxRmpyCwn19DqVTH7qG9H0Ij68NPQFRQtQugomr5GzLTmc86PyYfEq30W+7n84/CucVOujb5oOO+A52B7gjNs=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr16586291otp.225.1545232070400; 
 Wed, 19 Dec 2018 07:07:50 -0800 (PST)
MIME-Version: 1.0
References: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Wed, 19 Dec 2018 10:07:39 -0500
Message-ID: <CAGngYiW5Y9+_kajQHKahUN-vGFoQvuO4-b0nzzCBSAt2TykQDg@mail.gmail.com>
Subject: Re: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
To: Richard Zhu <hongxing.zhu@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_070801_586772_85409E2F 
X-CRM114-Status: GOOD (  21.53  )
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch seems to fix the regression on my board: i.MX6 with a
tg3-based pcie NIC:
   CPU identified as i.MX6Q, silicon rev 1.5
   tg3 0000:03:00.0 eth0: Tigon3 [partno(BCM57780) rev 57780001] (PCI Express)

Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>

On Wed, Dec 19, 2018 at 12:25 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
> trigger MSI on i.MX6 PCIe.
> This bit would be asserted when CONFIG_PCIEPORTBUS=y.
> Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".
>
> Assert it unconditionally when MSI is enabled.
> Otherwise, the MSI wouldn't be triggered although the EP is present and
> the MSIs are assigned.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Changes v1 -> v2:
> * Assert the MSI_EN unconditionally when MSI is supported.
> Changes v2 -> v3:
> * Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver depends on
> PCI_MSI_IRQ_DOMAIN
> * Extended with a check for pci_msi_enabled() to see if the user
> explicitly want legacy IRQs
> Changes v3 -> v4:
> * Refer to Bjorn's comments, refine the subject and commit log and change
> the PCI_MSI_CAP to PCIE_RC_IMX6_MSI_CAP.
> Changes v4 -> v5:
> * Correct one spell mistake from PCIE_RC_MSI_IMX6_CAP to
> PCIE_RC_IMX6_MSI_CAP.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e563ca9..73542dd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX   200
>
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCIE_RC_IMX6_MSI_CAP                   0x50
>  #define PCIE_RC_LCR                            0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1       0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2       0x2
> @@ -999,6 +1000,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         struct resource *dbi_base;
>         struct device_node *node = dev->of_node;
>         int ret;
> +       u16 val;
>
>         imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>         if (!imx6_pcie)
> @@ -1149,6 +1151,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> +       if (pci_msi_enabled()) {
> +               val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +                               PCI_MSI_FLAGS);
> +               val |= PCI_MSI_FLAGS_ENABLE;
> +               dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +                               PCI_MSI_FLAGS, val);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
