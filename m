Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED21DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:04:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3A52086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ee5oVVFE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdQE6aE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3A52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pz46hw7+hLJC4QXY/ShOCtLpS0h2nvQfBZVoCwdZSBQ=; b=ee5oVVFE+IHA87
	nYIpwAkPaF7FCta5mQjg/muUGg3x5c63Nlki5zJ6R0SdwxoRZSG9Jmzpo8qWPXwXcQzoEEhqeHr1E
	HA8Xl0n/CfB+5xb3dmxc6RGc4MQYNaAPX6lnOK5ADyeJPpb9cq4xNlPm1scmePT6LLceP9jR/9yRK
	swzxyCs3gd7Tcp6pYFfboejyuPRAeO/tk4af6I2cV3srdaIn+F1qpSwdAPSnAEyPEiAZyq/QwMkBN
	qjcfvqcz5Y6lzauZeaoDHfNZGdBUiOMD66a0IzY4S3syoHXVT9mM7pxGsksz145Hg/AaQb1cSVkGh
	q/sfmqd/ucIAZlgfTRhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXucw-0001N0-4C; Fri, 14 Dec 2018 21:04:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXucs-0001M7-Ra
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 21:04:04 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D19B32086D;
 Fri, 14 Dec 2018 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544821432;
 bh=/s9+oLePK1uAbNvVgTRM4G4l5aGyDZxa2ou9T0sNWf8=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=RdQE6aE34DiI7JTWtmpaHHXE7+nl/q3wiw99Eg1CgtRBK6KWSayayJuIrTM6AzJpO
 TIYwWWxj4+OV9nQ/s8z1BYWD5L1wDRY+dAvUN3SnLriGMa8tFso1XyUxo4XZHKTTKr
 nZHkgjwz/4/CD2hxwMnurOuuQugPkfX5K8Pn6oMQ=
MIME-Version: 1.0
In-Reply-To: <1544797224-26627-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH v2] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ
 dependant
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shawn Guo <shawnguo@kernel.org>
References: <1544797224-26627-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <154482143165.19322.12454675199935637811@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 13:03:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_130402_912445_42704A80 
X-CRM114-Status: UNSURE (   7.33  )
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
Cc: Abel Vesa <abel.vesa@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2018-12-14 06:20:34)
> Remove the dependency between the i.MX8MQ CCM clock driver
> and the CONFIG_SOC_IMX8MQ and use CONFIG_CLK_IMX8MQ instead.
> CONFIG_CLK_IMX8MQ depends on ARCH_MXC && ARM64.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next with removal of that trailing file newline.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
