Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52CC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:30:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DD72087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJvusdk7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs8YZApB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DD72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bIFu67UZvB3D5yO/N+yeYPjxrrmkZYEhxCrnvBDVA08=; b=EJvusdk7cPFjGb
	xy+4yVTguZBPe4cEAKedBrKTiHPGZ8M+RAZvrYAqsmN/77jOqsyPnqcCbme5jlCvWbq4K1/l5tjKV
	YDQJ4i2RFQjwZYX5kciiYS8N/s3BE6fC3BznRzMgms4fqSHzHNCtOGwXCt6qF2De2+tKeuapLSUGl
	pKnlj7KbYLqYMohDMn6+HGoxHDTp2JQng+uld5R5p8EaAMkPq5zuEuCTwTSYnThyW6bFyW1pdArb4
	JQXpBSmsbzZcx5N94JAEBmq7CeHplFVzVA/HKNt/6zziVEUN6RZ2bH9D3jIg4FSyDpFNj0qneyDTV
	udHrKaJP5qtfr3KzSS7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goroQ-0003Rt-S4; Wed, 30 Jan 2019 15:30:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goroN-0003RN-3A; Wed, 30 Jan 2019 15:30:00 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 37AE9205C9;
 Wed, 30 Jan 2019 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548862198;
 bh=IXgzgPI1HHyYdEP5PJixV7WwTg2x7VC9pHLBFT0zbTw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fs8YZApBs2jFVZzSUXIg74H1W73LNFl6Bl++1JoUY1booKCMgMZpWomZdQRANqMkO
 z60EB1jQWDvvIse25Q3j3bNuHUK/PSivLTaRFdZ8D7/b/bAdE0RBgh2V5XY3ouYqoA
 g4tX+xnN5Vvpb5OGXVms5Wc0jJWKLLJWTQ5fjGYg=
Date: Wed, 30 Jan 2019 16:29:56 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Carlos Henrique Lima Melara <charlesmelara@outlook.com>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130152956.GA4195@kroah.com>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_072959_147968_91B591F1 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "neil@brown.name" <neil@brown.name>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> 	This patch fix the checkpatch.p1 warning:
> 
> 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 	+/*

Why did you not fix up the indentation that was already mentioned?

> 	It includes the SPDX expression for GPL-2.0 and corrects the comment format to suit the kernel's coding style.

Always properly line-wrap your comments.

> 
> Signed-off-by: Carlos (Charles) Henrique Lima Melara <charlesmelara@outlook.com>

This needs to match your "From:" line.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
