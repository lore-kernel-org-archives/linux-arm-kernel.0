Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76219206B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YkGvuwlb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgCIy9er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76219206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pU5ug+dyFkI13nVIAwXji+GPMexxsfPC+br3ewa1IKU=; b=YkGvuwlb/MsSIS
	0u+MeFdbOmANglNTgcWbDnZV7KToljYeVDwUZm+RMWsMEbaFJvNXlj50bpuATBZocRLiekrgyow/l
	XFlA71R46ISQ/9ggD+Wghjl+pnJ4J7bOm6WTW0P2qkNPF5XdzrCT5Ego56cBJFX7oDJiyeRVlKKQI
	wVNw3/zvTaDXBQLJp+H/0tdkkhVYlR/HSXmweX4I2akmbNnM5R91Eac+LoNh/2CZnQTFznQlcaZVG
	HKXv6/v3ELrqh3rFy8OrXGG1s4NOPG7+Uyw7F9SQyjDXZMVGDuYamhfWigHWF5HUkmZqeXc96YYnq
	N4KV/rWZa8LrOvpjQtpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyhAU-00035J-EC; Tue, 26 Feb 2019 18:09:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyhAR-000350-MA
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:09:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4E55D206B8;
 Tue, 26 Feb 2019 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551204563;
 bh=MalEI9AY4Y/lho68rO7QHAD5Yp5TvsZQXjlzR1sv20g=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=cgCIy9er+0cLpv/pqFMEkg/ppnJvpB+ctidOVRaUpmAnHlt2hapu2RHuGTYqAKOZD
 0KlrEsZbjiMB9y1kdyTw+GD924mow06LOVCprwDKkyYx/dZI8y0hWkt7UIZsHJ8l7M
 7SVR5ZWKilwwNLY4XIOfXLkJGLwYy4ZsF5ieagKM=
MIME-Version: 1.0
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <155120456259.260864.486515032059106989@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
Date: Tue, 26 Feb 2019 10:09:22 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_100923_739429_7BD9A767 
X-CRM114-Status: UNSURE (   7.94  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-02-22 09:07:32)
> Make the entire combination of plls to be one single clock. The parents used
> for bypasses are specified each as an index in the parents list.
> The determine_rate does a lookup throughout all the possible combinations
> for all the divs and returns the best possible 'setup' which in turn is used
> by set_rate later to set up all the divs and bypasses.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
