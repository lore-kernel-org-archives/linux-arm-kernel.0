Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDCEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:42:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B8A2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dWLodFHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B8A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vY+cQuXONYqJjo/3khDK8xv3sHmu+Udx5aZzM8kA2eU=; b=dWLodFHUygyFQu
	IGldBkvYU7R8VGRHimVRpcQfKpIzRtbVWoApo/sAS2h9XhY3LtPC4doNPsQn/GyA+ZbkIXwugrCAZ
	jaWaNJxaZCSa5AVefIdXETo1xPa+hbhpCCeGgQa8HmoPNmf7EJYKjdAax/PSkdX8a+YocJ5ShL+Yu
	YxoGhefD+h4ZaSZHSlaRRkYX1Hv7EmY41YPxr+BhUrpbz0sAhmVIK8t3/+LQyrJbS6kK1vjQ0iwTq
	pDeGPNHGGlIq4Q0i5nPJMWEIeay1zlThaIlV92KbkywdQameBssn3vqvzTvJoC++U8IrI2JiQGZQC
	8xY+2oa4JuLnuojRk6Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4jB-0004e1-HM; Tue, 19 Feb 2019 12:42:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4j7-0004cv-Fx
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:42:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE542EBD;
 Tue, 19 Feb 2019 04:42:19 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542673F720;
 Tue, 19 Feb 2019 04:42:17 -0800 (PST)
Date: Tue, 19 Feb 2019 12:42:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 0/2] "pcie_aux" clock for i.MX8MQ
Message-ID: <20190219124214.GB15442@e107981-ln.cambridge.arm.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190212015108.16952-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_044221_540189_8B9C6F49 
X-CRM114-Status: GOOD (  14.54  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 05:51:06PM -0800, Andrey Smirnov wrote:
> Lorenzo:
> 
> This small series adds code to control "pcie_aux" clock. This is an
> oversight from original submission [pcie-imx8mq-v7], which was only
> discovered once I submitted an RFC for corresponding DT changes going
> via i.MX tree [imx-dt-rfc].
> 
> Thanks,
> Andrey Smirnov
> 
> [imx-dt-rfc] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com
> [pcie-imx8mq-v7] https://lore.kernel.org/lkml/20190202001523.12517-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (2):
>   dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
>   PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ
> 
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt   |  4 ++++
>  drivers/pci/controller/dwc/pci-imx6.c            | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)

Hi Andrey,

I have applied it to pci/dwc for v5.1, however it looks like it would
break the driver with an old dts - I assume that's expected but let
me know if there is a better way to handle this.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
