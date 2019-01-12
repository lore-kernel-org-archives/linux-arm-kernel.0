Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D252DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:29:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8C92084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DekL4Vlx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8yimM9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8C92084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g+0PZmHL0kzRuv+fnmjSb5yNFWGVAaf852fst13sz1Q=; b=DekL4Vlxc3D5+M
	hyHb8xieRgmdXDM8nHmtw5Tss1ngyi26YWddURH8vkTwbZ4obutzDYfuapY6IKX9h/N0IBsrdQddZ
	oHBYQMStAfEUtFxJc7J5pm6awQubWPzVA82j5kEJYNwo8fvIE/0x3ZGhrHuHgWU7Qm0f0MSiPre4y
	KfXTLcH46k87Jex1nF5FqLE3xV0pAMdK3M0XtOKxRF1azXkicCyJqgnmwqFPnGyek+n7r6yvNAIps
	gxO9mUWwiV9a81LbpoIlmaP8iBF0BEXSCoBWIj13aejZ/I0QNXR3fp6Qt9QemKx9pnBTuUH5FDzd7
	o4NNjellSLE8IApGGWBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giQq2-00075h-FZ; Sat, 12 Jan 2019 21:29:06 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giQpy-000759-Or
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 21:29:04 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so5483870wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 12 Jan 2019 13:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ooKEQ4ZeSh9S8Oavvq32L6+q3A5n2i2/6WZctBkb0Vs=;
 b=s8yimM9iVaz9pdAISG/qdcdXUnl152PHsRguhegzVx/n7QqqLn3Ni0XG7gJG+eaPNL
 pRUISQ8+BbZ+MRgmm1Eoku9DfwPE3gsnYvUNCYBGaFKffv9ojaHDEwFbg9UvZSg8rXis
 +vkh11IaftcqHLDdq/ZaC+jyKb6SLK7o2VaLSdGCcanbl8oN8yDnUvr9lbISSCwD0gI5
 lc0bxZiVaZUfhPTkpf2cAt58v48Ggn53lPuf0D6WitTIavN6Jugd2Gjsh/L5pCPCh62j
 YFIOVfECz4xZ3yTqAxK/MglYwJ99Vz86P+yGTZx2T4O4Nd2AQM1gI82jTR/Ssd8WLHqG
 Jy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ooKEQ4ZeSh9S8Oavvq32L6+q3A5n2i2/6WZctBkb0Vs=;
 b=Ngm9wftwpxjv7RZ8391ngyS5Yjs76p5EDGdd3xsdDknBtkWnmg5ZXf5AMLcvaOQidn
 F65CHCKkTuHnjqp+D5xIiTN1rgcTH+oeMenPxf12zVsgFkiKs2G6sOwgujyMT+6z9XnG
 DSeBQlmSvHIH4nYDkkunC11bQDUo1UruhRQCdaxD7EuN5byiomuVM3vvPWSh6jwab9oy
 C7hIl7eUH7kLBRFRcrE127JwItTHiG77jGZzZKhLqHwU0a23mYPk5qUyYEXjUf16Jofy
 8c4WBQh9sslMZJ3oDpyIUCJ4sgpWbRFAmpOPutlLtADxooKo8qsPiPmFMovCVKjQoShz
 GusA==
X-Gm-Message-State: AJcUukfnWFN11SK2NUe76gedAUXP2rzDstqBYph5z03ps/qWXlS9Q8w7
 tPhN3Wm7ZuGuCuel0Bq/BEKUhP5DV12xkmfl+/h1k6A3
X-Google-Smtp-Source: ALg8bN7L73/bJgLbupcaiTT+puhQnterhUD7PlF4Bo413G1C/ACmTJmdJXT4aLbtaKGksYdrGuTX8PbjTxxI17fJZbY=
X-Received: by 2002:a1c:f605:: with SMTP id w5mr6983677wmc.116.1547328538576; 
 Sat, 12 Jan 2019 13:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20190104165335.13205-1-andrew.smirnov@gmail.com>
 <20190104165335.13205-5-andrew.smirnov@gmail.com>
 <20190111195302.GA18985@bogus>
In-Reply-To: <20190111195302.GA18985@bogus>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Sat, 12 Jan 2019 13:28:47 -0800
Message-ID: <CAHQ1cqHO=aw0AoLCrO+r7uCG5tE=Ai9or+UAOM3MJ1Cu-fCZ-w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI: imx6: Add support for i.MX8MQ
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_132902_834646_2C3A6A70 
X-CRM114-Status: GOOD (  17.40  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-pci@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 11:53 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 04, 2019 at 08:53:35AM -0800, Andrey Smirnov wrote:
> > Add code needed to support i.MX8MQ variant.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring <robh@kernel.org>,
> > Cc: devicetree@vger.kernel.org,
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.txt           |  3 +-
> >  drivers/pci/controller/dwc/Kconfig            |  4 +-
> >  drivers/pci/controller/dwc/pci-imx6.c         | 77 ++++++++++++++++++-
> >  3 files changed, 79 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index d514c1f2365f..920ca93870a8 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -9,6 +9,7 @@ Required properties:
> >       - "fsl,imx6sx-pcie",
> >       - "fsl,imx6qp-pcie"
> >       - "fsl,imx7d-pcie"
> > +     - "fsl,imx8mq-pcie"
> >  - reg: base address and length of the PCIe controller
> >  - interrupts: A list of interrupt outputs of the controller. Must contain an
> >    entry for each entry in the interrupt-names property.
> > @@ -45,7 +46,7 @@ Additional required properties for imx6sx-pcie:
> >    PCIE_PHY power domains
> >  - power-domain-names: Must be "pcie", "pcie_phy"
> >
> > -Additional required properties for imx7d-pcie:
> > +Additional required properties for imx7d-pcie and imx8mq-pcie:
> >  - power-domains: Must be set to a phandle pointing to PCIE_PHY power domain
> >  - resets: Must contain phandles to PCIe-related reset lines exposed by SRC
> >    IP block
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 6aafec3fad00..83ea318ad989 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -89,8 +89,8 @@ config PCI_EXYNOS
> >       select PCIE_DW_HOST
> >
> >  config PCI_IMX6
> > -     bool "Freescale i.MX6/7 PCIe controller"
> > -     depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
> > +     bool "Freescale i.MX6/7/8 PCIe controller"
> > +     depends on SOC_IMX6Q || SOC_IMX7D || (ARM64 && ARCH_MXC) || ((ARM || ARM64) && COMPILE_TEST)
>
> Since you added the ifdef around the abort handler, I think you can drop
> "(ARM || ARM64)" and enable building other arches.
>

OK, makes sense. I'll give it a go in v5.

Thanks,
Andrey Smirnov

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
