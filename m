Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:08:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4225F20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QRIhC3nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4225F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BgW8ahnxbgy4P3mojDreuiICMR4gk/PpxsSJdjqfi8Y=; b=QRIhC3nFt8mb76
	2KBFr/xt0b6bJ2q0KjvIqZ0pwr7+Zdf2tRw/zxcSuc+s6QLR5vdnvDobgzwtKfDjKO2gUKeovnIQc
	WQI67U+bJHTdKzP3xGxSHiu2TtWPp6sTRfOPKIFG1ZEy80PIrVE6vitJ9xu8uMn5SazHrUw3wRv0G
	W6yAZCmwblDplxmyABFozURIqPXXSsIjwGGSQqgBVHB863HHk9nUyl40UDSYnPpKPqRAalbB/lCFy
	vyncfDe2eft8RhpXjg52Ik04SauB3wr18cqrLqB5yB3x9M8cNzHXxBLSMQALySFvUYkTgYDBRZMVj
	ioC9OEQRGF0xY8kVS9zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqAY-00008R-Lk; Tue, 22 Jan 2019 07:08:22 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqAT-00006M-1d
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:08:20 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1glqAO-0005Fp-Lg; Tue, 22 Jan 2019 08:08:12 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1glqAN-0006vh-G3; Tue, 22 Jan 2019 08:08:11 +0100
Date: Tue, 22 Jan 2019 08:08:11 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: Linux Kernel Regression in Commit
 3f7cceeab895fcc17ac8db0d9a5e8ca2954b4661 on i.MX6QP
Message-ID: <20190122070811.js5ooncqzqab63d4@pengutronix.de>
References: <87r2d5yepy.fsf@mntmn.com> <87o989ydc3.fsf@mntmn.com>
 <87lg3dycku.fsf@mntmn.com>
 <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_230817_241637_497F0A1A 
X-CRM114-Status: GOOD (  17.12  )
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Kevin Hilman <khilman@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
 "Lukas F.Hartmann" <lukas@mntmn.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[Cc +=3D generice power domain maintainers and linux-pm@vger.k.o]

Hello,

On Mon, Jan 21, 2019 at 09:12:45PM +0000, Leonard Crestez wrote:
> On 1/21/2019 10:34 PM, Lukas F.Hartmann wrote:
> > Removing the return(ret) line after the imx6_pcie_attach_pd(dev) call
> > fixes the problems for me. I am under the impression that the
> > imx6_add_pcie_port still should be called even if there was an error
> > attaching the power domain?
> =

> The intent was that imx6_pcie_attach_pd does nothing if no PD is defined =

> in DT but it returns an error instead and causes a probe failure.
> =

> Can you please try the following:
> =

> --- drivers/pci/controller/dwc/pci-imx6.c
> +++ drivers/pci/controller/dwc/pci-imx6.c
> @@ -310,6 +310,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
>          imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
>          if (IS_ERR(imx6_pcie->pd_pcie))
>                  return PTR_ERR(imx6_pcie->pd_pcie);
> +       /* Do nothing when power domain missing */
> +       if (!imx6_pcie->pd_pcie)
> +               return 0;

I wonder if it would make more sense to change
dev_pm_domain_attach_by_name et al. to not return NULL and error
pointers. Such functions tend to be used wrongly as can be seen here.
(Unless NULL is a dummy value that in the following shouldn't result in
problems that need catching, but it seems that is not the case.)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
