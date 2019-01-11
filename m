Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E32C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:26:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959A320870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iJcpHlC+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wg1e9/P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959A320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=je2OsknKIoiNeG1FK715kQFKR0MfvwqUV5i39/PNdFM=; b=iJcpHlC+op56uZ
	U5QSXK1fdqdHFRmNf59eTWPb3W8T6g/2+fUMQNgO3lw+wgzAoMCtBi9gC8M1a4nrcte9sRLZuU+gr
	wqirGzXVqOdJ50weEZiFxFZIgqYIL2mNgaap15OxhK5d6Rk6I/n/XxquUDHAXYRGwh/2CLefxKyZA
	EnHuDwvyewuWhl/25ITn4clJebGJPgrXu8r/B0voJ0vyeY2FASWiJWH/109Tsrhy2iqOXJSFrdlCD
	+IxEtKwY10l28e4g9JfrEnbEAr0v/1ljVf1jxJMhDl2L2vcIaDriGpYt3FY5yO/O9UJSJpiLcigqW
	Xk22HHhStkQbr3cua6EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvs5-00011x-TP; Fri, 11 Jan 2019 12:25:09 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvs1-0000P8-Av
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:25:06 +0000
Received: by mail-lj1-x243.google.com with SMTP id s5-v6so12738988ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 04:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TdsESOGbRKiRNxdPcXpg9XNxPPBWWG5+p2LUtuOv3CA=;
 b=Wg1e9/P0IQ7GBlEPv+F3XAL0xi4w8pywuaBIJ1b1D3hIPe9SjjxboDBctrnx50LMK+
 wkOX6UOkWsYx2ZR7IsTdNFZDafkWpBvdSznJnTaw144pQizOAgFpsm1Bn0/b6ysyy5FT
 Ddzg6kMNdFNMTek3ZgH5+Is1Ybi4/FxttLWXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TdsESOGbRKiRNxdPcXpg9XNxPPBWWG5+p2LUtuOv3CA=;
 b=ieASh7M8iut+FXe2jw1C44ooBS+wChihUTne86oCFqUenU5b/rOXePQ0oQ+nPiAzW8
 bsAomM+zETm1nJuWoCfHDBovpPQ55T5zGxGd6mulmuR1Rgdp9Kw1vGRR3iDtwl35FTos
 cAiCT1rkj36nPXiUoU1B58fZOxCOtSkq6Yd3+pWMC2edQxyZiH58FEt34nQZF+3W9pbO
 1WT++Q2DkaLtfLbMrf/I6kvIJoFOYonTm2Is2RihQsDQxY02VW60xc9kXBM6aTvWoTlk
 OXzpKDlpgq+cskD8HS7vZ4RGybZNURvxyiH/eKahG18j3MGvEPsD+M3y5YMZWqyuFhxQ
 +HCQ==
X-Gm-Message-State: AJcUukcsH0JP368dGKCf+1MK5z4+zmyNI+O6VrH5ezHOimRjE5efZwIt
 4qe5LcLBhFKJeB7/friCW6PzD9QE6WQnyMSSyjAdXA==
X-Google-Smtp-Source: ALg8bN4E6VhqTcppuvh3BjDY7EX/U7s+63hNCiJmT9bByc9mNbf/yofgZnr+qfj5zQNrwgM9D36r+IIiMXw1J4Kbqcs=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8469613ljc.97.1547209503753; 
 Fri, 11 Jan 2019 04:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20190104213508.GA20333@embeddedor>
In-Reply-To: <20190104213508.GA20333@embeddedor>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 13:24:52 +0100
Message-ID: <CACRpkdYoVLARk8oxqFesKZ0FDyqCoaoxLdTXR=0TS5N_PQdyTw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sirf: atlas7: use struct_size() in devm_kzalloc()
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_042505_382726_1F537844 
X-CRM114-Status: GOOD (  10.99  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Barry Song <baohua@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 4, 2019 at 10:35 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     void *entry[];
> };
>
> instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
