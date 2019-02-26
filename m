Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AEEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:08:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28A3217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="coX0BfEI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K011+sfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28A3217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:In-Reply-To:From:Subject:
	Message-ID:References:To:MIME-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OE3gyMi/L6XTA9wNtHp2V+GqLcjFO0fo39m0HVeFz08=; b=coX0BfEIAeY+/H
	IafXcakamgTdwA6no7IA8r+9mBu1qUlClD1ITBN1bPjWnEZLhABgKmP+zuwFN3uAWKkyvDPvrCp3V
	NBvpLCi9H3CX7hAojzEd7B4skTpHVV4Kzd+cw7YgEq2QzgysZZnb8BQtVKPJQMfxqauugQY5UPUVe
	jJQcPPU2n5f5JpX0kAGqzid417XvlNauT3eBdSwlYjUMy2y/bJYAemqlYFbPfaAWnMuKT7dqkRDls
	lNXgaRBGefhUUF2jFR1KWXkOgA7NS0aYwiBEvnqYq0DOH6LkXYxrKx8fjxW0cVdUdF1jMvsNBg0tI
	pkfGRxj98ORuIiHrqXQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyh9o-0002of-Du; Tue, 26 Feb 2019 18:08:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyh9l-0002oH-66
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 18:08:42 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D2468217F5;
 Tue, 26 Feb 2019 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551204519;
 bh=6luI78bJ4FYRrCrd9j5W8oBLzCAaME+1lLXedunPT7k=;
 h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
 b=K011+sfjrQJFpSVn8+2/GWdhhs+yGwngpiYn1zyWAriEJmyHOWTTPseavnAwEhJHK
 Zv+MsW7R2fUw598EUTTPROoUbCwOlkPzjBM7Wso31A7Xb/WHxhlrznT1PB2bApUEbx
 pB/YjiLWlr1VK2GY+g29bIr8S4+px8Yw0rOmHG9w=
MIME-Version: 1.0
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
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
References: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
 <1551157967-30925-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <155120451899.260864.1060210942751564859@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V7 2/2] clk: imx: scu: add cpu frequency scaling support
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551157967-30925-2-git-send-email-Anson.Huang@nxp.com>
Date: Tue, 26 Feb 2019 10:08:38 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_100841_245112_F5491550 
X-CRM114-Status: UNSURE (   8.88  )
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

Quoting Anson Huang (2019-02-25 21:17:36)
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

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
