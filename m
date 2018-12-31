Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A0121720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dYBMYw0r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jked7Mbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A0121720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oqhZmrhn8MjlScW+xY8sQ06942zldo47OgpC1hWDPwg=; b=dYBMYw0rbN7REN
	vQTECwHfN4egTbaVkjjPBKirNAbkJuyOKsfhtvalBpjU7O5PZpshJvRc+1Qg+0GXrA/gaJ8pD2stR
	NKC38QU6iILViD+921kpS+fKwVCU79fgHvx6zb9tHnGXiLCBwLd4JGg5/kQAV0WChqfHKhEJRwnYZ
	dIG1h5IJo00eHoDtmUXDTtD1ZBb1bQqRqo+wN8rwUSO+Gh1OTckNnCB4pVlMSONzhzOkkpQ4C7h3l
	EjdlCu93PAFr96IqULN1k30t47IkT/HKqXMeEiSnG2Xf01wGAFugwHNVKbpqTY8k/NZzzEED+leFK
	XmEgFd8C3tAJO0pbArKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5Dp-0007iX-3Y; Mon, 31 Dec 2018 21:35:41 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5Cz-0005l2-Sz
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:34:52 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so24309415ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QV8mzC5YX0U+4N/kF67ItJDPg5283G9y6hTw1dsuKwo=;
 b=jked7MbcjYYYGuSAMgRLKrNw75Lj2Hj6wmEGvsHbFPmqXqubi+/0XvH3VnMDMx/GAl
 7L+pdJz1dH992rClaSP1MuOYCkOC4YUIbPEIp9fVaVs+FBciaUOyqiP7hVueDkyOjtyu
 49Ddfj7itlBD0pXGqbsJ9frdz0kFoBVVjiIGvuoy3H1g0rLlNtAgQDmORthF1bJ1JI2F
 jw9mhHDSZGmkriVzuwHJ3L/8P97d3vSTohodC1OMwz0WIIdzHArp18e58jdp7wIT7t6Z
 woSfNN1c1xmoVPHQ6228x/cT4TD6P2+pqbNOJz42qw1JqskPJiRWWYrk1dYWAiyvX6bq
 eG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QV8mzC5YX0U+4N/kF67ItJDPg5283G9y6hTw1dsuKwo=;
 b=hsKimB49GHqw9L86weMz/Ia+3gXBCwjxlNIjhkc3UTTefWGblfRggKrZJUhgbfoYji
 apTcz2CcWrWb44fuAd5FpFd4K0eA2guke2fwUO7i0vEz2DtvDQSjTuRK8Aqc6/TmyXMI
 ryK7IVgti9wCFarYmTlfNVBF8BujCeGajYIzmC9g6yNFdyLXwX/+seeYIbHANPE0HGTz
 a7HIzbQD/dGPts5AonaO5xz8w3a3DmlgMfYjmKSWfjaI7rR9DyDXI83+o0r/napeMgPB
 ZdeYcb1MZWKgrIl1BUS07P3nRhZHeAxUlsNpGRSjJfYqO0Es2wwtTprAyXvDF7VWNvrc
 URyQ==
X-Gm-Message-State: AJcUukfY8756k81cF2QGP8hIJPftImv1ix039JfnbO6CbshtiOjAQQ9v
 TbqoPYBg3Xgr+KY6jh9SkoIgN5HFufQ=
X-Google-Smtp-Source: AFSGD/UC1OfjaaFQKbULuBPF57N3v73s/L8v2vJF+tyx8HVmxXWtZYrl+Ms5dbZ/iehMgF7VN+Q3jQ==
X-Received: by 2002:a2e:9b84:: with SMTP id
 z4-v6mr21962554lji.93.1546292086243; 
 Mon, 31 Dec 2018 13:34:46 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id q128-v6sm5009081ljq.14.2018.12.31.13.34.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:45 -0800 (PST)
Date: Mon, 31 Dec 2018 13:08:41 -0800
From: Olof Johansson <olof@lixom.net>
To: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [GIT PULL] i.MX8MQ device tree support for 4.21
Message-ID: <20181231210841.sg3vqzs6dujvnaz3@localhost>
References: <20181217133036.GA24973@dragon>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217133036.GA24973@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133449_938512_3CAF516C 
X-CRM114-Status: GOOD (  11.73  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, arm@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 09:30:37PM +0800, Shawn Guo wrote:
> Hi,
> 
> It's the initial device tree support for the first ARM64 i.MX processor,
> which has been floating around for a couple of release cycles.  Due to
> the last minute discussion on fine-grind SoC specific option, it comes
> late.  But we appreciate that you consider to pull it for 4.21, as we
> have more development lined up based on this initial support.  Thanks.
> 
> Note: the pull request is based on tag imx-dt64-4.21 (already pulled)
> with one stable commit from clk tree merged in to resolve dependency on
> i.MX8MQ clock ID.

I've queued this up as a next/late branch, and will try to send it in before
end of the merge window. It's been a quiet merge window so far, but there are
no hard guarantees that we'll get it merged.



-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
