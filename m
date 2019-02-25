Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:20:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD48C2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JI0QKHHv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hith3tE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD48C2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RsP7ZwlLwppZ+Ikj9yBbVgVsNud42UZAYnZUoClY9zc=; b=JI0QKHHv6oS6ox
	PXEu/xnM3rSmNG2YXUxbAa5pQJ0g30zqLS3fmRTFIORFIObPpHdjveAUFM8G/iPwA4IwXLuo4pLhO
	5kBEIzYqeQF+jykmNHgEHgfqXRMG/ddO+Rg61Ab7FEfgT3GncnSV2zXfl7QX9UrhhtwrZY8ndv2L8
	OR5O/DWsn5w2YomK+UofdYYgrzuXxdFMXVhr961aAPlSjuFr1iBpmBtJd9IIrV2j1PMGp6KusXdz1
	/v8Ml/H2QIymQbLPoDrPY0L7f9bWncQ5Y8sp7saleeWM4tHSUxsWd4t9AKM7igz66X1hceitURHRK
	zN5OQznzpVWmzhlldeHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyQUP-0001lz-1m; Tue, 26 Feb 2019 00:20:53 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyQUL-0001l7-Qx
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 00:20:51 +0000
Received: by mail-lf1-x142.google.com with SMTP id z196so7600596lff.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Drmc1vVJjOc9vytsMe0X64Yz8M+v4yfqHSmOLxaAl6E=;
 b=hith3tE+pVyUT59KL4PjCV27zF09x4kcF6qylISpwq66D8Kc+aKNi0+zqvbEc4Bd9r
 xgRjkYIhrW+uhqBmDkcLU932ib1NLnFD/S5GvRE6lNJ5Yn038rMPznmpT4m0I+I+R+Fl
 Esy/BhEpFT41xB4o8WoUcgHzlYmGkz8s627/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Drmc1vVJjOc9vytsMe0X64Yz8M+v4yfqHSmOLxaAl6E=;
 b=FgHGqe5pL79bepNYF6yJPAQHDa1l8Ot3sAK5cDE8UZl/71aE1Z+25QQX+gEUjDOb5m
 vmsJPzDM84fDSRaQEFnMzsDtO6n6FmVxrHap15JJYjhafKlyBqeTM0LFqn8yRzp4KkNX
 jwkeBt7WPlzd7hx4jKN/1NDw61NhOkbKYqXWlqj6oQzgTTd7mJ5Vq3cTYLAwIorRkJog
 5Gg6QZWubTgC5B1efCDAWlN/YdlI7ipog81mVGxbuZitUQmKe7M1qbn8RKVfEiERHAVU
 6C0Eu009Mk0o+p50e3cQR6tVdlRLG6WL6fchTXH5RCMdeYMG8pMmhFpiKJUS6TZAevYR
 v78Q==
X-Gm-Message-State: AHQUAuaoMGtfmweQWjVhIZQKEx2EhjwQhkhZz1N7EGmbee6zLaWxXkkJ
 APYaE0eEFUnpFI4GZFfLTdStN0NiSXQ=
X-Google-Smtp-Source: AHgI3Ia0ZULcOBIk2Hdz8FkaSZBvMXqvxL1Nx3tHtTndP7gpPYEHWJxMFEatOgfxevR+buzLABECdg==
X-Received: by 2002:ac2:415a:: with SMTP id c26mr12522209lfi.62.1551140447593; 
 Mon, 25 Feb 2019 16:20:47 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com.
 [209.85.208.179])
 by smtp.gmail.com with ESMTPSA id d26sm2571325ljc.15.2019.02.25.16.20.47
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Feb 2019 16:20:47 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id v10so9156096lji.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 16:20:47 -0800 (PST)
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr6570115ljh.184.1551139006617; 
 Mon, 25 Feb 2019 15:56:46 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-11-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546318276-18993-11-git-send-email-yong.wu@mediatek.com>
From: Evan Green <evgreen@chromium.org>
Date: Mon, 25 Feb 2019 15:56:10 -0800
X-Gmail-Original-Message-ID: <CAE=gft4_D=vtM_cbrQGKz8XwHUF_JR3A7uoJ93OsiLBmvW9L-Q@mail.gmail.com>
Message-ID: <CAE=gft4_D=vtM_cbrQGKz8XwHUF_JR3A7uoJ93OsiLBmvW9L-Q@mail.gmail.com>
Subject: Re: [PATCH 10/13] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_162049_898955_6833545B 
X-CRM114-Status: GOOD (  11.82  )
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
> After adding device_link between the iommu consumer and smi-larb,
> the pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. we can get rid of mtk_smi_larb_get/put.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

It's possible that there's so little left in mediatek/smi.h that it
could be deleted entirely and its last remaining bits absorbed into
other locations. But maybe it's nice to keep those last little bits
used by mtk-smi.c away from the iommu definitions. So it seems fine
as-is to me.

Reviewed-by: Evan Green <evgreen@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
