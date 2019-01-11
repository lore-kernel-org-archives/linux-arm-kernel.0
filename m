Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721CFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:28:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4372920879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pqpbuRf8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PX0kpIsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4372920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTeeT/prclWX7Chp7b1abOaWbp09N0to5ANVk6UGsGg=; b=pqpbuRf8KOjIZe
	uXJIm1sG+1M5eSSjvEMl7ZHgKtrfkZ6w3SXozGC+swZ3At8g0G8rnqE/twzZuIDafNcGuorOVlJgj
	OXjo7Qavgp3xXz+W04GIi/1G8gKiigPKzwrqhfSLG+UNX5Mu3Wm65c+WIa2aXLwxF84WzvbM4+56n
	TwjgCf3cFkYt/FWfXZmJ4C9rZ+flrjTOeIq8RJkj/zhqXNnzNoKu74ZFaga+uT618N4RBSoUxPDQB
	2ZmE0zBrLt8HzwAOWqrRUKQWUSFLezxer5/edGQ3sH3umza36y5Ge/MGjXpaxjHHDwRDtW7pLgUkC
	LW5VtSH7uvWoaRZFmB1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghlcP-0000N9-AX; Fri, 11 Jan 2019 01:28:17 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghlcL-0000MK-Pd
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 01:28:15 +0000
Received: by mail-pg1-x544.google.com with SMTP id w6so5594849pgl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=2P+pkq/TAVJfpx+QVUhCn9RikOPq88PivZzjtOGkCms=;
 b=PX0kpIsHZAopLUpTUOPcmSxdoYqWG3Yy2a/gSt4fMAnFTPMwwUZp9lvNX7iUhe0CEO
 mr97YQ7w7MATf/6pJT7ZjTp5xduZAHtwnnPdIDJ5cb3ltat7IkZXULfiL7Iz5aMqdKmb
 M1IPOaheORYcAz6PekI7TF5iRMtxmFJWNu6bHeQM56HEB3a+r/+zhiKS29cOuIjP50Dq
 +mv6Kn5EWfNVPwXwYrsIhj7tXR4JUNhGgkE3oiTS/CeZoxr5Nn/fVQjE6mC682Hrq1My
 arIrXEGnTS9VKPbcKRtVdYDn9EYVAKzl1Hk7q6W5/SPh8wZsW9V4vUCpsHs66BuSnPfj
 VqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=2P+pkq/TAVJfpx+QVUhCn9RikOPq88PivZzjtOGkCms=;
 b=qwabXGhm4/GL1gN1dwvkKKHmc2bqMJYNuScqtgdREkAUGgLKAXRBmQn8yeE/80JnGb
 tGkEVX0I6DD93WCqnUv1U+NtjkTUrKFRPJrhDTv4id6NLKbOZEAKkw8Uup7qL1lu76V5
 Gv41zQX6rgDvws6Ci98sbe3Vw9i8xMuNDq9ofWp5SmQH5tfHkQYkldjNnTthV1t4wFZR
 ZsIQdLN98WYSjs+iFDsppdU1RvjdjF+dLBLiBl43fHyegm/Xs4/DU3cxzFIDqCx9xj6T
 zgB9ZRjyRwwGM3SU8R/8R2Obt468c2Td5SpUM5Zrsp9V5FcdqqvAJf1utxMFzemzGDQG
 OThg==
X-Gm-Message-State: AJcUukfIlUucppO3o3h2Udh3IuAbxSx4cZG/tYRfRRv6ohHqgmcn67dY
 fDwCT5gEYlZ4R5l9CH7ODYTqKw==
X-Google-Smtp-Source: ALg8bN5IO4BJcANmQlKQXyWnapZsR/3IqoI/v9r4ESHNsrGTcIk1c3DNbMbLWi6X4V8xHzoCBXXJsQ==
X-Received: by 2002:a63:184a:: with SMTP id 10mr11378583pgy.81.1547170092711; 
 Thu, 10 Jan 2019 17:28:12 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 r187sm242710873pfc.63.2019.01.10.17.28.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 17:28:12 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Loys Ollivier <lollivier@baylibre.com>, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
In-Reply-To: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
Date: Thu, 10 Jan 2019 17:28:11 -0800
Message-ID: <7hftu0oudw.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_172813_831219_8FCAC748 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Loys Ollivier <lollivier@baylibre.com> writes:

> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> changed the behavior of "cd-inverted" to follow the device tree bindings
> specification.
> Lines specifying "cd-inverted" are now "active high".
>
> Fix the SD card for meson by setting the cd-gpios as "active low" according
> to the boards specifications.
>
> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>

Thanks for fixing this!

Queued as a fix for v5.1-rc,

I see that this is being fixed in the driver also, but I think fixing
the DTs is necessary also.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
