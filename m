Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:40:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8F2222DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aC/pUPS2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2LmySMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8F2222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nlkb4STo25VwM0BVEMaVa290LGU1923UnSRCLic4wqs=; b=aC/pUPS2oMRP/Q
	JDQ4M6poznN5mKWqLWGaoRoKhaR4J/7cxa0o16CkpIukbpoAxBXZKK8r/S5VKtX96m5krVsK+Xvwx
	Y91gS3i+0rB3O++5aQGRnvTgRyCzVVtuhaRQk2KkM34zL+RRCxQDvjte1ey9bXUqCktz2fCrdPiL+
	vqcK6ZhSDwwMwydNtr5Vddp7Lt7fcS9Mr/iyyDttP9wvxnpuSdizAuP76cOppNzcF2pqb7GKStA+K
	G1MvNqT2Tj/qiN88epuNJoiQoGy/D8uq4p6dQZQ87DdNGJZAvloyTkRu61+iKLjOGftdI54PGu7pL
	GhnpJo1WdpTHQhYDH13A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guo1n-0000ZL-C9; Sat, 16 Feb 2019 00:40:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guo1k-0000Z2-M2
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 00:40:21 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49168222A1;
 Sat, 16 Feb 2019 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550277620;
 bh=O5tMFdEraOHdNmuSg5PUk6dWxbx6ysYD6z0WMVZZZyE=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=J2LmySMkhDzjYGgkXhfXO3JDaXBMArPrId82r9KN1iR2WE4X2uX9BtU/1ocJHBrER
 pY6B7EaHzYCuzX3BqpOH5TbkL6gW6dkPi4+UPGj0ztSThODvPUZfEKumfDVlYsvQ8i
 cHImqFfPR8GP+Y2FjAMrSiLSjS5UsfrD5NgK0w10=
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
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <1550137826-18531-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V6 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155027761947.115909.17708921995062238540@swboyd.mtv.corp.google.com>
References: <1550137826-18531-1-git-send-email-Anson.Huang@nxp.com>
 <1550137826-18531-2-git-send-email-Anson.Huang@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 15 Feb 2019 16:40:19 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_164020_739836_41460163 
X-CRM114-Status: UNSURE (   8.23  )
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

Quoting Anson Huang (2019-02-14 01:55:57)
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

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
