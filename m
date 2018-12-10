Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F82C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:46:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE6420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Dmr0uvbh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMYKMAvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE6420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTEDUfMbfopgis1oYQ4aQX27UObwmbdKKxKWeh/cYTQ=; b=Dmr0uvbhlg2rrL
	Ab5CUeW9Qyq8seaNCDCv+3UiJeM2AkM3ZGV/oUeMb8pMZa4MQptDpzT/t/RvtHEFt8B052wUNetGi
	rERxiPiYK+QEzElmOTLXzhbEhsgiEVM/j0xfJM3bbf4PxIBwzGwQOh7hjr6CEHHqf520743qDG1Gs
	dOsfI+w818XdVm1PPdrNVnGj7oDiBWT5xX+yj4hZo7QUfEwNxIa/l7F2D6ouYBrhEbN5JUTZQdEId
	+CtMkR+6FsXZLFPRa3sdfvnYonu+1FDsd4H+mEXseDiHX6mtBW0oVDv/GLNubJC5H2R6/FIa4sWKh
	eCFaZ6lQdhkdx6FlPx8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSS6-00013I-Rk; Mon, 10 Dec 2018 20:46:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSS4-000130-AE
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:46:53 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C262B20821;
 Mon, 10 Dec 2018 20:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544474801;
 bh=v6KLg2JHl6yFVWM2TxvKndCENnlqXCmnWe9h0/GyjtQ=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=hMYKMAvoXQbnTILiEMIbaG0Fo4PixP7wzaVsJ67DgrgySou+D+A/i+YpsR6lqiVL4
 Tt1j8DOR0268vnD8CxFhTDE2oMj4HdvnqdbL6tPTYouUGXz822rhFlPeWr3lu2Ty2c
 cxh9YSPGlX4uRaULe0jlhAPHtzSpIFnNVdSnuL3w=
MIME-Version: 1.0
In-Reply-To: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154447480107.17204.18337865638259063687@swboyd.mtv.corp.google.com>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
Subject: Re: [PATCH V9 0/7] clk: imx: add imx8qxp clock support
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1543934041-12572-1-git-send-email-aisheng.dong@nxp.com>
Date: Mon, 10 Dec 2018 12:46:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124652_365632_FCFD5C75 
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
Cc: Aisheng DONG <aisheng.dong@nxp.com>,
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

Quoting Aisheng DONG (2018-12-04 06:39:18)
> This patch series adds i.MX8QXP clock support which is based
> on the clock service provided by SCU firmware.
> 
> Note: It depends on SCU driver which has already been merged by Shawn.
> So this patch series could go through Shawn's tree as well.

Which patch series?

I'm having trouble applying the first patch, so I suspect something is
wrong.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
