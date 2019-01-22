Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654ACC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:13:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DFF20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZXfP/ej0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DFF20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nYTSDc+8FPFcRRPkcdqasVFMG9ubzFuFP35CSVEIMms=; b=ZXfP/ej00hGsi5
	sU9eUz0t7vxo2ujBaW30+TUkn5Tu2/Ll83u8H1uZbKHBfNiYUY5cHvuow8tyJXrgqYGSaYNiiR8u8
	Y+NpAplhV0RidlaH1PF0V+kwxmlUlg0vqaTMyrm+UwrEXXW02T18tkblJOXKRKW59GiCKpmEnbysE
	XtXLK3fE7zdoq9br1gQEzNR0g4VxwWJo94+fYC7Xa+fV1YOxexQN+Q85uMiPD0TcFQRYSNga10DET
	wiOWZV+Ge41UIUfAGTRMRXdu5E4LiZRIojoAm8O8Ie7Oav0ehR6MpjWG0fluc1KzNhNRuAakvT1bU
	ZpvoaaIup52dmw0LTdMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqF2-0003TE-Kx; Tue, 22 Jan 2019 07:13:00 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqEz-0003Sj-5c
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:12:58 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1glqEu-0005ki-8J; Tue, 22 Jan 2019 08:12:52 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1glqEt-00072w-Lr; Tue, 22 Jan 2019 08:12:51 +0100
Date: Tue, 22 Jan 2019 08:12:51 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/2] PCI: imx: Fix probe failure without power domain
Message-ID: <20190122071251.tgdwnunxksa45n5q@pengutronix.de>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
 <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <375a852ae9170a5f8f53fdd364a7fb7ea642e89c.1548110502.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_231257_365991_AFE18293 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Lukas F . Hartmann" <lukas@mntmn.com>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 10:50:04PM +0000, Leonard Crestez wrote:
> On chips without a separate power domain for PCI (such as 6q/6qp) the
> imx6_pcie_attach_pd function incorrectly returns an error.
> =

> Fix by returning 0 if dev_pm_domain_attach_by_name doesn't find
> anything.
> =

> Fixes: 3f7cceeab895 ("PCI: imx: Add multi-pd support")
> Reported-by: Lukas F.Hartmann <lukas@mntmn.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 3 +++
>  1 file changed, 3 insertions(+)
> =

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 52e47dac028f..ac5f6ae0b254 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -308,10 +308,13 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  		return 0;
>  =

>  	imx6_pcie->pd_pcie =3D dev_pm_domain_attach_by_name(dev, "pcie");
>  	if (IS_ERR(imx6_pcie->pd_pcie))
>  		return PTR_ERR(imx6_pcie->pd_pcie);
> +	/* Do nothing when power domain missing */
> +	if (!imx6_pcie->pd_pcie)
> +		return 0;

As I said in the mail that proposed this patch for testing: I think it
would be better to change dev_pm_domain_attach_by_name to not return an
error indication by returning NULL or an ERR_PTR value. (Or change
device_link_add to accept NULL if NULL is a dummy value.)

Just repeating it here to have it near the actual patch.

Best regards
Uwe

>  	link =3D device_link_add(dev, imx6_pcie->pd_pcie,
>  			DL_FLAG_STATELESS |
>  			DL_FLAG_PM_RUNTIME |
>  			DL_FLAG_RPM_ACTIVE);
>  	if (!link) {
> -- =

> 2.17.1
> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> =


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
