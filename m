Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:46:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7117B2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EADxjboL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7117B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1++kHfNJsHBO+dJwT6jyTdYT1g9nBtqIsQWfBab7oK0=; b=EADxjboLFJq7qE
	SI/PjySJdfO30UIPoFIGsX4fieJlGa07M6vKiJgcLr9eznPXp05M1SvtKCvFFa0IVKzGO0UdCsi+V
	56AgD17ILLgwmenIwr78FXPUSUW4cr6OFGr4HXZztTGm74eeYnlsyvm/hKG+pAZry1kDNwsO56JX8
	LaBjJMYvOi6bGqgzy+vRydSenKD+I3tcD6xS9q9rzjQKQomQCAoVfqoC+/dLtRq1BwRBfSAf+T/5+
	gN2kYPGYuMuxGpJmzGXGZPVlrju8awekk/V/f8l6oe+KCIPSqXPClJWxjJ5r4YPDQxY+b5M5un44Q
	76yZuUerldxChYj4rKNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4nK-0006c5-OF; Tue, 19 Feb 2019 12:46:42 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4nG-0006bE-SK
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:46:40 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gw4n8-0006Zo-7B; Tue, 19 Feb 2019 13:46:30 +0100
Message-ID: <bea67ed9d36e79d87e37056d175318ec5a6e667a.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] "pcie_aux" clock for i.MX8MQ
From: Lucas Stach <l.stach@pengutronix.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andrey Smirnov
 <andrew.smirnov@gmail.com>
Date: Tue, 19 Feb 2019 13:46:28 +0100
In-Reply-To: <20190219124214.GB15442@e107981-ln.cambridge.arm.com>
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
 <20190219124214.GB15442@e107981-ln.cambridge.arm.com>
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_044639_066260_C0D8BEE2 
X-CRM114-Status: GOOD (  15.67  )
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
 Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Bjorn Helgaas <bhelgaas@google.com>, Leonard Crestez <leonard.crestez@nxp.com>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lorenzo,

Am Dienstag, den 19.02.2019, 12:42 +0000 schrieb Lorenzo Pieralisi:
> On Mon, Feb 11, 2019 at 05:51:06PM -0800, Andrey Smirnov wrote:
> > Lorenzo:
> > 
> > This small series adds code to control "pcie_aux" clock. This is an
> > oversight from original submission [pcie-imx8mq-v7], which was only
> > discovered once I submitted an RFC for corresponding DT changes going
> > via i.MX tree [imx-dt-rfc].
> > 
> > Thanks,
> > Andrey Smirnov
> > 
> > [imx-dt-rfc] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com
> > [pcie-imx8mq-v7] https://lore.kernel.org/lkml/20190202001523.12517-1-andrew.smirnov@gmail.com
> > 
> > Andrey Smirnov (2):
> >   dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
> >   PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ
> > 
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt   |  4 ++++
> >  drivers/pci/controller/dwc/pci-imx6.c            | 16 ++++++++++++++++
> >  2 files changed, 20 insertions(+)
> 
> Hi Andrey,
> 
> I have applied it to pci/dwc for v5.1, however it looks like it would
> break the driver with an old dts - I assume that's expected but let
> me know if there is a better way to handle this.

There is no upstream DT using the imx8mq binding, yet. We've actually
noticed the issue due to the DT patches adding the PCIe nodes and those
2 patches fix the driver _before_ we introduce any DT using it. So I
think it's okay not to worry about backwards compatibility here.

Regards,
Lucas


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
