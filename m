Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2513C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:56:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AB5214DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QHBTgFOi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="JaVHyvn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AB5214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wp.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JXwEJm3omzZW6skQRwPQFsPLZpmLCkTx5zBjQZkBtg4=; b=QHBTgFOinxZFON
	8Ld8LN4boZhTdZyWWjWj6LsuwUQyqtR00o0Tj5EWEeSt+iso4URCqZpNiI1Q1lPek7sBeMe7Fxf+o
	1f9otlpLsaZhSCossZKTZ6q2WE7QmvuppBjj/yHbCmNgx3Dx3v+aNqvCfDBluWSAeJBkkq/+VlPZk
	/WpikdVpkbXbiAh0wyaeAkTNjgHbO9VJzhKwOqgKlTEjPC8ug9ULo7avHBE5e5pY+AvJOgIA5/v+8
	ZyiUNIo8q+jxIcRY4S3wpRJxW5RiLDLUjKvYaZukROSt4P0+TXiTdwlV2RTfTSKDQ3JU+CZY7IEYL
	8sfbDK6xfyWieArzwUbw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtOP-0001B7-J9; Mon, 03 Dec 2018 18:56:29 +0000
Received: from mx4.wp.pl ([212.77.101.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtOE-0000t6-HC
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:56:25 +0000
Received: (wp-smtpd smtp.wp.pl 29077 invoked from network);
 3 Dec 2018 19:56:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
 t=1543863361; bh=mCBMbUijo/Yvb8Fw8wUKY7mw5kUvXIL/Kc1FawogES0=;
 h=From:To:Cc:Subject;
 b=JaVHyvn6Ue/rRHlWJa7JFDztZEQhAJDNwn0u9R0REJ+nD4jaH63gFu1fvpePpdExT
 2Z97CErDWtvoQtkGwqmT7BR+A41fGx/8Dm/6XXs9Ghz8y4dYhWfKn6xzZZiM7oX6j2
 /KsXlv9vK93SCsq5JXDLz+wYNRV4fx3tdmV/u0rs=
Received: from c-73-162-4-14.hsd1.ca.comcast.net (HELO cakuba.netronome.com)
 (kubakici@wp.pl@[73.162.4.14]) (envelope-sender <kubakici@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
 for <tiny.windzz@gmail.com>; 3 Dec 2018 19:56:00 +0100
Date: Mon, 3 Dec 2018 10:55:54 -0800
From: Jakub Kicinski <kubakici@wp.pl>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] mt76: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181203105554.2c40d574@cakuba.netronome.com>
In-Reply-To: <20181203134028.12645-1-tiny.windzz@gmail.com>
References: <20181203134028.12645-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
X-WP-MailID: 8caf814412f4534c7359652eb3a5eb94
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [scO0]                               
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_105619_115153_E4AFA857 
X-CRM114-Status: UNSURE (   4.67  )
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
Cc: sgruszka@redhat.com, netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@perches.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 matthias.bgg@gmail.com, lorenzo.bianconi@redhat.com, davem@davemloft.net,
 kvalo@codeaurora.org, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon,  3 Dec 2018 08:40:28 -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Jakub Kicinski <kubakici@wp.pl>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
