Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B376DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:31:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8237D217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ro9JCw1S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPMTbnSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8237D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rW6OzYugG3rAWuUpejQSRFiZu89v59ZF7QYKB8MarLc=; b=Ro9JCw1SVFm1Qr
	WLGSqu5clwYblpcn4EGGf6GfkJJVMLvfuWRyVwy35RLbKR/ASf+vUdRrqeZyBsF4AIpAoaMviwusX
	J5/d92q+7bej4yf5HkE7i+FNs+U9jZaO77wwV0RsDHC/eRGxYvB9Zljr233GPTuKGEuJazSvXleca
	bVmoll6Tsxu112Sq+ijcCPvy1BP/DHyaYweAmytY9rsmFTtOMo6F86Qy7AFqEcBE41KGmD6/ynIzl
	3BMZfHLwEby5VlVLX/ATccVBUMuZ5X+PsJKREJMJEbstzQ9nJNAIwle+4BHr19ppUNTW6fZ3DWy2X
	P90YGbsbFtsDo+jk5MYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDwe-0003av-NR; Wed, 23 Jan 2019 08:31:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDwa-0003aX-OU
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 08:31:35 +0000
Received: from localhost (unknown [27.59.118.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E949520870;
 Wed, 23 Jan 2019 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548232292;
 bh=35JkuCRBLqzhVCFLw+uVScwMfnilUYp++bCkbZ967qk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PPMTbnSulY72wEC7QTS0QkY6rJ8iL5GPfxMt3BDc8yAg6hVQPw6IrAkDSuzTaHAFv
 AeJPwSz904Cv/3xuvFYUAE6mSMTP3ymTFBopS417B+Ful0yEyAmN1pZReZlNXRidOD
 VKIS9kHVIS6+ic+yuHSnEnIHYp3BiIz5lOp1PzPU=
Date: Wed, 23 Jan 2019 14:00:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Wei Yongjun <weiyongjun1@huawei.com>, davem@davemloft.net
Subject: Re: [PATCH net-next] net: stmmac: Fix return value check in
 qcom_ethqos_probe()
Message-ID: <20190123083001.GL4635@vkoul-mobl>
References: <1548224358-83281-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548224358-83281-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_003132_811035_5B8BA678 
X-CRM114-Status: GOOD (  14.43  )
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
 kernel-janitors@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Niklas Cassel <niklas.cassel@linaro.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 23-01-19, 06:19, Wei Yongjun wrote:
> In case of error, the function devm_clk_get() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().

Acked-by: Vinod Koul <vkoul@kernel.org>

This is a networking subsystem patch and you missed Dave :(

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

-- 
~Vinod

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
