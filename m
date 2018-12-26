Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3CDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:14:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090FC20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HNMl0keI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Wy/zpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090FC20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7RWlWfaWucMd60hWtuaM69zmfOP8NJfzyfouCWMq1w=; b=HNMl0keIONLB/w
	rpxCYMBWPDtqbr8voxdONrXme8NjcwXJiYa02T+j6iQ9GSyvgdZkPRVcTfCTxLJ4T19XbTd4vZPWM
	EtlNur+qled5YbYZ3WRigZmD/wsssB7sCiuc8pMcQvmodrrRofepq2Sec0sFnkzPlrDYd8dT5jGiW
	GKh+xbo1ypxTld/zdY+BGwTVwQYf3rDtKZx1S1f65uxFCFEbqUg28leRPF3UzwuJyqGKqNx7q/U0u
	fOfwPUSQw2ENeUeWRAFaqsNbgHh+CzOjiIG0HDYN02NABSJV+Wc+QnETkP4w/2WtjuOi5tUxsV9V3
	ER999EAKeIVBphEr7Naw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcBp2-0001Dd-PY; Wed, 26 Dec 2018 16:14:16 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcBoy-0001CG-P3
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 16:14:14 +0000
Received: by mail-io1-xd42.google.com with SMTP id r200so12561306iod.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 08:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
 b=d7Wy/zpiEDojUMb9N0asBGvyIpZ1A3NDn0Yu8kS+OMAhs4YoxUfcuUxDxRjw8e9ZQR
 zbRVWKvfRW8+wQFozgFKyeAN8PrxOoOehk5YMDL0pDKBTLU4gnAB7g6qrUlem3ZYw7xB
 4O8dlRX6k+onpCjqHeFmDdXwfW9aZSR94g9zw+2AWvioGNIO7LHyQFgniaPaUV/IK8cR
 h/2Tb9AQkwpopqr6vjV1lzOv5icTwMUJMTLE9LN83t/Ap9+llMxflyZSG/EgmXer9CXP
 qJH5YWRtktX8zKzqcN4EukLqf2QnGyl6Q2uJ+iuJ6zsYFDsylgyYQCvGHdhUnNgqOwv3
 Va9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
 b=DaCjwjVaXRPlNSadY8VWFQdbzX4h+h7/VJWzwnzjkLZ8/MpftWsW/HGkuYtuClii2k
 vhE3EusJnaIKYzqD/T+PuLd3wXYuHyeOfsGRO8sbhrMdJ01j9yzB3H64ClmrbDytjC5/
 Nk/gXOMAOqxcFKwkHVhZVV/c69NdEtj5uFoNmqrnEaP694LrxJADoxixSOW585QKmKM2
 CVLY+RypyAhy3s8Amem5eUHFYN+voOIOlscS9HbIxxdVZ/p4P+DLOw95+exzdLM3T8R7
 k482AG/71c7X+JpVfbV8Al4Nkxd2GNwQMPfMMh0hHkDxbbTU9qn+vB0xHD9Sdu1Nv5Ve
 rJHA==
X-Gm-Message-State: AJcUukeTIWqADcwq3+RV7ub8ckC+YkgghfEdgZtfSzJGy2ZjSqEqDbLA
 f1n4JTbHX3XvuSzdDVzHarCxqnnyX9CLmG50ryk=
X-Google-Smtp-Source: ALg8bN5ythGJpfOZj3Pqn8G4bsotfiFnF1kB6k1YbE+AFtgg4EOUlav1RN/6wRUGVGAzD03f40GUnEc/Qs+qLrcg7qw=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr13375934iom.7.1545840837748;
 Wed, 26 Dec 2018 08:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20181212162014.23409-1-tiny.windzz@gmail.com>
In-Reply-To: <20181212162014.23409-1-tiny.windzz@gmail.com>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Thu, 27 Dec 2018 00:13:46 +0800
Message-ID: <CAEExFWu4Q5V5KFeD_UV6YyZpzuR1SJEOgv_tZTw4=r1B0yS0mQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: exynos4-is: convert to DEFINE_SHOW_ATTRIBUTE
To: Kyungmin Park <kyungmin.park@samsung.com>, s.nawrocki@samsung.com,
 mchehab@kernel.org, kgene@kernel.org, krzk@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_081412_813279_12F66CF5 
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
Cc: linux-samsung-soc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ping...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
