Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:07:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A378120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4OYI29M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0psl0lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A378120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IjRt8M806LXvX8ZVjvnLBl1HG7gpLmnYTPM8cOzTZms=; b=d4OYI29MPJbVwy
	ymprl8Dkhn62zkF3lCHwzcP5pUMZiBG3XB5kHsbc6Xepa8Ee/1apN4WmCJ45xnO2VmFJ8Y2r5iuZo
	n02cyqhHh4hmbK8WM4unRJ21pRsdascnkUb1Q42ox4iCP3DdPth2c3ovZN25Lnja8l2aLnTqvQ14w
	1q/8NyAMZdD+kNrVcjnurv5nPzoxWpFSIfastob0SGtmxVeZKrHr4k9ht8yOICcAbt8xMz7PCLRSM
	3LCUJnHbt/MV6nyX1+xHY6ZYFjPkc5E/CpCysRK2M7V2N1FcR/gLmdRgOlMut5MUAO0ND4Gx27EZd
	kb/lEqn89f3oMVF4wDUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsma-0005wr-NV; Fri, 11 Jan 2019 09:07:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsmX-0005wP-JH
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:07:14 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1156920870;
 Fri, 11 Jan 2019 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547197633;
 bh=c03KnLRVhxqkvAJEH+UpI8bHHYQylcw3Rv/N9do7y9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L0psl0lDg5YaC43haBO2RlRtFsU2S4IsuWuyN0N758weRzJq7X5wd4XsKXyfMaZHS
 7fsjvE/ngEjxJM5bib3rSUZaMjp3U5am8Jgt2+lrO4dTjXQVGCJ9i84ol47SPE5uRX
 8aFBJVTXd6QNS383DF1efYozdE1dZtLDVrr27TTQ=
Date: Fri, 11 Jan 2019 17:06:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for power domain
Message-ID: <20190111090653.GH32649@dragon>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
 <20190111090009.GG32649@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111090009.GG32649@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_010713_656578_8235C880 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 05:00:11PM +0800, Shawn Guo wrote:
> On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> > SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
> > Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs
> > to reuse the common part.
> 
> This is not the practice we used to match devices with compatibilities,
> i.e. coding the compatible string with the SoC name that firstly
> introduces the device, and use the compatible as fallback for new SoCs.

For example, in imx8qm device tree, we can use compatible below to get
it work without change on kernel driver, while we still need to document
the compatible "fsl,imx8qm-scu-pd".

	compatible = "fsl,imx8qm-scu-pd", "fsl,imx8qxp-scu-pd";

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
