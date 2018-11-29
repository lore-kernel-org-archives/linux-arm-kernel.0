Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E4C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:53:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1A721019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d7xzHoun";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtgX4N4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1A721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qJUcI/8xPdcF5qj9dqsqakVMP6mEhCgDWLwYgzU51RU=; b=d7xzHounqyqwGc
	CLVbBOZ99cjCJQRByDiSYDAzO8DYHXzoUgUD8Unfc5MIy6VOF5vntGJYQ6N8cXu0M+T5mkfpN43Ny
	o53uIiczuyGqUlX4zr35VnkJtZcwm5PJlFCB+7gjBg+r6iKXFt6wFHuMjFMn4KOne1r7n8Ztn09+s
	zwdPALANEytC3cgca8fGgacgTQok5XBoZPf+of9/6GQ4G1TNzIqn1B1CNKUwz7zMg8ZB9fKHsUUJd
	nE94gW400GHAphlJ8Y0LO5vuVZDukR75hVhkVSoBPfiJFaW8RbZlore3DGv/+Zp2DxNJYLZ2ZkZxg
	Hy+Q2H4IkaR1a/v7FJ7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUFc-00050a-Du; Thu, 29 Nov 2018 21:53:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUFP-0004tY-6R
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 21:53:24 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B087F21019;
 Thu, 29 Nov 2018 21:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543528392;
 bh=DDsEsUVR0mi/NXo7wJUn/+RkolkAFvJLZqQzLztUorA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=CtgX4N4Yay+NNywiwifwUSQ7F5PmD/eeIm0DyfsYqD9IYAxiPA7TElJ8ZR98quQs7
 6JMai34WOvo5vDA1TomBX4nFRR5LXA98pYQ1WXuXKwwKTWs8JMYkcNAs0Ug+NicTWL
 S7helIFeeXxLEaSBXtcnLskFhH41/MC1aWTi89fw=
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181128183702.231609-1-sboyd@kernel.org>
References: <20181128183702.231609-1-sboyd@kernel.org>
Message-ID: <154352839199.88331.15535776216408804452@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: renesas: Mark rza2_cpg_clk_register static
Date: Thu, 29 Nov 2018 13:53:11 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_135323_259612_A2F7E11B 
X-CRM114-Status: UNSURE (   6.83  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Stephen Boyd (2018-11-28 10:37:02)
> This is only used in this file, so mark it static to silence a sparse
> warning.
> 
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
