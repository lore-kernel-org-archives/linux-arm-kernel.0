Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1BCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:18:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F00D2190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WxMJD54b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERpkjXHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F00D2190B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qlKuBbyYPWBLRHCQqQGBHit4PvnMtmN6FBFb0daTDZw=; b=WxMJD54b5xiGeK
	+/nlhFEuOi9GP03uuNB0RJi5B6o2vbN3p3SEHL0Vpjjq1wWQ5JP0U6asR0fmMgex5nJTIXenuo6YN
	gLhG7hF/u5oSn0W51ef/VE/ExVFELwJXIYjvk+ZuQg8Mf0Bsziqsv7OROI/QUhfUlLGbWtn0Mw42/
	sdYT0vnJcc8WI/ee/xV0KquWnFl5cffLREf4yL4nQ9ij3G8dihGAwNNQAVX4RoxXRp+qE2csUdCns
	PkvV8cjLRTNVR8L0Y+91vIsm7ibV+ZkVeQLVUTUV3dJ5AAMJ2x4sSY7ocBXIYtiIMC8Pz8AKIDr4Y
	eOn56cv3H+up9vAUj/HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZcu-00016P-1e; Fri, 15 Feb 2019 09:17:44 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZcq-00015V-MS
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 09:17:42 +0000
Received: by mail-qt1-x844.google.com with SMTP id w4so10156458qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pHeu5JGMOU1EgxdvztFSk/kQgSEyGK8ZIvx2jHvc17g=;
 b=ERpkjXHUOVvbEoaP7Ix7pgMW6Coci96ne1h9iiEQ+IKpGoyN7GqYw4TgO2qdRhDYBy
 jALmTeWdZSGIVCXLP3WJfo0sd7IsqnhNjDWsoWKfLMmXYxIWQjSjNaRLdaGUoe6pgZ0Y
 cpQG3/2yznHn24BoQqsBDF8XA3UsMrn7qCyws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pHeu5JGMOU1EgxdvztFSk/kQgSEyGK8ZIvx2jHvc17g=;
 b=sbzW+7ZoQ6gAakhLkijlcK4rvPAbuCCx8RJdCu9xVa3LSe8SJa7LxZUSfJkKCajMCu
 NUGcGdFEmRG9ZLGWaFMa1/OcCkx7TwvWL0m+NGDadl0oHi/YOEnW8Qhe+0x75Sj6DelC
 vUOEet2C3R9BJjuqQSzMSOIp3bOsKyP5DA49ZtrT1SF1d00fdYs/stBQvKlSjSMozQ6j
 PX1KdtnvBEZaJzNcmbzNaT0pkMqoM/zdr2K+3AMJEl6xpHPljFjdlUb4x/YakzRxbuMN
 HX8brkUlXNXwMAt84u+lv7nQhRWrB5y4I2BVHR6HqVWLjAT6nEfGVjGO2D8dosTSKQ6u
 Li9Q==
X-Gm-Message-State: AHQUAuaX4z8CvR+UEripBC5mlbZKw/zdjY5eVbtaE2Q6ibgpSuhaofL6
 oFK8j9A7LxzxuB0i7bo8/QaftfuAgkVJ0JNV3g8qWQ==
X-Google-Smtp-Source: AHgI3IbiLPsHirD/XHSvcifyp9fuzaRJC7tOry4+XO6LWiBdKdHShOVnzhCPnbR7x8JCU5VczPmcpChvvl2/djjeObs=
X-Received: by 2002:ac8:300a:: with SMTP id f10mr6571381qte.236.1550222257770; 
 Fri, 15 Feb 2019 01:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
In-Reply-To: <20190215090959.soxkf3ho3or2geme@ninjato>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 15 Feb 2019 17:17:27 +0800
Message-ID: <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
To: Wolfram Sang <wsa@the-dreams.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_011740_754254_643CF5BF 
X-CRM114-Status: GOOD (  11.94  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, Jun Gao <jun.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ok, I can add a check in another patch. Should we return NULL pointer
if msg->len is 0 or print out some warnings? Thanks.

On Fri, Feb 15, 2019 at 5:10 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> > i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
> > 0 and msg->len is also 0, function makes zero-length allocation, which returns
> > a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
> > code to fail. Modify the threshold to > 0 so the function returns NULL pointer.
> >
> > Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
> handled for all callers. Do you want to add a check if msg->len is 0 or
> shall I? Both fine for me.
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
