Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8C5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:02:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C7F2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B2ohok42";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBJhQAmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C7F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y4gr+F0YdXeGQpv/MDMBVIkWoHgNVI6BiW90E1N1I04=; b=B2ohok42bPkplr
	JbtwK9Kt1m8nTCXPeRFeJLiKcaZvTd1nHaI3IazV6mcRcVIEoNAstVT75uPWQASC/lh9tbTviKWES
	ssUP1KDG9kLc/JevvCsjdWkepP3+B78Jjg138rgItRKpySW/CD2tGPcWF0GlLYV70lzX3viEX477A
	+otzMWcaClcYj5ZzxGI6w2JnEpO3N2MpYMXNRIMJsfEK93C7JTPmngPLk9ZYYTeh/BvUFxjeVpFrO
	9EVaY+ejWhCsUHqh6VJhLP3yYhzmirrq+g55y45LUg+cTNJaFLGtyN2V1BTilQ2tE1y2zwLX2V66w
	BMlG6PzS076LqBUWpG3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwZ0C-0005UE-0D; Wed, 20 Feb 2019 21:02:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwZ09-0005Tq-F4
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 21:01:58 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BB542146E;
 Wed, 20 Feb 2019 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550696517;
 bh=RR+SZ56OZJgS3II6s2wzaViX6OuPLHUf7ImNWjhAkX4=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=WBJhQAmUoDQ8EwSdkQlyzbQChr0qv7aLtJXEhXkz7eUHUk6Gkam+9wS//m/x0uKQQ
 iDkIjgBiiwFQiegkV4MQoSV2gohyb/ye2DmlmkErbKcEZiFfnZIMwXNU78iXeg3DRd
 J81imxhWApucEk47eWgLmb53b7jHSMx3eHklebgg=
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] clk: imx: scu: add set parent support
Message-ID: <155069651632.77512.3946236932583154798@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548855205-12249-1-git-send-email-aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548855205-12249-1-git-send-email-aisheng.dong@nxp.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
Date: Wed, 20 Feb 2019 13:01:56 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_130157_520978_0A28DF62 
X-CRM114-Status: GOOD (  10.61  )
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
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2019-01-30 05:39:15)
> Add clk scu set parents support.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied to clk-next + below

> @@ -173,6 +208,49 @@ static int clk_scu_set_rate(struct clk_hw *hw, unsigned long rate,
>         return imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
>  }
>  
> +static u8 clk_scu_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_scu *clk = to_clk_scu(hw);
> +       struct imx_sc_msg_get_clock_parent msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +       int ret;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_PM;
> +       hdr->func = IMX_SC_PM_FUNC_GET_CLOCK_PARENT;
> +       hdr->size = 2;
> +
> +       msg.data.req.resource = cpu_to_le16(clk->rsrc_id);
> +       msg.data.req.clk = clk->clk_type;
> +
> +       ret = imx_scu_call_rpc(ccm_ipc_handle, &msg, true);
> +       if (ret) {
> +               pr_err("%s: failed to get clock parent %d\n",
> +                      clk_hw_get_name(hw), ret);
> +               return 0;
> +       }
> +
> +       return le32_to_cpu(msg.data.resp.parent);

Sparse complains about this line because it's a u8 not an __le32 that's
being converted. I removed the le32_to_cpu() to fix this.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
