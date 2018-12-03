Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5242BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:31:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235DD2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rnf0XeMs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcwJF6eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235DD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fqyUVuMJOS5SEGbeFwrPCiNwpYdyP0Xdbm8NgX5MwXY=; b=rnf0XeMsMM0/UB
	z6XafCQMd4pH8vkTsejHv/b2CRw05VP4CB8QTqEppO9XmTYHIL9LxjX0zqwBb6pjLX/MmL1yjC0gH
	rfjlFfrptHb8i3o5JIi0w5oirZr8NeeUz27uNOMwiEjmS/MrcRd4N+cspyGHWBC71qGuWlaTYiPVE
	j6he+YEWuDndDw+v9OA7KSk+GttNABkBPLiqR/p09pvE4ETOIGt9AWVD063/4jN/jQKgflbwVnJ94
	ZShso7cAfgomGmsc0mQcswYCZWK4jOShuJGFlZMAkgrv6MtKeia8Ln6DUO3MRhaxUQAHeO2LP75GV
	TEsXZnY3g2CaRt/qAFZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtwj-00008Q-7Y; Mon, 03 Dec 2018 19:31:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtwg-00006V-5H
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:31:55 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4ADF1214C1;
 Mon,  3 Dec 2018 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543865510;
 bh=bldWNC99dcFF5C40l8XYzy0m18NN3EPMGPB0pi5SepQ=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=YcwJF6eobsBrG/PE6dZ5q+fmyDg3as1PLv/1vrUHpcticoIjqZ4CTbC/5I2sdzGhV
 bq6kR88w5XtV+sqxNUGvFUjeo9xo9s3n+IVWCICD2sXaBFNB2pmm75NTSuDTlg1uIr
 tp+HYi3QeywLVyH47niTgcXfAND4xLiXAF+GOuuI=
MIME-Version: 1.0
To: "A.s. Dong" <aisheng.dong@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542200198-3017-3-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <1542200198-3017-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386550973.88331.6413976100924685018@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V6 2/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
Date: Mon, 03 Dec 2018 11:31:49 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_113154_222326_0B82ABC1 
X-CRM114-Status: UNSURE (   7.65  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting A.s. Dong (2018-11-14 05:01:39)
> Adding CLK_FRAC_DIVIDER_ZERO_BASED flag to indicate the numerator and
> denominator value in register are start from 0.
> 
> This can be used to support frac dividers like below:
> Divider output clock = Divider input clock x [(frac +1) / (div +1)]
> where frac/div in register is:
> 000b - Divide by 1.
> 001b - Divide by 2.
> 010b - Divide by 3.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
