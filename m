Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70007C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:07:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EEB2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AHLE23L0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="bLHp/aa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EEB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yymcntikta4Xk/g2dsrb9i6w4MuHlbs2jkzBbx4ghQE=; b=AHLE23L0DsrFQv
	hd2OmDabeskYX7vNoF3ghXNW7lzVT0ry84+wNlmPJBlNyckUq2GgMU9w91PWU4UyAHIs2G1Qw397l
	96Pbn3ojBVXLH95hp/SHHlq1E+pvYnpLLjNtHuy7jIuGl9FQMpEmvCvjP1Pc6NYYftHmHmyQqSSwo
	Kv/iCE3jMqThTPLRseFpn8pAMMTxWifzs7aKK2Av5Q3bBIRzKvQ7hY2XyqRTKJ0s3uqAGTaApVZy1
	b+7yDNDKDgcSTFYppT6bgjtbNb+aYqo1lUj6Vv3iOjkPKHwbK4tmXXzyAI5CsH5rLJergoKLJRZsP
	HJVvMGXPYyuN9zth14/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDDt-0004cD-A7; Tue, 18 Dec 2018 11:07:37 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDDp-0004bZ-NX
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:07:35 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id F2C6025B772;
 Tue, 18 Dec 2018 22:07:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545131241; bh=zlDSTVPK9Y8wqW6q+XalCzhu/4/T50Qi2FPIYlABJH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bLHp/aa5rm9SM6uuXnEXum04XcUh7jhjbL0pyYh5K35p0QXQ8GnC6XYdqK6ksr8tV
 8+P33Ld/EyQ2h1XSdTjMQNtciIOno4BhPDvGtkJb6MqqmWIv2quFtxZtZuQT7U8UJq
 Hpzh9j8pKHxRIcwOuI/jk5e/iGqtbDebMa00xWGU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 496AC940274; Tue, 18 Dec 2018 12:07:19 +0100 (CET)
Date: Tue, 18 Dec 2018 12:07:19 +0100
From: Simon Horman <horms@verge.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Enable scu-simple-card driver
Message-ID: <20181218110718.zl6apx5quvzn7hlm@verge.net.au>
References: <20181214115650.12443-2-horms+renesas@verge.net.au>
 <874lbdj97x.wl-kuninori.morimoto.gx@renesas.com>
 <20181217083642.6s34yp6dh6k56iie@verge.net.au>
 <871s6gk0mr.wl-kuninori.morimoto.gx@renesas.com>
 <20181217092138.g5kwssfxabiw7g7f@verge.net.au>
 <87efaf3gyi.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87efaf3gyi.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_030733_921424_5C1117C0 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 08:01:13AM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Thanks.
> > > 56629fcba94c698d8c5be3413981506479566869
> > > ("arm64: dts: renesas: ebisu: Enable Audio")
> > > is using "simple-scu-audio-card", but it should be "simple-audio-card".
> > > Can you add and test this patch ?
> > > CONFIG_SND_SIMPLE_SCU_CARD is no longer needed, I think.
> > 
> > 
> > Thanks Morimoto-san,
> > 
> > I confirm that Sound on Ebisu-4D appears to work with a)
> > CONFIG_SND_SIMPLE_SCU_CARD disabled and b) the following patch applied.
> 
> Thank you for your test.
> OK, I will post patch for Ebisu.

Thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
