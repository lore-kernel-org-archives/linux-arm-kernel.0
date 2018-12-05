Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593AEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B962054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tFjJbURF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWJjYL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B962054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GA8DuITi3LCtlNgLhzfMtz/ld86xY9uah5FJjU05rBM=; b=tFjJbURFO3xhJw
	Ak7awWLU7ojltC89647rmFldg7gx/84t07DZbQM+dxiz/F9B2sUEr6NM8P/+Rd++jvXVPklY26L28
	GFB+HCFq/VMCR+7lbzntlmLatCdFlH+N2q1lB2cP2Y4dfxXdLtFJBBNOvsdLkyMoiTT0HlohH42bh
	mY8lqcw4wgRvMGGq9wEvEbNFfJAUo+8G7yZzx9Px9VooIglUaDYaX/nVhOE6X5/i80b2xjYvTCTMy
	LKpazcacO1A9Z64Vb5iQQ3FKvXjMx1O9kv4F4s8cvL6JXllcdYlA7PglgiqjPyCOM3EAVfYYV2qV3
	1CbSS8obBNLLXLhE6ESA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUO10-0002uV-LW; Wed, 05 Dec 2018 03:38:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUO0x-0002tp-GE
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 03:38:20 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E02B02081C;
 Wed,  5 Dec 2018 03:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543981088;
 bh=sECkrbh8jQcAbHgbJogF9g8Mx41gojGCg3BOT9kRX/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aXWJjYL/ISUfjFKHp3HJjIaajqkMxDmvC3exOOwVMvKEjoEvTGtAa29qnrmZiZ2o9
 gTfw3Edck5w4EnwKra5ewz6syIE54tmNZ9+8PW2SUsdA5q5ffwnMA/k01jrY1SBLrd
 lM3WeE/RnivwGRfApwe6xJwHY2Yosd8qUdTFa9OU=
Date: Wed, 5 Dec 2018 11:37:31 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx50: Switch to SPDX identifier
Message-ID: <20181205033729.GI3987@dragon>
References: <1543490294-5847-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543490294-5847-1-git-send-email-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_193819_770492_B736520A 
X-CRM114-Status: UNSURE (   7.77  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 09:18:13AM -0200, Fabio Estevam wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management. 
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
