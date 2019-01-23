Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37718C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:39:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30D121019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fAYAKhOf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBXmFMG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30D121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SD7gi/ywQ4tJ+xlQBUZLwEbHSDKE6WliBGhQqrlFFIU=; b=fAYAKhOf57/t1i
	yWEJjeiJzv12GtXIQjAMJFe3Fs2LZRsmsryaC21Wrga85LMhyTtXl88oR0in+9ke87bybCbk8z2iR
	wDuFGMBpBW4I/K84iwbz75CzlxG1X1iTD05VXfy/I1QmuC5+Mau9DoFhHNovyXigv1IS34SfNIedN
	a2cJETvZNmE4I5WR8NZOmmRNcFQT39aGBGnGYX/AlYbj7UMCdB55C476Y6FTkYeggb3B7GbIPobEv
	SxRsPjH1zKod4+uMatOGX/GAvwDMjQFuEzjT+oj9OHYKJsCjffhiNiW5VldR5FPDdkrRGg+O5otPr
	RD4Gc9EOtg4R9OONZ4EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFwK-0004nb-7P; Wed, 23 Jan 2019 10:39:24 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFwG-0004nG-Od
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:39:22 +0000
Received: by mail-lj1-x243.google.com with SMTP id l15-v6so1454945lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JNpQ+/5iwZyTvORBp3CtrwihaTdurJBDQSvMmysi55Q=;
 b=MBXmFMG/qdjgPNRoI52FDu9AtF3UzC31yd0HImQHdbkqkRt+niWYOAf1WL4F4l3uko
 drrOO9C11JLOjK6hhkwV/RuObeyi/sHze3ii8uLcEr1Y/Srt4h90Zw6kYUAVZuROsMDD
 WN2wEkvqDlt52/7rl1f2jl8n2KPZXDU96f7wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JNpQ+/5iwZyTvORBp3CtrwihaTdurJBDQSvMmysi55Q=;
 b=SX2H+f/ybdo0Hz7Zu1YYhtZuCweU7OoWwL3WfzmCSDahI2RqAxVx8/Ta6aQ4QFihF0
 5AX0/qBLuCFEigt0IorFw+oRseh/HWKLPuF8QYd1DJ84jsl2P9byQqUH6vxSn6g0Er7m
 br6gcupyOrjtut30kjB01QGCMdpusGSUc5fJMtBjOdQtE2jQ4Lw+NcOvw4JzpRMdlaMp
 44e4SMKup9VvOG5vMjmVK3sac0Pel49QwyGi0YFKUswZfba/YenbzxO16lji2KFezEu/
 sTqHA0oaejhDD3kVO3+IvlB7UkOmbizQsCd5g/CBivcuyQ784DAGQMeDjUKYMvAvmiKf
 pYXw==
X-Gm-Message-State: AJcUukcizDVPMwhmUl5bz1EzKpK3jGT1f+FV0aNTKNSwwOZwU69iMw29
 cXm9VWqIMGQVcVat5MR3depQA2OKLFE=
X-Google-Smtp-Source: ALg8bN4e+TmTMymXuBlMst/uhjKRf2kDvrVOeBslE8bGY+MOrLqFt+SGD3cZHLgb1hvcWmXNr8L9gg==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr1446575ljg.67.1548239958143; 
 Wed, 23 Jan 2019 02:39:18 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
 by smtp.gmail.com with ESMTPSA id
 o17sm412116lff.77.2019.01.23.02.39.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 02:39:17 -0800 (PST)
Date: Wed, 23 Jan 2019 11:39:15 +0100
From: Niklas Cassel <niklas.cassel@linaro.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH net-next] net: stmmac: Fix return value check in
 qcom_ethqos_probe()
Message-ID: <20190123103915.GA20558@centauri.lan>
References: <1548224358-83281-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548224358-83281-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_023920_802526_029B4057 
X-CRM114-Status: GOOD (  16.13  )
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
Cc: Alexandre Torgue <alexandre.torgue@st.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 06:19:18AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_clk_get() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
> 
> Fixes: a7c30e62d4b8 ("net: stmmac: Add driver for Qualcomm ethqos")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 30724bd..7ec8954 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -473,8 +473,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	ethqos->por = of_device_get_match_data(&pdev->dev);
>  
>  	ethqos->rgmii_clk = devm_clk_get(&pdev->dev, "rgmii");
> -	if (!ethqos->rgmii_clk) {
> -		ret = -ENOMEM;
> +	if (IS_ERR(ethqos->rgmii_clk)) {
> +		ret = PTR_ERR(ethqos->rgmii_clk);
>  		goto err_mem;
>  	}
> 
> 
> 

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
