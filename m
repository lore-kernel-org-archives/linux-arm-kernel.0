Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C33C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:23:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B852184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RfOivzbM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IGu0uBZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B852184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sRZPu0DKpVVIg0rar5WQuo3kvrR0HWuZdcS9SS0isE8=; b=RfOivzbM9r2Bwz
	QYqUwWx3i4wFpdd4/sLUimgj5z9v6Rlty4HQQPCEV33KvKQ4LlzSgswrzFF64lPJ76RZvkT0J9Z+I
	SZW6zsCrAV3M1QA+D1G2tVnemyzzEmKXDvOMQnELClt7t+Mnw9sL8OjpvY5FI/3mjaeiHQPwQ5v7a
	NJTGHu67h6fqcuKtE8ywGxPkceInbWMLmu+V8vNlUcxBGOQIWFbmBBj143iyVjHIMXb4eR5Ig1sP6
	a1XQAq5ZLgbPvU/PtF87DGeOALwKZIc1nU8TR1T+WoGIlp+tlo8pdTp4E+ZepU8xdDjds/wuQYgKf
	kUcD7c62jq+OMdisAoNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQWu-0002pP-3L; Tue, 26 Feb 2019 00:23:28 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQWq-0002oh-6F
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:23:25 +0000
Received: by mail-lf1-x143.google.com with SMTP id m11so8298373lfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
 b=IGu0uBZ0JEGH8HSNtooUP31VXROhGihub8ByKCYo6jyf4UrXrRLt9vm1URHxbb+Cme
 Nfht+N1G7l8GYOwZPhAGc6q0qotrPTPk/zXqNuomFhyGAODz2zBgJ8PmYWEh8aABjF1X
 MV9ESsSLrvTd4Rnw65oCYzVttTSBPFhLvIl40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8tZwR/zt5ZZMcpwi9xVzbwgZJ4rn4m7mYsGQrzVWldc=;
 b=gBxDG0aoV9DafmLyGFEazaWkJHlocSyeZVJRNwAs1UJXw+vyZLQt7LHtZh8QXNhIvK
 BoGWmu5oMCF2RLci4HlzwnXP+LSRi6HjWj6SyPVfZsHAMTnVOPlXsNGmvG6J96t4zY+7
 S3C4Ekxazau1kq0I8EqSpdQBKpeNH81MWQVTteLauz7Dsv0x2bmfo7MLYhnp8OEqm8MV
 LMALJCCYrhuBqqmJZz9SUgeleFRSnaWvjcvsc+ugQaDJGJx3hjdUYv0d7FQkqN6fkQHc
 Ijni6bviwpzP3Fcukt3ihAiInRkpjoIk9j90M9qEutphgsbrsEzULmsOCSBFB/c+NhgN
 v9/g==
X-Gm-Message-State: AHQUAua8N2arv5J+2Bzh0uB6dh1pf71yQMGizbmCPmOebNBJOPxl/KAh
 iQrogetFl4sl7I3m9mLdftV58skbpnM=
X-Google-Smtp-Source: AHgI3IZq8vh5Fu3bMytjUoh1PRhDCZVsLs+32LZ4JkE0CkzNUy5qwIAMtDpHhKlWH9a9cF8wFWlcYg==
X-Received: by 2002:a19:2d44:: with SMTP id t4mr11387261lft.90.1551140602436; 
 Mon, 25 Feb 2019 16:23:22 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id z88sm2579323ljb.10.2019.02.25.16.23.22
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:23:22 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id z20so9118634ljj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:23:22 -0800 (PST)
X-Received: by 2002:a2e:2ce:: with SMTP id y75mr11073232lje.126.1551139049916; 
 Mon, 25 Feb 2019 15:57:29 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-14-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-14-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:56:53 -0800
X-Gmail-Original-Message-ID: <CAE=gft7qao1BdwPdoeBxOhwRtQAhzqeiP-mPQvXtjjf7Q7TZ9Q@mail.gmail.com>
Message-ID: <CAE=gft7qao1BdwPdoeBxOhwRtQAhzqeiP-mPQvXtjjf7Q7TZ9Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64: dts: mediatek: Get rid of mediatek, larb for
 MM nodes
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_162324_228222_9FC91330 
X-CRM114-Status: GOOD (  10.82  )
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
