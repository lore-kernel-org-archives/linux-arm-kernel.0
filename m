Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A907C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC4320873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PkS0MHlG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Wkrxx3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC4320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dWH/H7yZtMgyPag2OCqxdK1zMYUxa+gPwcd7QDzYbHc=; b=PkS0MHlGUNbhWU
	eSeQ4seh3n3MnNNZWG659SeYBpQoiBlyl3BWpJrajYSGykoX4+zi8v9xs6NEgrIQJgTg9IAwzZeqB
	mRU8RNiChvWDJGMJ8jsjRSG403BK38YWKHtbjuvBd00OoAOA6xF306Jg0b4TyAzIsfaeKtPlfwOsN
	6rpHVrWIPEbW96j+14qMxT0Yu/RMYflfJNYhYnz2qgBfy6W6TFP+g1E7CVnhnyS+e4mglSN20lm8e
	9tRX59dIlcnNMOq+uzvoFIGsEaYAGpF2qO/DQu2Skd12HgZP30/Ita2snE01EnV0l+7hUEf6FPd0T
	JFeGclp9jsk4H/AjtiqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXLjJ-0007ri-7x; Thu, 13 Dec 2018 07:48:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXLjF-0007nS-Ns
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 07:48:18 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B2D12080F;
 Thu, 13 Dec 2018 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544687287;
 bh=Q3r/jTCRwkDt0ZVETnTYMmZNfuTM51IOe1RFi0X0ARw=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=1Wkrxx3arIw1W6AJ2XRJb0I2Y8q0ABHHEfj/4DhC5IYVwIV/f37+j8u3qiqd8y1CX
 cvqrDYkDpH+XQr83UkH3f/CYQ3KqZZsbMzH4Hz3mTXg+UYoR0NjF+3DtQ4fZRUr7h7
 w2t5UetQSt0a0RvJukXEP1gR2TlGrTVs74vAHyfE=
MIME-Version: 1.0
In-Reply-To: <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
Subject: Re: [PATCH V11 2/7] clk: imx: add scu clock common part
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544662938-5020-1-git-send-email-aisheng.dong@nxp.com>
 <1544662938-5020-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154468728640.19322.12955855783518519739@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Wed, 12 Dec 2018 23:48:06 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_234817_789738_92F9A493 
X-CRM114-Status: UNSURE (   9.38  )
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

Quoting Aisheng Dong (2018-12-12 17:07:55)
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 37478ba..5c26f4e 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -3,3 +3,9 @@
>  config MXC_CLK
>         bool
>         def_bool (ARCH_MXC && !ARM64) || (ARCH_MXC && ARM64 && SOC_IMX8MQ)
> +
> +config MXC_CLK_SCU
> +       bool "IMX SCU Clock"
> +       depends on ARCH_MXC && ARM64

This should depend on the IMX_SCU config too, right? Otherwise
compilation will fail.

Plus, I can't seem to compile this driver regardless, because the
defines for the CLK messages are in some header file that is just
included in another header file, and that is all going through another
tree. Why?

Is there any reason why those defines can't just be written in the
clk-scu.h file introduced in this patch?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
