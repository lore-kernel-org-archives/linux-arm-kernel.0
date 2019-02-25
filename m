Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C7CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:29:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5827B2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cnQ2hEku";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GF6Ex+WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5827B2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRZPu0DKpVVIg0rar5WQuo3kvrR0HWuZdcS9SS0isE8=; b=cnQ2hEkuYXN5TA
	Omp5jCyvv3AlNzqaR6MiK24pw7obNYXNO8TPfKCs/vQNWpj9nqawI+CzCnWj2ZuWt9wJ96S0b91E7
	F/db3JWLXJA0yCOteIioWLoua+TGLTrVaENjFevjhTx27ee/GAt6xSUabGwLHr/LcE2TCWZeVmsuM
	YDMh9be8ztoMUdWYVBukoLro6YT4q4MpZ3yBO56ud6bxLe/stRIT+N17wSXO76dx7S0AlyqkNTjuF
	Z55li5OpPQdXwYnW5v+n3spqvM4njt9S4AGawrrwd6AwQjM6uquiVwKmIKqdy/uDLUcJ4FAkq6NIY
	THVcJ+ZKC15nv6hEjiPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQcp-0005Av-RS; Tue, 26 Feb 2019 00:29:35 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQcn-0005Ac-D9
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:29:34 +0000
Received: by mail-lj1-x244.google.com with SMTP id z7so8966756lji.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
 b=GF6Ex+WPJgKPYaYMyiIbId6RIukmmSazsTWtV9xn9LdGcTAJYMpyGGB9FFXsFydzv2
 LkaUPFAXn/15yW0zr5q1QGGvuChK26PFnALGnpGwE9KrHm3rsA8CP6x8Xyii+g8Yn+L1
 Ke7i+KyQTxyMDH7waWKg44lZOM1ffsHMVAzRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
 b=fJGHDScwzmlZp87P4AF4iTJ/p8TXz9DqnqolQ/5Zm3iIRWzLA9VhJ1YqAKS6lMznaL
 N1+w/cuVnyps/2N6sHsLsCyD7T2nL5K51QX/DKjbE95v8pmA6Mv3pXfOKq5XfCiunJ5Q
 AZR0WyJRBeD9hEv36pb0wCkR9GbQmA76giR3vRyL3dlbpWUB/0dnQJk0ciPZKmI5r4yZ
 Mr3qol4+TInE0nFTDNFnizlnIEXRP25vKWqWYNwCdjDO89McIf0ZCskMkjlepXSWHBCd
 la6hoKVatUC2EtuLonzKAqBwLcGhcqEV8xlzgnmAmWL1dn1/eX0obgc1sSeX6zloaTof
 L9Eg==
X-Gm-Message-State: AHQUAuYuM9GPG0w2ljHH12ZFPIJ0Lak2N5WELR79tjyYg7Qa/UXfAxyO
 89gricjuN4s1E8xL/EfXPyJdyUqoZDo=
X-Google-Smtp-Source: AHgI3IYWSwPGopQE63UnOp9lGo9b8K7Q9MxjVBwKgwgd9iqeN1MOTS7/UeHFToGwN/uCbiD2a7S8xA==
X-Received: by 2002:a2e:9001:: with SMTP id h1mr11669157ljg.5.1551140971073;
 Mon, 25 Feb 2019 16:29:31 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id c86sm2578687ljf.28.2019.02.25.16.29.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:29:30 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id n15so8306958lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:29:30 -0800 (PST)
X-Received: by 2002:a19:ed0a:: with SMTP id y10mr11846459lfy.154.1551139034938; 
 Mon, 25 Feb 2019 15:57:14 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-13-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-13-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:56:38 -0800
X-Gmail-Original-Message-ID: <CAE=gft5KJf=mx1zmzVPxGw7roL6N9Z4QvDSyTekOCeBzaTDQVg@mail.gmail.com>
Message-ID: <CAE=gft5KJf=mx1zmzVPxGw7roL6N9Z4QvDSyTekOCeBzaTDQVg@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm: dts: mediatek: Get rid of mediatek,
 larb for MM nodes
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_162933_440499_BD464234 
X-CRM114-Status: GOOD (  10.72  )
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
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the IOMMU consumer and smi,
> the mediatek,larb is unnecessary now.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
