Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:04:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDE12145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4soamDx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iu2spBN/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w8Aj0Rrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDE12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jUQvuW40VzASSCQHuWc6A57Q164ecWroMA//MwKQS24=; b=l4soamDx5MlEqc
	zSeltizC5krHwSDfBS0yRwSfTGFeRcCoXtEvymlDm6vb8dLSv3Gu8DGP6ortINTVBNo1joRD5X3Ui
	686z6b1O+oh8CpPfh9BMsTM2csEQnhNL3tKxSjhfz7GhOBFTIqyP2ICOlnw5lk3BA7pwdI17BswCh
	b9kn/ZrF6NuPFRCqgXxWQYQFJhlCwlZhbFmgkrhL+PaAus/to0phDWMql3lwSC4JcVx/tXRw4Qk7H
	V0uYpZCn5tZ73iOU48sTLIMdz+md197WUZeSfOd6RS1Av9ueCuBNdHx0+U5j+U9ker6TAoWi0frbn
	BUftdVkuYau8F9ZIR5aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScqY-0003eB-RQ; Fri, 30 Nov 2018 07:04:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScpz-0003Dj-DS; Fri, 30 Nov 2018 07:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Date:Subject:Message-ID:References:Cc:
 In-Reply-To:From:To:Content-Transfer-Encoding:MIME-Version:Content-Type:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FpU+sXY1T/Zpbt+sSPXWrQNW5KLWFluYs/jM2zIdhjM=; b=iu2spBN/TjNCGReJYNZMVYtZUb
 +OSLvyAmAJ8HgvdyedO/GcgmeCyLcCaURhyhH/Ywu31M/DbwRM4nr2jCf+vTEnL0F42Sk6mYWaJtU
 5wOLcri2xgCuTWCAve60R0Fquyr0WvwSll2ohbdxXI/qevgKCx3M7gDs39f0qtlzVcj49psB3DNeC
 DEP/Uv4UltFOBFhA9CGnpC4W467l1tOJ6970irqwDOUa5JHNGDSYwAlSpuOKuawEcvp9ijpTeCT9f
 gwdci1YBY1lDjqlzia8bmjwoplsIKRoETjpctKNNeC64cRk2FKzMH9MxIqEqIeLUgxfdElfnx1VH7
 tMzwOMwA==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScbn-0003Rh-SY; Fri, 30 Nov 2018 06:49:05 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6066420863;
 Fri, 30 Nov 2018 06:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543560532;
 bh=FpU+sXY1T/Zpbt+sSPXWrQNW5KLWFluYs/jM2zIdhjM=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=w8Aj0RrsuijrqNJGUYuBPmCezhOECIqT98CdDUBbu2lvJDCNlwgrdhiVx/1m1rD9a
 pPoZFrUUl+cR+/oxDdl+S6XUGw9ZVP6kLgXa7lcepOpZW+dwp7F54rI7+PZEgUegsh
 PuEEPUYiLeu2wTAMwMdKwbtj8iEme0ZgXbz2/aWE=
MIME-Version: 1.0
To: matthias.bgg@gmail.com, matthias.bgg@kernel.org, mturquette@baylibre.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181116180901.17737-4-matthias.bgg@kernel.org>
References: <20181116180901.17737-1-matthias.bgg@kernel.org>
 <20181116180901.17737-4-matthias.bgg@kernel.org>
Message-ID: <154356053181.88331.12262289931983027816@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/3] clk: mediatek: Mark bus and DRAM related clocks as
 critical
Date: Thu, 29 Nov 2018 22:48:51 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_064904_045014_2FA8ECD9 
X-CRM114-Status: GOOD (  11.56  )
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

Quoting matthias.bgg@kernel.org (2018-11-16 10:09:01)
> From: Jasper Mattsson <jasu@njomotys.info>
> 
> This marks MUXes axi_sel and ddrphycfg_sel as well as gates
> infra_dramc_f26m and infra_dramc_b_f26m as with CLK_IS_CRITICAL.
> 
> Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
> Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Can you add comments in the commit text and in the code about why the
CLK_IS_CRITICAL flag is added to these clks? It makes it easier to
figure out why the flag is there months from now when we all forget


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
