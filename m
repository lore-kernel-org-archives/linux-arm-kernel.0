Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:15:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7164621904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L/rhyl6E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG+oagdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7164621904
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:In-Reply-To:
	From:References:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TIUSAwPAqs2WcoLktl4WXMfH2+n3zrb+yDJHBzHTI7A=; b=L/rhyl6EiljJSD
	t/VdvV7mIHMBhJBjrV8luMYuOumozEhfNpl6zjBijON+ff8l6pHlIQsc4AZ3VuGtjfXfNxLR4Rx31
	IRVRIa8eHxfGVi9rvPCXSzPiV8Rx1y0UxxxzpoQu1Kr7ARrakzhZlhDilUsccJ16+Llh3ay17v6nz
	2FuBgUklXCsaVBM5er+sw+ICIu7RXHKVt6pyd6PxxBzDe+DAntBWhKzHhg7ylQfmEL1FdkP8TXPQV
	SeRUdwZmwZWCXProHaOju46z2G/VQQxLeb8KgCjqUBKFTx6UhWZzr/uwdNK29AJXHz7Yo9v2jK9rG
	azuS371zKBIqI5RThsqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5fg-0000U0-4r; Thu, 20 Dec 2018 21:15:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5fc-0000Sh-GZ; Thu, 20 Dec 2018 21:15:53 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1CB48218F0;
 Thu, 20 Dec 2018 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545340542;
 bh=8Eag9tEeLAOkPfHOvwKQIBsJzR2egdr+WAQlC5teXCg=;
 h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
 b=HG+oagdZ7lQIl8JfYm8JmL4S7dgqWiQCkIpy3pLluT4AbyG6y4d9mfGjqKoCGTrEF
 IXCn2XpXT8GMvORKYpY5qxBPhgab56OMoTWfyBEyFh5vwbW9alDqquCyVXiLUTnc3U
 +O5m0WIOpV0uwajqXZIk0zmUDm1VYbVe1nCNXyM0=
MIME-Version: 1.0
User-Agent: alot/0.8
To: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org
References: <20181024013132.115907-1-dbasehore@chromium.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
Message-ID: <154534054131.79149.12015186156265337224@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 0/6] Coordinated Clks
Date: Thu, 20 Dec 2018 13:15:41 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_131552_568537_A5C897B3 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: aisheng.dong@nxp.com, Derek Basehore <dbasehore@chromium.org>,
 heiko@sntech.de, linux-doc@vger.kernel.org, mturquette@baylibre.com,
 corbet@lwn.net, linux-rockchip@lists.infradead.org, mchehab+samsung@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Derek Basehore (2018-10-23 18:31:26)
> Here's the first set of patches that I'm working on for the Common
> Clk Framework. Part of this patch series adds a new clk op,
> pre_rate_req. This is designed to replace the clk notifier approach
> that many clk drivers use right now to setup alt parents or temporary
> dividers. This should allow for the removal of the
> CLK_RECALC_NEW_RATES flag and the implementation of a better locking
> scheme for the prepare lock.

Are you going to resend this series? I can do a review but I wonder how
much it will change anyway.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
