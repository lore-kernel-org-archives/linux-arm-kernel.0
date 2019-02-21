Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB10C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:41:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1817A20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="df2hB/9/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdu92N5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1817A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jaB6XsV9vltv3+Ncxn8oDqeHtQF8x3Xe6Twq8GT3l/w=; b=df2hB/9/y+LmD2
	Tj4FreD3Jp+JchvCksJQdFYL4lY090f4de+gxsIlfQsm2W24Szig19+dN/MzMfq2m30C0q/2vcgig
	LjZb8I1MPsq1Glz+nUnF6viei5OUwCTVoTRrv2MHKXTH3uGXMGJBJiFOWgDBq8FbY1ilnSC1sl5OR
	uDhBRx2J6jI04c6PnkVjANvYpCEy2ofOCaU9p62YGLSGEqd79SG78oQL4EKCt7KGNTA+6RPqBX13/
	RyJ0J/okW6+uQhOlySD7TwhE+V5fishX6hHCNY390+Wk4nMICi8i2Pa4miFsELITLumrPbJ/yXIh/
	kstxOsWfZh13wcm1+Tpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwv9M-0001Hc-Ty; Thu, 21 Feb 2019 20:40:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwv9J-0001HG-CV
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:40:54 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D331D20823;
 Thu, 21 Feb 2019 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550781652;
 bh=kxMFmDnojVNjAj0MDwlaOlC8Zy/gwVqw8RZhK2RvIk4=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=Cdu92N5QvZZUoF1atUl2tHCUzjQjuHGooDn9lnYS4cEUEOUdOhBuqHZUUmPyDABt7
 ICDcSO4xB816rawAUOAMhDnxTG0FV7Wq/7Ghz75Dpk7PaiAFt2wQ6rPjPjAX+bppgz
 X1sJ5DXKMJU5C39gytiLwCvVeDPCevfmrC+qIExM=
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] dt-bindings: imx8mq-clock: Add the missing ARM
 clock
Message-ID: <155078165204.77512.3168550625470285332@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
 <1550252913-24532-3-git-send-email-abel.vesa@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550252913-24532-3-git-send-email-abel.vesa@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, Angus Ainslie <angus.ainslie@puri.sm>,
 Lucas Stach <l.stach@pengutronix.de>, Mike Turquette <mturquette@baylibre.com>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Date: Thu, 21 Feb 2019 12:40:52 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_124053_446056_07813BD3 
X-CRM114-Status: GOOD (  12.94  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-02-15 09:48:45)
> Add the missing ARM clock which will be used by cpufreq
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
> index 04f7ac3..47c790c 100644
> --- a/include/dt-bindings/clock/imx8mq-clock.h
> +++ b/include/dt-bindings/clock/imx8mq-clock.h
> @@ -391,5 +391,7 @@
>  
>  #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK  267
>  
> -#define IMX8MQ_CLK_END                         268
> +#define IMX8MQ_CLK_ARM                         268
> +

This conflicts with Fabio's patch. And also depends on rc6 material that
seems to have gone through a different tree than clk tree. I'm just
going to fix the numbering.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
