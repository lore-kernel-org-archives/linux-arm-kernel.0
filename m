Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F1C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:06:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D616020856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eRmIozhf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7N5Fcj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D616020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:From:Subject:References
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PlTpkwE60EWlU/6CUlfs+vYQMubgMunOpBEyC3Px02E=; b=eRmIozhfurWmn0
	pUNYK3VOFSK7McpEEWW2o931aPNL9CJTdOVrlgfM9l1efcq2+CiIcUW2bk0DAqmPHUqJlD60EMxgF
	3mP8bJ/kSpEzEwo4YxCEW9/FkGrvW6cXSr73kQxfVeU39V8FdJfytcG3rDZW+hvEiWrczJf+W16G4
	adjBseZVa5d3z5zY9WGpsTe5Ho2zIcoDSV0vapZf0OOIiNILuVRjQbLvw/jPNdUNikUi3yqMAo7j0
	nOa1la3GcU9nmN0GAHJ+s1M3rDImgQjxTOUdclkQEf0qVtADwJ2oXJHsFD1k5SRbMPPqTl9zlviEQ
	GLmUq2DvsYJ6dMBONF6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm1NB-0001D9-LO; Tue, 22 Jan 2019 19:06:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm1N5-0001Am-7j
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 19:06:05 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2BA420856;
 Tue, 22 Jan 2019 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548183962;
 bh=xzvDuHF6jb4hWQdIAuWiIOIWXuVQJTrf8uYGoH/XYNg=;
 h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
 b=u7N5Fcj11NX+TDACrCrU3Aq+aLOJ2Pk7LsRAHilDmC3EFfx0Fvbs7LXgvBflYa/78
 WsYdXO0oF0ejPZ8V/OuJuSL2Lmpxi4ouVr/HJ7jDhEi7XcbytluDScX5MBSDRO8tbR
 2BRVw0IcesnTXkjN6lJJM/oWlYvXUBu6zyXdxMd4=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
In-Reply-To: <1547207400-28307-3-git-send-email-aisheng.dong@nxp.com>
User-Agent: alot/0.8
References: <1547207400-28307-1-git-send-email-aisheng.dong@nxp.com>
 <1547207400-28307-3-git-send-email-aisheng.dong@nxp.com>
Subject: Re: [PATCH RESEND v1 2/4] dt-bindings: fsl: scu: add imx8qm scu clock
 support
From: Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818396202.20280.13663727135774413069@swboyd.mtv.corp.google.com>
Date: Tue, 22 Jan 2019 11:06:02 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_110603_485442_D2409CD8 
X-CRM114-Status: UNSURE (   5.77  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2019-01-11 03:56:00)
> Add imx8qm scu clock support
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
