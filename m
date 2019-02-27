Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:01:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F8920818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNU3adFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F8920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XuNsdZKSVsW7s8HjYMyV05NKQYrsmbU1ZvLyy9H4C9g=; b=jNU3adFpdHjkS7
	g9QrROMUvYOlO2BjAJOFeXEv+UjnGuSgYwtsNJMHxMeNnJP0ty8Bgih/VwnNcsHTtreMX/N8Z3T5P
	rfGuDCJZzhrk/EqA8XaCI+yKPTzsspoMv+8aVDVS+OiIPgxxzVg9sOdvKVGKpSpclZ7KvN8FTkk5J
	yvxrtvMzoEsKRTcCqM7uADHsoAg1vef6zXOtgV1z8HlMdgiQYLdj4NphtRrt5nIiUIvwsRaTVBYKc
	1vFMWTenjj4wxpC1R7FBvkHTnYnlTGgeF9qExqIPCcsajTNQ/BJZ4OUndXKJk31S0oWru83pIusIF
	aPCuiWAutoaL3s9Qex9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz7GO-0007pz-7O; Wed, 27 Feb 2019 22:01:16 +0000
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz7GL-0007p3-3A
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 22:01:15 +0000
Received: from belgarion ([90.76.35.80]) by mwinf5d21 with ME
 id hy0w1z00N1jkVcS03y14dU; Wed, 27 Feb 2019 23:01:07 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 27 Feb 2019 23:01:07 +0100
X-ME-IP: 90.76.35.80
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: pxa: remove CONFIG_SND_PXA2XX_AC97 in pxa_defconfig
References: <20190219145214.3811804-1-arnd@arndb.de>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 27 Feb 2019 23:00:56 +0100
In-Reply-To: <20190219145214.3811804-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Tue, 19 Feb 2019 15:51:57 +0100")
Message-ID: <87y360lwmf.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_140113_416757_90492661 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The CONFIG_SND_PXA2XX_AC97 driver is for the old AC97 bus implementation,
> and conflicts with all the new-style AC97 drivers after the conversion,
> so the drivers we want all get turned off.
>
> Not disabling the symbol however does the right thing, and we get
> the drivers that are selectively enabled here.
>
> Fixes: 25540f68c871 ("ASoC: pxa: change ac97 dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Yes, most certainly.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
