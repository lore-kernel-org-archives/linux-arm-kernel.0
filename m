Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C618C20815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 03:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rgg2uuHx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb3wkYit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C618C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MnLzMFLbg6GP28TltBik/c2LSNeZ72fLrAqe4dDkebc=; b=rgg2uuHx980IzN
	CXnkpTy49GByhpmg9xqPB3MUUIoOpFzba0Fmuh/j/WpPXZtlioTN1BwYRofNZPmCqOzdP8zcUJbfD
	f3PGox2Ls5bOp/BbRQ3XCyTFylv+24cYNRluetYhtd2ekVR4koEjNcSkZADkr56aPWC2ZiKMPzW1z
	1fKNhgTgQM1YehUrS+Pn2YNNJW7zB+K4RDZYMp3N1xjU2gK9LXnN+HJpX4M3VTAkE62jGkp2GV/Fj
	mwBZRZUpcWTrm9QMlysZFwsEQE57LjqUx2wRxpTIREW3Vj6QW7h+hCb1Qfc2ThZ+27UcqHm3sqqp8
	lQAKX2YKeO+D4OCfTXjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpPVd-0001QM-5L; Fri, 01 Feb 2019 03:28:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpPVE-0001A9-21
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 03:28:29 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 603E220863;
 Fri,  1 Feb 2019 03:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548991707;
 bh=6IRQ6TE7MoOGbgZSTXbJ+AGEA8navF+oYn+tcMg5YwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mb3wkYitQJn+UYktH7AmTDRF3pb+XBszzsQEtobymtORbCX/XSbut0bcBUGzhZ0kK
 bmG9QxqCdysLpsiJy6yXv+w8ml9A/jymjHz/o7JUeuaL5W3VTGx96HaCMIS2HxMO/U
 fa9Ewm8hH73bXs5DcPRqDHfJwrjriM7aqFFWmE6w=
Date: Fri, 1 Feb 2019 11:28:17 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 0/5] Add Oxalis board support
Message-ID: <20190201032816.GD19882@dragon>
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_192828_112577_5D5EB927 
X-CRM114-Status: UNSURE (   8.29  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, leoyang.li@nxp.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 09:51:42AM +0530, Manivannan Sadhasivam wrote:
> Manivannan Sadhasivam (5):
>   dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based
>     boards
>   ARM: dts: Add devicetree compatibles for LS1021A based boards
>   dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
>   dt-bindings: arm: fsl: Add devicetree binding for Oxalis
>   arm64: dts: freescale: Add devicetree for Oxalis

Applied all, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
