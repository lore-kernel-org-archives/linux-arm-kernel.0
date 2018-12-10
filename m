Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042EEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:54:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC1A2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m78erAel";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vlW+Bz/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1A2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lHe5tfXJDLUAlp9idZlpxYLZABM6xecihTJ1OWfmpU8=; b=m78erAel65I4sj
	qHve3b4NorHJgPh9HGCJkYbaFGVqAOR6cEDZIzj5yrLlrydS2TBF/0S7ayrusn8eSHG5LAlgyuwXe
	gye91xU17CzG8554WOt70+1KGj60vhCwqzPsps0Bu3gx3AOpbChfUt3bziGQ4wD+v77krdFFokdkb
	PtaVoBgfF/obsB9ZZtI0s9gjah8AshsDhaDTu6ZW+U2fn3YD/Z+8sFFPcrqaX+ceOwve0XdLPg7CX
	MW1lKCFSH3e9rZ56HZByV2iJkW7uQDrY0xC0njolWU+dYQRuY42SRU/y/mnWF9UvP8EuNVxNU/w99
	Eu2XQ3ZieFquSbEuV3PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWPkz-0000cP-52; Mon, 10 Dec 2018 17:54:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWPkK-0008H9-WF
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 17:54:07 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1CC12081F;
 Mon, 10 Dec 2018 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544464402;
 bh=GTBCF3HE3OCzMGsHWDdAcrV3d8NpVIYzkUVIVDKlqcU=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=vlW+Bz/GjEAl1YLCmvoNy+ApkYCOaAJ2mirUJdyuta2PoRtYmX+nbbyB6VT0iZck3
 cCavqm7gfLOpH/NJQyNLEku/AM6WqQQlkTAHxwKNIF3nbFcaqXGUmkM3UdaVfTzksH
 giHatPUNSxqSGpw9ZsDUUX9XdFxtMdcy1u5OkUJI=
MIME-Version: 1.0
In-Reply-To: <20181209150832.9366-1-colin.king@canonical.com>
Message-ID: <154446440114.17204.3027564849049013270@swboyd.mtv.corp.google.com>
To: Colin King <colin.king@canonical.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH][clk-next] clk: imx: remove redundant initialization of
 ret to zero
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181209150832.9366-1-colin.king@canonical.com>
Date: Mon, 10 Dec 2018 09:53:21 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_095333_796942_956E86F1 
X-CRM114-Status: UNSURE (   7.48  )
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Colin King (2018-12-09 07:08:32)
> From: Colin Ian King <colin.king@canonical.com>
> 
> The initialization of ret is redundant as it is being re-assigned to
> the return value from the call to imx8m_clk_composite_compute_dividers.
> Clean this up by removing the initialization.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
