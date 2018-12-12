Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83C8C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:37:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874C320880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bv6uYJ3T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5ffa1R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874C320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bchKBw3B8whOk3qd126McVYGdBC3LtbO1vWqTlY4cw4=; b=Bv6uYJ3TXgDzhX
	pINU5D4j9/LaZyc7vwA9Z9nhVWRlzODywsq/wi25ZW8JsQoX1L8vIBu88cayQaCu8hImKMdc+a6ul
	XKOvHUorZqT2G8MTUAPQCB2+tPwURTzR6lx2AAnoEHTalwKGJwaInJpNSXT81PkEshgV7Kr4YUasP
	/0WG2YqkzI1ZQ3NWrG/GRrcdjjsdaHuRFhWY3dI95lDPhklydkWMtpDWses6c/0R1jBeq1k3qkqyR
	iG+MlRwQge2Y4CxtGnGhFxBJBL5WPsP8p3wAAkPpbzV9xo6mSwhKB1oJH1EoH6KGX/nfXRB0z80Ak
	S0yAYTanp3BZ5jLE7Jfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1t1-0001z7-Lh; Wed, 12 Dec 2018 10:37:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1sy-0001yb-Fu; Wed, 12 Dec 2018 10:37:01 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B139420849;
 Wed, 12 Dec 2018 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544611010;
 bh=jZ4xbfLaQLo9am49hxu9DWSWjyVtHnPGKIhyJQ6zf0o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d5ffa1R6QpyU3YLwVJHtOnMZoYp8JmXZuRa/arrTg68pNB5nOmnJwsr8VYuJQHwzN
 1OzFKLXHSMfK8KK1+QBeLo67H39yCvbGbBTvlwRYLLqrQrJfEpTNi30IikRKfGQXus
 9sfPguT/cSpvu7EbU/Bifh3IWUfEEelU6AsM8UNk=
Date: Wed, 12 Dec 2018 11:36:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] staging: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181212103648.GA24255@kroah.com>
References: <20181209162742.19767-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181209162742.19767-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_023700_546799_B79A2901 
X-CRM114-Status: UNSURE (   8.72  )
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
Cc: stefan.wahren@i2se.com, devel@driverdev.osuosl.org, elder@kernel.org,
 keescook@chromium.org, greybus-dev@lists.linaro.org, sparmaintainer@unisys.com,
 johan@kernel.org, linux-kernel@vger.kernel.org, eric@anholt.net,
 kernelpatch@126.com, viro@zeniv.linux.org.uk, colin.king@canonical.com,
 pure.logic@nexus-software.ie, natechancellor@gmail.com,
 david.kershner@unisys.com, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 09, 2018 at 11:27:42AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/staging/fwserial/fwserial.c           | 32 +++----------------
>  drivers/staging/greybus/loopback.c            | 16 ++--------
>  drivers/staging/rtlwifi/debug.c               | 23 ++++---------
>  .../staging/unisys/visorhba/visorhba_main.c   | 14 +-------
>  .../interface/vchiq_arm/vchiq_debugfs.c       | 14 +-------
>  5 files changed, 14 insertions(+), 85 deletions(-)


Please break this up into one-patch-per-driver, so that the correct
people can properly review it, and you don't send patches out to people
who have no interested in other drivers.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
