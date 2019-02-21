Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B338C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BA92083E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cvn0UrvA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyZuSNgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BA92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gJQwgFr9g2keuk2WQwLJJDf7FXZtlBxf2gmX7Jyjh1Y=; b=Cvn0UrvA3PNPWL
	SKbEgCQsCROEtPHd+lkiX3r6KveJ9YIpsiIJmIZqOwOaFTXfxbPWo20AggOZMzLBDAuMglWl7JYJD
	tdlWetomT6XlnzMjIx11pkhjqtib/aT8IsFGIG3Sc17HJWv3qVblkVrMCp2dADhp3fI2zHsLkyaZ4
	CdQ8e32eWee4edARJ6VsKmOFfTcKUHqX9hYvD08t3bzxWIMt/ejrU0R0Rbf9j3TV4yrdhY1jab3ob
	A01cpS/h6LJDEK5W7RtRnuMcQj5uRSSPmD7YO6NsLNgJOLdjTOs9zNoWSXywyoNG1/c63NoAk+FVi
	qoshGB1jIh/cvBOEUpNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvGj-00057v-R0; Thu, 21 Feb 2019 20:48:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvGh-00057T-19
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 20:48:32 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF47A206C0;
 Thu, 21 Feb 2019 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550782109;
 bh=D5uAlfH5MQ+LUH+dDsqRfPtFiwt8vEAS50I5eHRaTLA=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=FyZuSNgTkyV8pMBr7s41jFRncLjFM6I1iWWOcUGoEC1FjptbwxmEqN985s1eZXLhd
 WygzNYYT1q+IkCu8WIjsQmcSjIw3KaoEMaYJQIIWMgO4WbqElBgBAYN49+OhUmgTie
 4ZUoSMHr6b+1K4UG/OD3zPMgUMhT5WiStAGNX0TU=
MIME-Version: 1.0
Subject: Re: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155078210899.77512.5319038009555276321@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
 <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
Date: Thu, 21 Feb 2019 12:48:28 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_124831_092251_58F1DB4D 
X-CRM114-Status: GOOD (  11.18  )
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

Quoting Anson Huang (2019-02-13 17:54:08)
> On NXP's i.MX SoCs with system controller inside, CPU frequency
> scaling can ONLY be done by system controller firmware, and it
> can ONLY be requested from secure mode, so Linux kernel has to
> call ARM SMC to trap to ARM-Trusted-Firmware to request system
> controller firmware to do CPU frequency scaling.
> 
> This patch adds i.MX system controller CPU frequency scaling support,
> it reuses cpufreq-dt driver and implement the CPU frequency scaling
> inside SCU clock driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
>         - use different clk ops for CPU clock to avoid runtime check in clk_set_rate;
>         - use rsrc_id to determine whether it is CPU frequency change and also to get
>           cluster ID for SMC call.

This directly conflicts with a patch to add get/set parent support from
Aisheng Dong. Can you please work together and rebase the patch on top
of that patch (which is in clk-next) and resend this?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
