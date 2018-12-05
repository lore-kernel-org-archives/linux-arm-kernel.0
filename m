Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F265C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9542081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PYriotrH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN0jvUp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9542081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=01N4ajqoaRul3YPrNSOkvaip8ki3hSSb/XqSWAdcMTI=; b=PYriotrHv5pEAh
	w2tPbf3bcgKIc+ODdIZpK6+Futkn+H4EWUczV2S1c/tmjIVLtMcLTTwjT7HOoPvBjr1aELG0DGJUW
	aFUQfAYhOmNtirxN7qLS39cnbNkDDEkNJa6MXPRKMeMoVlyUQGCMF7+Et+J+HoBmmOfJYhKvKyMbt
	DoR1mNRkwDRph2sp9jE6wLPrDZKfkggLdTOhxq+ka2uX4YxH3Kn0FlNcQZov0iAw85PknJ5TbBa0M
	t9s/n3NA8tu35uxjg4KyA0m7wkmnBk3g2QlBU6t83GsXkXBfjk2Ne70BxX16POK5siC/4ca4oVJgW
	GMvX9QZf5KdCiK0v7QXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULsD-0005hz-St; Wed, 05 Dec 2018 01:21:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULsA-0005hL-C5
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:21:07 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AFA742081C;
 Wed,  5 Dec 2018 01:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543972856;
 bh=2EiyGXH4m2UpsekuxiPo+AVP0lrnuIagVTvRxolXgJw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vN0jvUp6ubML+0SBovcYlqODKa0uKSovdLH1rs2FR7LVpeFNPY6rgVTfRQKm3aJvc
 22Tya7w7cR/Csbm0f+W3V4U3/qbvFpZkp+6W4c3U1iTCulGSmprJAf/xko/KfRw8iY
 RXPSqvSLwPnh6bQzSAZidtbGqyxG9zT/zf1vta1E=
Date: Wed, 5 Dec 2018 09:20:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: debug-imx: only define DEBUG_IMX_UART_PORT if needed
Message-ID: <20181205012014.GD3987@dragon>
References: <20181128090416.14695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128090416.14695-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_172106_426198_38F81997 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 10:04:16AM +0100, Uwe Kleine-K=F6nig wrote:
> If debugging on i.MX is enabled DEBUG_IMX_UART_PORT defines which UART
> is used for the debug output. If however debugging is off don't only
> hide the then unused config item but drop it completely by using a
> dependency instead of a conditional prompt.
> =

> This fixes DEBUG_IMX_UART_PORT being present in the kernel config even
> if DEBUG_LL is disabled.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
