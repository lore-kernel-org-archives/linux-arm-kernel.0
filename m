Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:19:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E2620848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SISa3q2z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0QI9psdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E2620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=my7AS+Y+5K7SOtj5E/GvHiMKMjOJn4V8NNEDjrYUCmk=; b=SISa3q2zNRCoQc
	ea/PY+r2/L9Wj6Q36BQhEuOCGt0r81gKgqDN2gdcXp9gF51eT6Kv+vbJP4rMa/XPl6YmP4q6eHXhz
	hStFMUh5TFGm6SKwb/ZKwTjcr065EvrMOl/GRTD6sFbjKx5QnzQdDMMqypDcCIZhoHiyUYdakAmmL
	QYfdqdSei41jIYeGluU+xWR3N5cegZeWyrsz0xPY6h8p3iaql5qIu6mmH2J3HF7fXbaKgx39n2rwK
	VqUEh0g5gbMUkN+vmQwfOSe1kgnVSHRyiwB93ERbqzA+rcThCS9k/g2Dkb+cUqZr+06hK728TtRJk
	yRkRmg6sDWxeDS7Ge7XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtkn-0001NB-DQ; Mon, 03 Dec 2018 19:19:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtkk-0001Le-0j
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:19:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7453D20848;
 Mon,  3 Dec 2018 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543864763;
 bh=loEs24ZyMoNpy+gMXQJBM7jI49KannDP3YHy75Z7URI=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=0QI9psdXLbnDJstfNoLdBl4aGNAlhaStszy0pkD/ATX/7QarrlIKH4bPG9feQ7FJx
 BwQFn1UbmF7ajle++cjD4jET4lFnc2kQ9dY7JGf4XAKHgGH9cddMRjVkpV69trptoG
 BeF6feuT7a+qYYIzZfpJjDSr+oaUpI1mW5HiryRE=
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203171859.GA12792@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-6-miquel.raynal@bootlin.com>
 <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
 <20181203163846.494904f9@xps13>
 <20181203171859.GA12792@e107981-ln.cambridge.arm.com>
Message-ID: <154386476279.88331.4767594304261181833@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Date: Mon, 03 Dec 2018 11:19:22 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_111934_092155_6CE4F72E 
X-CRM114-Status: GOOD (  23.62  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Lorenzo Pieralisi (2018-12-03 09:18:59)
> [+Stephen, Mike]
> 
> On Mon, Dec 03, 2018 at 04:38:46PM +0100, Miquel Raynal wrote:
> > Hi Lorenzo,
> > 
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Mon, 3 Dec 2018
> > 10:27:08 +0000:
> > 
> > > [+Rafael, Sudeep]
> > > 
> > > On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> > > > Add suspend and resume callbacks. The priority of these are
> > > > "_noirq()", to workaround early access to the registers done by the
> > > > PCI core through the ->read()/->write() callbacks at resume time.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
> > > >  1 file changed, 52 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index 108b3f15c410..7ecf1ac4036b 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
> > > >   return ret;
> > > >  }
> > > >  
> > > > +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> > > > +{
> > > > + struct advk_pcie *pcie = dev_get_drvdata(dev);
> > > > +
> > > > + advk_pcie_disable_phy(pcie);
> > > > +
> > > > + clk_disable_unprepare(pcie->clk);  
> > > 
> > > I have noticed it is common practice, still, I would like to check whether
> > > it is allowed to call functions that may sleep in a NOIRQ suspend/resume
> > > callback ?
> > 
> > You are right this is weird. I double checked and for instance,
> > pcie-mediatek.c, pci-tegra.c and pci-imx6.c do the exact same thing.
> > There are probably other cases where drivers call functions that may
> > sleep from a NOIRQ context. I am interested to know if this is valid
> > and if not, what is the alternative?
> 
> I added Stephen and Mike, who along with Rafael can help us shed some
> light into this, I do not have the necessary bits of info myself, I just
> noticed.
> 

Is the noirq phase of system suspend run with irqs disabled? Or just run
with the device irqs disabled? I thought it was the latter, which is
fine for this scenario because it's still running in a schedulable
context.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
