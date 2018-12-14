Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF5DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:04:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C562B2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JNmVNKUl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9j7xXR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C562B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MM8PHg9XsDtLOWU/9U//sPFLlN1kFBe+yDzWLpaj+/0=; b=JNmVNKUlnuUpF/
	Yrik0DrUudk4eOBgsdfAgZNBxjzhtSjRB/etmJKxDz894VKFhGyQ3K4O1mUqoZXzTGjGmNsLWqKKy
	TBdDpEDNF+mpkR+XM4ZTdzBHkrjE1ufip5IffrLou0ZH20mEUWMkbWnAcy5Qv0vFyRipzfC5uG828
	PWgOl/bbu9oe9xnQfHDW7JtMOrzR+40MBVJ7evQjlWwlPZDFbcQZRA1OzyD98kBXQ+Wc06YwiBvA3
	Z+CZwL/SHInP7Rj6vlUFo3QZf/21c/M/DJDm5Tm//tGqo66HIHyRMyH70ACn+5pWmDk3d+W5f1TXR
	xZGVvMpPpd/1cMPEOcrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvZp-00082n-Au; Fri, 14 Dec 2018 22:04:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvZm-0007wK-AK
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 22:04:55 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BDD42080F;
 Fri, 14 Dec 2018 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544825084;
 bh=NLwTeu7fdWAbV8YgHfUMzhi344wmzGw+2qdSCrS4GLM=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=u9j7xXR+uTuo19BJ8loI1aqbYjhmWD48YyWABxmnXAf2uJkEGznTQFwhNB7N2/k3c
 NY0ynkm2D/N7xiD7iD4goNnj47aSIwWWFkHA2viPOcU0e91tAbc9vrdz20247aSkNu
 6a7LAoSg8FyKx1LqhEoyQi0ijx6IyLN69WCUSz0o=
MIME-Version: 1.0
In-Reply-To: <1544176659-32022-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 2/3] clk: imx: imx7ulp: add arm hsrun mode clocks support
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>
References: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
 <1544176659-32022-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154482508301.19322.1653003805163251008@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 14:04:43 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_140454_378610_A8EA697B 
X-CRM114-Status: UNSURE (   8.20  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Anson Huang (2018-12-07 02:03:34)
> i.MX7ULP has a Cortex-A7 CPU which can run in RUN mode
> or HSRUN mode, it is controlled in SMC1 module. The RUN
> mode and HSRUN mode will use different clock source for
> ARM, "divcore" for RUN mode and "hsrun_divcore" for HSRUN
> mode, so the control bits in SMC1 module can be abstracted
> as a HW clock mux, this patch adds HSRUN mode related
> clocks in SCG1 module and adds "arm" clock in SMC1 module
> to support RUN mode and HSRUN mode switch.
> 
> Latest clock tree in RUN mode as below:
> 
>  firc                                 0        0        0    48000000          0     0  50000
>     firc_bus_clk                      0        0        0    48000000          0     0  50000
>     hsrun_scs_sel                     0        0        0    48000000          0     0  50000
>        hsrun_divcore                  0        0        0    48000000          0     0  50000
> 
>  sosc                                 3        3        3    24000000          0     0  50000
>     spll_pre_sel                      1        1        1    24000000          0     0  50000
>        spll_pre_div                   1        1        2    24000000          0     0  50000
>           spll                        1        1        2   528000000          0     0  50000
>              spll_pfd0                1        1        1   500210526          0     0  50000
>                 spll_pfd_sel          1        1        0   500210526          0     0  50000
>                    spll_sel           1        1        0   500210526          0     0  50000
>                       scs_sel         1        1        0   500210526          0     0  50000
>                          divcore      1        1        0   500210526          0     0  50000
>                             arm       1        1        0   500210526          0     0  50000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
