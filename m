Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43120C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:19:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EC12084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RY5VuboG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyZploLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EC12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:References:From:Subject:To:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BLd12zUFnlT+FBcB8WZtiqp1XotFf7VAznEs1tfi1Tw=; b=RY5VuboG8uPgjJ
	zSz7NJQ7+pjapSiArL0V+oPlk+vmTsCsDhP7UhwRxRJjWaF9+p559T3xnTbWxcmOmLjpknHuUfSVP
	6WIa2k34EFhC5YadmFNFsgLFok7eKvgLjYQODunn15MRviXZy+rkuQkGVmTcR6/fW0zyksh/MQsbI
	O3MVK6T+mwd8YDaAI0+HeAwcrKpKevJg5nyshNOqMbv69FbYCxuWbPrcrz9CoFebgpjZV8vfphyBi
	FWWo5MyVat7E5BFAt1JwVfQe8mFJUdniE33hZo4FiE45g8QorL1ppKEHA1gnqeh5ZUkS6uLUJTgEh
	MC9SD9jU1v1U8MtiAH2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWR5a-00015Q-DP; Mon, 10 Dec 2018 19:19:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWR5W-00014S-GC
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:19:31 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0AFBD2082F;
 Mon, 10 Dec 2018 19:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544469559;
 bh=4ecJ/i7HVkw5s0k8wEzqX7Re90Ca4MBsN2sD28Fh5Ts=;
 h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
 b=FyZploLtz2q7EQ6Uq9rsmC8tsks3j0dKPvDlA9BBcJpAxYOsOcS7tr6htpRZkJlDG
 Q0xeXD59b3+oh2ZzD+8q2+LD+Lyqw9lzFQPTkr94/6VIXgQokiRhzIRStPm+wbEmaS
 ZDitKAsVk5JP4Nhuurpu7duTNlRiwExU/vM4gtWs=
MIME-Version: 1.0
In-Reply-To: <20181210124049.py2auqlgd37rbwfo@flea>
Message-ID: <154446955814.17204.14056899093661973978@swboyd.mtv.corp.google.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] clk: sunxi-ng: a64: Allow parent change for VE clock
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <20181208180222.12608-1-jernej.skrabec@siol.net>
 <20181210124049.py2auqlgd37rbwfo@flea>
Date: Mon, 10 Dec 2018 11:19:18 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_111930_557411_AA282B67 
X-CRM114-Status: UNSURE (   9.21  )
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
Cc: linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, wens@csie.org, mturquette@baylibre.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Maxime Ripard (2018-12-10 04:40:49)
> On Sat, Dec 08, 2018 at 07:02:22PM +0100, Jernej Skrabec wrote:
> > Cedrus driver wants to set VE clock higher than it's possible without
> > changing parent rate.
> > 
> > Allow changing parent rate for VE clock, so clock rate can be set
> > freely.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Stephen, Mike, could you apply that patch directly?
> 

Sure. Applied to clk-allwinner and merged up.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
