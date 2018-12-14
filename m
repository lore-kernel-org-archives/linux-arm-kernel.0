Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655AAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:10:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6CC208C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ppUhOfoF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc2uotgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6CC208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sv79hTkLD8dascZ8kgE0qGoybAgwA/IkU3CEWaD0Ngs=; b=ppUhOfoF6nBBdB
	wzv3Oqn+cpxwz60u9gyjnbOY5V2RPBGKfhZ1cqel0MXiBgQygV9vHZYgYkSKfB5e/9BeMHQX6r1Ki
	oQ7jpSOb/4WmHIiOY3M1AgmVl+EoGzHyRf/SUt2RdKSb8JM/G3kzenyEhL1qsJ1x13rW2nF3r3oZc
	M8UXrYMcZqnPQXBTzV/drNR9GeQ5lBia/db7+AVVXlCM2EEz3EuIpq9Pf47KlttKhQtqzP2Ov4vpz
	H4qgYWdEpPk6HDrTowIBylXlrnZvWMiyjEj43zJ0D5SO9SZcw2VEHOzIaGgSGa3+AC/WnzwaG3twF
	cswEbMmyPIDd8hAXoyyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXuio-0004Vj-6m; Fri, 14 Dec 2018 21:10:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXuho-0003Lr-Ni
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 21:09:10 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B05F5208C4;
 Fri, 14 Dec 2018 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544821748;
 bh=Hb/Nas4lFxcyVpYP1kZK/OzQS/Kcj67G/WkepeQJ+KU=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=Zc2uotgIwZfavrA0AQIe7aXHNlywvgVGwtD3e6RK2Tpky2SiyQIfQIYQypGrbO6Hk
 MIEwPASyppUWoGcnYIS5gXEGjsW08mDcnFoGMnfrhtsifQqdY9WInVht4GrLKWhmWy
 Frc+DHS4FEIhve0tG0Ci4kRxrF78ZOKnmyGmmvYg=
MIME-Version: 1.0
In-Reply-To: <1544715442-8902-6-git-send-email-aisheng.dong@nxp.com>
Subject: Re: [PATCH V12 5/5] clk: imx: add imx8qxp lpcg driver
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
References: <1544715442-8902-1-git-send-email-aisheng.dong@nxp.com>
 <1544715442-8902-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154482174763.19322.12593859451035066121@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 13:09:07 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_130908_908971_5D54364B 
X-CRM114-Status: UNSURE (   5.88  )
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

Quoting Aisheng Dong (2018-12-13 07:43:05)
> Add imx8qxp lpcg driver support
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
