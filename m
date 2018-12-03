Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28FAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9114F20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gv84NYKm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w1NdJlux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9114F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ln3j9G6l0Oix3mwvwbJXzrTT3P8Uda5ngiSt/8ek0PY=; b=gv84NYKmYuTlIn
	Rrtk5W0mzUXGJk57nOTUEuZzR2/iGrd1pKIiNOKLuxzcd7ik9+C6R5BYISF9vZzLuK2LoF01sHGC6
	RwOVpSleCHkhzTuVNtIcX1YK5LNd49BNvc7QYkqyJxFoKUtPe7LLWzMvsNtHoooNNPYWOtbT/oGhP
	CCFynN3xHrq1k5JMKjzX2L8uD4rnkjh6U1qiVv6/+VbaE0z3vgJjP+u+3wVAkXrQi3B7q6jn394vL
	JMvV+Ng+dA63jJvsM+pv+aQz8iEctMBLEdLcMAqxEEAWQo/wp6WIXHUhUkjdDSnSu3vC03G0rHjlz
	TGeeIp+cr9n7RWwj4Cbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTuAA-0000n6-4V; Mon, 03 Dec 2018 19:45:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTuA7-0000lm-Dz
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:45:48 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0A9BA20661;
 Mon,  3 Dec 2018 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543866337;
 bh=EnsLlUJS5JUjIDKghxe/fBp0WmyUxMckPGNZhGOKOOo=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=w1NdJluxhs2dLFoHIWvt/yDZ3vac+2Jsix8TdB0fUgwkckl1d2lyLlrw9ePLJ+gdR
 zSHuHTEiSPmdb2SfuX3FBNDkJo3d1/9VmyaYDbvHN3d9OguDq6tAu/ZhId1o4IuDwZ
 i7jhiHdBW8drVef9+P0jRFOG4cLYUxBp6N7K4cIQ=
MIME-Version: 1.0
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng DONG <aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
References: <1542809234-539-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <154386633644.88331.14352445218056608664@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V8 0/7] clk: imx: add imx8qxp clock support
Date: Mon, 03 Dec 2018 11:45:36 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_114547_494186_E66D4A14 
X-CRM114-Status: UNSURE (   8.40  )
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

Quoting Aisheng DONG (2018-11-21 06:12:16)
> This patch series adds i.MX8QXP clock support which is based
> on the clock service provided by SCU firmware.
> 
> Note: It depends on SCU driver which has already been merged by Shawn.
> So this patch series could go through Shawn's tree as well.

Any patches I didn't make comments on look good to go. Only a few
comments to address and otherwise it looks good.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
