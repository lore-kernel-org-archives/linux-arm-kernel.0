Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D523C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBAD207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hp3iQLSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBAD207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qEzbAyFsfDZ1d55o8MVzzD9nI0a+bHoBI9REEzsv8jQ=; b=hp3iQLSNntPTW4
	8vGnpwDKcyefrTAcQzb9wtF0PeRwl6czd9ZcQAZOBcNOWZxJ1RQR3IMNz4BUexqkkfQ8EcP7wA3G8
	g6BNP9rKRMmGU4X6GFst03Lp0Iit6tq6OgIsIgoXHD0B3/0c7wuAtV0rV38rt1E5U3gfhXb18sb9E
	XI30fkjUZfCPjMKqDNnaHj2hoQ+/yFshUyOI8zxpzs7Rm2wXxH8lqzz7ZV0h7j4Wq/EYa3YfhkUmw
	z3di7yNQ7zPwR9Ddu7EfMqZaGtiBoUBgEx4LkBOnRrrkjRya/8zYdXrih/LK9555AMXonEVNvmGc3
	e1tRHkrqIV9xDtiiM5CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guf33-0005Z7-5n; Fri, 15 Feb 2019 15:05:05 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guf2w-0005EY-Lq; Fri, 15 Feb 2019 15:05:01 +0000
Received: by mail-qt1-f169.google.com with SMTP id a48so11177436qtb.4;
 Fri, 15 Feb 2019 07:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jFmO8AVTZTYyTknNr5F2lZBR3E8qi8TLFXdxFtx+VZY=;
 b=jkUAP5xztHA6nnfZfgnF4maQ0L/pTdrizacNx/rC73W5x2CuXti56cYbTDOhFqh/cI
 9fMvPr/vnrH2GZz62H4piLa28yd0I9DatZ2yFAtC2TWEtGBQLzLuyo217G+xaZHmOPag
 KoGgB5bO8Cc4ZYSa85fjVeNyHdNUu440oCk9766RqbadgYHWW3JS4WCuFeiZt0LZUod0
 JSpiwvb8FxKGxXnIf/N8dJEE5uRgsXcDua90oP93URHQWg8kjCwn0oqZz1t9+f+31rLb
 ySSAvJdEOtz5imsZkkImpjJt0yhasQoyudz9G7Xy5nJFNCvTNSuynj2ghTJc5wyRPlPN
 LQMg==
X-Gm-Message-State: AHQUAuaE8rEtQ1lTIViH0qK5uALGsc/uNcreusRSkNLJumOrucugK3ev
 csP+Ljfa1zSqLuEyHQjLhkig71EuD0hCCInYIbdmtQ==
X-Google-Smtp-Source: AHgI3Ib/1Lqu38/w++0Xlw1kGKfQ8HccrQGZgf2iStPUtL3rDbTXp3JTRKmncUAKR/plvG4LXcVLsx0ZtiQnDG3Q7Ik=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7590636qtm.96.1550243097751;
 Fri, 15 Feb 2019 07:04:57 -0800 (PST)
MIME-Version: 1.0
References: <7h8symdp1h.fsf@baylibre.com>
In-Reply-To: <7h8symdp1h.fsf@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:04:41 +0100
Message-ID: <CAK8P3a1mLpvvgVZSPhy+zoZYgwDJbBZ29LB-BYAsEaQMZm+K4w@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: Amlogic updates for v5.1
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_070458_707622_411E0B11 
X-CRM114-Status: UNSURE (   5.71  )
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
Cc: "open list:ARM/Amlogic Meson SoC support"
 <linux-amlogic@lists.infradead.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 9:54 PM Kevin Hilman <khilman@baylibre.com> wrote:
> arm64: dts: Amlogic updates for v5.1
> - new board: G12a-based x96 max
> - G12a: add peripheral clock controller and clock measure support
> - s400: fix SD/eMMC max rate issues
> - s400: audio: add sp/dif in support
> - GX: support simplefb

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
