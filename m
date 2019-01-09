Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC91AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF5520859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwQlhwfT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNCaQ07i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF5520859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qcKigjwZR7Vfg+TBe4PAwmvolXDQCWGQD33+U9n7VIo=; b=HwQlhwfTKf38Pa
	JMlFSgqQLGKbu1uiDN5+8R7rwPDIe0D/smsoxR6Z1oBULVeedGxRYGl7uQBW8D9Kx0Q8wFch3BZSI
	pQWb12vkWuotu1y77U5T2H9IkNcHf0j9nrVJmB04E284WSWUPNcMatRTCwWfIyWrMvdCsm4bdHW0Y
	w9JQ5MaZM6z1KOmblweT0eiC3Wx07ys4PJ5Vq9OQyGqj4T2ECUL0am559X7y/ww4vzDNqS5UMFuB6
	WXaFKpwmoskDpklXWqL1qOLzfK9G56qf6Jf58X0F3+Np5wjM0dwXvbFeX3+lFmHYP70x27Skz0Gun
	znjNE8ydUAqIRhK+KPTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJ7p-0007I5-8U; Wed, 09 Jan 2019 19:02:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJ7O-0006oa-Gk
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 19:02:25 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0EADD20859;
 Wed,  9 Jan 2019 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547060542;
 bh=HoPdtmHSu5EfuKil8L6NypIgFclfuIWpMTEokFWABvY=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=pNCaQ07iMef6k5zaN1Q2Ai4OM/mafjtexQQbVtt9i0Iiul7sXyLmAF7Hdd64EVIz3
 XRlVJQiaFGrx9nU1Wz196KDQWRRdPz2X9BWc74BDl3Zm+KrNwMzd0piyEwKg3x2LUM
 dNg67moAuWRjK4g8wxuLJqiJ4LV4E7eAXVBF6e+I=
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] clk: imx8mq: Make parent names arrays const pointers
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <1544801400-18951-4-git-send-email-abel.vesa@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
 <1544801400-18951-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <154706054135.15366.13853192559274325540@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 11:02:21 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_110223_073930_78AFC060 
X-CRM114-Status: UNSURE (   6.65  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2018-12-14 07:30:11)
> The arrays containing the mux selectors need to be of const pointer
> to const char.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
