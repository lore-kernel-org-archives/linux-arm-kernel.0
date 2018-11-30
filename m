Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F0EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:50:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DC22145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i52Kmdri";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaXYtILW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DC22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tl0PTkCvWCnxMUdbl5OXoe4LzgplGJJxF3StJqjFjgo=; b=i52Kmdri7hCQK7
	uVpM5htCGyfWwwbkh6E+EFJ3gan3n+URLc9f92qtD4pt9IM2YpvgUPByI9ZM4kUU5yjqc1lL0UvhD
	4p9zxzgsxKOpykHWR6BvJgVRPJnVTvORBOCVRUymxn4AD2/hFJgZ1OfzutxHbdiDJkmuv/N7jj7wN
	w6L76zYKFUa4lYaZD8qGWAshzfu8xlbGc+MA7SUe/AO/qlH6/HudZPSlY6kNnW9X85DGlgDwDiLna
	BAI4ATzS6JToy8SYKVUZpff9BYb1owJpzKLwvEDNVusi9c47eFLfFQfNLj5Vn7p0a+2/nlGzle85w
	Vu4f5DjsWGsAcSKP+fwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScd9-0006pr-22; Fri, 30 Nov 2018 06:50:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScd6-0006pU-E1; Fri, 30 Nov 2018 06:50:25 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D637F2145D;
 Fri, 30 Nov 2018 06:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543560614;
 bh=uvbD7ONAjHKZogEDPFuxmFpPduuGqYSxQpj8/l1hj6E=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=KaXYtILWKLJlvg4M64ESm9twD/iL7ft2+f77A/JTtdsjUUhQaUlSPWP1uQKBCt5wJ
 umGVb6YQHL8vw717L5fPU8wBmzJj/eFYsbQUNAdzriUx1Eox4FyXQ8Fzfo6Yic0Hgz
 mLx2SaCXcqZerWX0XObZFA0C049rf/jph/TuEOG4=
MIME-Version: 1.0
To: matthias.bgg@gmail.com, matthias.bgg@kernel.org, mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181116180901.17737-3-matthias.bgg@kernel.org>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
 <20181116180901.17737-3-matthias.bgg@kernel.org>
Message-ID: <154356061291.88331.179492557229227536@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: mediatek: Add flags to mtk_gate
Date: Thu, 29 Nov 2018 22:50:12 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_225024_549865_46B17CEE 
X-CRM114-Status: UNSURE (   6.34  )
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
Cc: sean.wang@kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, jasu@njomotys.info,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting matthias.bgg@kernel.org (2018-11-16 10:09:00)
> From: Jasper Mattsson <jasu@njomotys.info>
> 
> This is required to mark gates as CLK_IS_CRITICAL.
> 
> Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

These other two look ok to me. I'll apply them to the clk tree and wait
to merge to clk-next in case someone from Mediatek wants to review these
changes.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
