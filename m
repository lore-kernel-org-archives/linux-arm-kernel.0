Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F94214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tVLnrmO5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x4HtUP4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F94214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iCCMSdt5/p8euuk79HZ2ANcx/egF+qSbgZKDmQ3ehpg=; b=tVLnrmO5TDyVE0
	lJHf78USZM73SyXDCGjcSdVtal9qX/LJ66FDtk749DJaI9K5luIauxMgjMYxjFKFQ5oCQzqqU6JRX
	t+oL6B99d8b40+8is1SlXBXX+16hivgiULpo4BMSdgGxNavlP28NLkctGno/+5bWv5/+Saf/DdJN1
	4+pI1W7QwnnnXLM1mBfDrYSJVWEJOaq6BJw8FvNUeannM7vNsNZNSxcwFvKRw37yOQu33Ft6xCkw/
	0ztCPP+DAEeTv6CjrEVmsMP/hqK0SHNfot72RkCDCtuAUIr07jDH8p7XEwZ4eUPKiekOLi30v8Xb1
	0s9IvsKs850BNRaqAU8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghJ7K-0006kF-8E; Wed, 09 Jan 2019 19:02:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghJ7H-0006jw-KT
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 19:02:17 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F06A520859;
 Wed,  9 Jan 2019 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547060535;
 bh=xEQ+uwwNmBSO6YrILiY5f68pgyJrj4JJtuMkMHixFL8=;
 h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
 b=x4HtUP4r7Z7S1AaBRHjJuFXknL1dERwBJBqbT2EiHPNM03S2+VH9WATY3XsXGGp0J
 hTDwO0PvTGlpsR2Ws4O/Bf6gGCEtsraPnoksvunuYuDgWKH+s1D3xk8KmFyIJPVwUK
 DFaug8z2azAcZM5nP3iplrlQeZIIRYqn6AEdG/kY=
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] clk: imx: Make parent_names const pointer in
 composite-8m
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <1544801400-18951-2-git-send-email-abel.vesa@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
 <1544801400-18951-2-git-send-email-abel.vesa@nxp.com>
Message-ID: <154706053417.15366.4490138181504807265@swboyd.mtv.corp.google.com>
Date: Wed, 09 Jan 2019 11:02:14 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_110215_686657_71B81FBF 
X-CRM114-Status: UNSURE (   5.87  )
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

Quoting Abel Vesa (2018-12-14 07:30:09)
> The parent_names needs to be pointer to const pointer to const char.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
