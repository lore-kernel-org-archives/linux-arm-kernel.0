Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647162087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8jENy5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647162087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YDvjUZhsxQ3EMXpWr+vpo1cUhjUUcOQVYWA2nS01dTs=; b=J8jENy5RZo8ntE
	ORFNVkR3TzKJquoC/dAKwLPck9tTWKcHT66ghL6E/fglHkrrjZchvGl+FhEXp2T02UVHvY1C4sI6/
	Mnx9ZqUERevnjiMol6ihk3CB6m72ZWszSLmZdTIALHd1+DogR115rmjgUPaN9SX0tw61oSClFaPWM
	Y3yKKDVZApoDRT3seVSjPvU+U1zpXOFji/6VjVhWyAuZBL1TIm/bNS8nHvv7LZmNFQtyzPKtBUr0u
	TqH7a7aICgkOOVV+2GeeSl9Yjijwokpw9vKWRghx3uCJr5UKIoqqf9vN01Mxj3Bns8jAh2CC5H6m+
	7GekpJXowc+6IE+ITNsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiML-0001KL-Kh; Wed, 16 Jan 2019 10:23:45 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiMI-0001Ju-57
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:23:43 +0000
Received: by mail-qk1-f194.google.com with SMTP id q1so3387291qkf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 02:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qENPHBLa3vkY2Rz1BSdZsiSdrZs10EHyo4tEcmR96hw=;
 b=SEWFPChx4GbS2rKoV5GqzEdc0gnP3cRNC1R7wcnnb/+byLNWXux21A1vVzH/hNgiEE
 K9HksdnV2ck22cg3rXvv91uM1HoHuK7GeOSj4IkU1J1nDM+QyKuoz228BFOL3XCHq1FZ
 qDzv1eMU4Pde90JJJ447sJhZz/8fXl6sopko5qE9w2yUYmKC+Q2+pZyhKZzOxRgUaEzQ
 W3nPTzkmQ4ZngmqhAi4kFocSstoXVjy3w1RLRAZM/L00xUtH4GqAAGVE5XVrmo7S/p+I
 duJWgKDbyIplPcCzxt96Y7mEfTiXGdFXrn/j9HB1CbyUgzKMVDXLbOhWQwuD3me+1k2C
 8FtA==
X-Gm-Message-State: AJcUukf5Qr2SnQfMdY2A/jDx8HfDc1SdRnDHbSLPgHZYMpW1gvYCtitt
 Hj+b96Xa/M1boEEbUzjOQEsMzC2jiOKD3qRMeBx6xQFN
X-Google-Smtp-Source: ALg8bN7mvaGILjS6suKt8bGD4h5kdv5zMwhrIuJ2BgRGXw3yy49rbCLkwlSkJZnl9lox0+Li7yynjmFdR5M/X1zVzMc=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr5972882qkf.330.1547634220697; 
 Wed, 16 Jan 2019 02:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20190115230613.28334-1-f.fainelli@gmail.com>
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 11:23:24 +0100
Message-ID: <CAK8P3a2NHvWq=tNURuScDHLx7qT0RaBAsjewaf6T24HLJ68NkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: dsa: Split platform data to header file
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_022342_191624_AEE09207 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Networking <netdev@vger.kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support"
 <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 12:06 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Hi all,
>
> This patch series decouples the DSA platform data structures from
> net/dsa.h which was getting used for all sorts of DSA related
> structures.

Nice cleanup!

> It would probably make sense for this series to go via David's net-next
> tree to avoid conflicts on the ARM part, since we cannot obviously
> include a header that does not yet exist.

Agreed,

Acked-by: Arnd Bergmann <arnd@arndb.de>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
