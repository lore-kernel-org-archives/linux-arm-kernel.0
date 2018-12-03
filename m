Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE6CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:00:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844C820864
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d5bHHumy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844C820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I+m89xP9hHCj3W1uUBi6HFcQx49wRsEb7uGLgV1WRho=; b=d5bHHumyQXwLp8
	uu0vchdda4H7dxcR6dNIV+RJKDQb1gqdE223nTrXJHM8v8B+UiEHSqsDhoX3XlkblSpGCv60gbBIi
	jgKjl49V2qDWRmxNr8GMWjIFT7VlG1WzhlSYR14lDSw9zwFgk54cFmM4+bi6nqOA5iTwqYAAuzobk
	Db9btrIH1CMIo0hoFyK1I00qurxWnp0FC5fnf66Kfx8oBdJBPgeJx6tyba7t2OJof4Jte0H5IO+aO
	4zu9IuaFgINV21fqkMU2FDNae+sxfroquXQq8DSG8FzokFEV8cQtU4eYngDmvdDaPhc1jY33xEHUR
	TvCtJ7XepWV9izyUc2kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTwGp-0002qx-QD; Mon, 03 Dec 2018 22:00:51 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTwGm-0002pj-0z
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 22:00:49 +0000
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 47be791860265607; Mon, 3 Dec 2018 23:00:30 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Date: Mon, 03 Dec 2018 23:00:20 +0100
Message-ID: <1999610.6DN9RK2Tt3@aspire.rjw.lan>
In-Reply-To: <20181203163846.494904f9@xps13>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
 <20181203163846.494904f9@xps13>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_140048_230631_109BE5EE 
X-CRM114-Status: GOOD (  20.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Monday, December 3, 2018 4:38:46 PM CET Miquel Raynal wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 3 Dec 2018
> 10:27:08 +0000:
> 
> > [+Rafael, Sudeep]
> > 
> > On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> > > Add suspend and resume callbacks. The priority of these are
> > > "_noirq()", to workaround early access to the registers done by the
> > > PCI core through the ->read()/->write() callbacks at resume time.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 108b3f15c410..7ecf1ac4036b 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
> > >  	return ret;
> > >  }
> > >  
> > > +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> > > +{
> > > +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> > > +
> > > +	advk_pcie_disable_phy(pcie);
> > > +
> > > +	clk_disable_unprepare(pcie->clk);  
> > 
> > I have noticed it is common practice, still, I would like to check whether
> > it is allowed to call functions that may sleep in a NOIRQ suspend/resume
> > callback ?
> 
> You are right this is weird. I double checked and for instance,
> pcie-mediatek.c, pci-tegra.c and pci-imx6.c do the exact same thing. There are
> probably other cases where drivers call functions that may sleep from a NOIRQ
> context. I am interested to know if this is valid and if not, what is the
> alternative?
> 

Yes, it is valid.  _noirq means that the high-level action handlers will not be
invoked for interrupts occurring during that period, but that doesn't apply to
timer interrupts.

IOW, don't expect *your* IRQ handler to be invoked then (if this is not a timer
IRQ), but you can sleep.

Thanks,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
