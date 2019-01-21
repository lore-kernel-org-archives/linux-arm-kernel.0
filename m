Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B2EC37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:46:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6FB2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aIl9MZMB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mntmn.com header.i=@mntmn.com header.b="lY31wFTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6FB2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mntmn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PSWp9KAjsq1VJmNMkXHdHoKLoWLzievl8WCEI7euq6s=; b=aIl9MZMBCHFVP8
	sRf7WbAKRBDLPiWzSDQMIVJ1g+lGg3vdFfbI7ESuEaGVSdSZQpfNG2UqZhaiY0uFtuw5gE7zVXrBu
	nzKgwzfL9y2AvV2kEthCL8tv6rkBtUd35GecqU9+AchwCtAAvcBERjom0RWTTmbUNmFwtftxO/1Yf
	OIhnSVg6QwbK4G4bDjnhRaz8gLSaIMwaXqHDAyhKttGpebZXXcC1LnqW379b5TF9mcuCOe+cNqJ3h
	oKc3MhmWDXxm+Z1A7V73MCkeNO++NRxEZVG+IW8vUaciCHgRcrDYAxTLFPpnW9RHh+a1dqFrSPIZ6
	FDr8Gsun6Yti62/e8Qjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glhOJ-0006cK-37; Mon, 21 Jan 2019 21:45:59 +0000
Received: from softboy.mntmn.com ([91.250.115.15])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glhOE-0006bz-F5
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 21:45:55 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 softboy.mntmn.com D798D720CF8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mntmn.com; s=mailout;
 t=1548107150; bh=IeYJzoCkWIMAgyOEWqUe32IVshxydeWpc9GtMkEHj6Q=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
 b=lY31wFTeI5nNbDihE5yIlE8GT60M/XfSw3YHp/PgX8+tYgzplpSnSzVQUkAuV4KGB
 lh2Cltd2sz7EHtNqR3perY+R4jo+amcvt+Z/mQwgzFXdEibyNVYiaFltjmgQ34ovRv
 G8s3svC/K9n+06qKVnicr9+nrBNPSHS5FQoWIbno=
Mime-Version: 1.0 (1.0)
Subject: Re: Linux Kernel Regression in Commit
 3f7cceeab895fcc17ac8db0d9a5e8ca2954b4661 on i.MX6QP
From: Lukas Hartmann <lukas@mntmn.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
Date: Mon, 21 Jan 2019 22:45:47 +0100
Message-Id: <F47CC354-70FC-4CDC-B9DC-56D36E4ABB9D@mntmn.com>
References: <87r2d5yepy.fsf@mntmn.com> <87o989ydc3.fsf@mntmn.com>
 <87lg3dycku.fsf@mntmn.com>
 <VI1PR04MB55336678BA82D08DA1D1D5F8EE9F0@VI1PR04MB5533.eurprd04.prod.outlook.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_134554_669523_E13C49F8 
X-CRM114-Status: GOOD (  15.51  )
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
 Richard Zhu <hongxing.zhu@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Alright, thank you for the quick response. I will try your fix in the morning. Another thing: the second device_link_add() does not assign to link, but link is then checked again for an error. Is that intentional?

Best,
Lukas

> On 21. Jan 2019, at 22:12, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> 
>> On 1/21/2019 10:34 PM, Lukas F.Hartmann wrote:
>> Removing the return(ret) line after the imx6_pcie_attach_pd(dev) call
>> fixes the problems for me. I am under the impression that the
>> imx6_add_pcie_port still should be called even if there was an error
>> attaching the power domain?
> 
> The intent was that imx6_pcie_attach_pd does nothing if no PD is defined 
> in DT but it returns an error instead and causes a probe failure.
> 
> Can you please try the following:
> 
> --- drivers/pci/controller/dwc/pci-imx6.c
> +++ drivers/pci/controller/dwc/pci-imx6.c
> @@ -310,6 +310,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
>         imx6_pcie->pd_pcie = dev_pm_domain_attach_by_name(dev, "pcie");
>         if (IS_ERR(imx6_pcie->pd_pcie))
>                 return PTR_ERR(imx6_pcie->pd_pcie);
> +       /* Do nothing when power domain missing */
> +       if (!imx6_pcie->pd_pcie)
> +               return 0;
>         link = device_link_add(dev, imx6_pcie->pd_pcie,
>                         DL_FLAG_STATELESS |
>                         DL_FLAG_PM_RUNTIME |
> 
> This fix is for PCI, it's not clear why it would also affect USB in your 
> case.
> 
> Thanks for reporting!
> 
> --
> Regards,
> Leonard


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
