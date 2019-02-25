Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2ACC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:54:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC1621841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UszYud8b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jo7Vy+jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC1621841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2RPB4PJRazJJ93C15dKKIyyvsl33x/1HLToH9Pfj2aY=; b=UszYud8b5yO+Fj
	zyJdAg5wgA2JIYEcQEyhEAeJyvpMldkSUPBHq24VDr/DKbVmKVZ7JHocEsVEKKgpvMy3Jsecog7Ow
	AsXp8LCLnHuXjmXpE3dsg93ECinyQUyVse1ONR5P/S6Vst0sor2mhkQGC4YH/SWdammDK0S6Ykcsd
	ozGY7kuwuZzIxFawTe7Y9SDnwikf3CMiOoBRU2CdJ0P3S89LDpOg3xQE/Cy+6Ht1tpI9Ne1arNwCJ
	62W6NoxfcXUgwJs1rglRHlPC+SzbYL1dRsDW5dRmIpKl2BfJioYwrvKfTm2BFMJOKIZp0G1Q797uu
	gpKQKpvxj2LJQSKt5Hgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQ5I-0008Sl-B9; Mon, 25 Feb 2019 23:54:56 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQ5A-0008IB-Kr
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 23:54:51 +0000
Received: by mail-lf1-x141.google.com with SMTP id z196so7564764lff.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wMX9Ml2XVdmdZ64dlD0uAky14OAHXuYnOUzBqziTxFA=;
 b=Jo7Vy+jYynanNQauVads0ABU/5uxCvgWwevdsLzsVa1bItuxNfpi7QM/Q5uTZdAhxH
 XrDcu0CHn6UvURaPN9KGwlsZpA5qIrZCltlmglj2UtrDRQIbAVDxng9EnMlIxcF43yZq
 CwihTX5a9aDU+LZ+AsWSoacY27ATMSDRW5WR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wMX9Ml2XVdmdZ64dlD0uAky14OAHXuYnOUzBqziTxFA=;
 b=Zm9qnFFUK5n3b2/50nXOkv1SO91agTymjH/MO+KdQpT3T7oMAphGX8w9urO+G3gy+C
 nRw9kiy+cYmuI0c4QRaTjxgK8N3wLitBY4OTdsCqyqZPaRDVPbnhkam6XAmrbF5QmNBD
 duqZnQgFbQPOmaxB9qZBcVxq/AOYYpsljPsBo7GhI/PJuPllvTNd6n+3rLwuW8vHMe8h
 T/sJVU5qeghpmaEeN40mjf3euiqm7DiaDFQUA24Ru5d7HQXOwtbQ66tGLfCKIrb0r4bh
 Lmp2R/1poJZD6F1OB6ymNSMpA0CMRIvgpacuMxbvLJ1BweaLc24QNUQPsOQjqwQ3VaC0
 qtpQ==
X-Gm-Message-State: AHQUAuaxQmE4wif2bmwx1vQOOIFnMiH3f2UX+s0XToN+qMjHA0TTz2nL
 ZEen+n4alL13L8gEVLQNSGsv/C8oIY0=
X-Google-Smtp-Source: AHgI3IZ2UOy4W4vuq794NGvZOvxPGndhg58uA0cFR0/GOcMuP7inCFgsXv4v7j2e3WYRCY8awcprEA==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr11733656lfi.3.1551138886837; 
 Mon, 25 Feb 2019 15:54:46 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com.
 [209.85.167.42])
 by smtp.gmail.com with ESMTPSA id t14sm113756lfe.51.2019.02.25.15.54.45
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 15:54:45 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id j1so8237179lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 15:54:45 -0800 (PST)
X-Received: by 2002:a19:2d44:: with SMTP id t4mr11331025lft.90.1551138884649; 
 Mon, 25 Feb 2019 15:54:44 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:54:08 -0800
X-Gmail-Original-Message-ID: <CAE=gft41kvHVY=QJCK7y7AUwPd=HQGHUKoDUAAk42bvBZMExvQ@mail.gmail.com>
Message-ID: <CAE=gft41kvHVY=QJCK7y7AUwPd=HQGHUKoDUAAk42bvBZMExvQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek, larb for
 multimedia HW
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_155449_201631_28977419 
X-CRM114-Status: GOOD (  11.52  )
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

On Mon, Dec 31, 2018 at 8:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need the property.
>
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
