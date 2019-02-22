Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:04:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF11320823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KuYAl4DY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFdpBV9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF11320823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KSVuLPuxeQt6MoQVcTa+xJsBNmcRcpI6Dk0N7zhGbMU=; b=KuYAl4DYafs/l+
	KZpHV+logvxZ5JxnLxGh9eph2/1+s7HQJknH9Bbx+Iv7VVb3QvOr8wVJ7uTWeHUNJmPJE7ls9barr
	bHFGRyt3eDt17mL9hTajbGY0vWXGp84JOJATugFuCc+xAbsRZnW2Eml5YVYgaNfMGdnOC2cHJEFUc
	jgATFt9JitoT+NDf1T+lo/AAgRGybKRejVphuZcjuiaZQ9fEN1/y+Ap1dm9NucbLPzpThQqHvj4xl
	PdwEK8iX9BuC6+p66u6ufu7+06Bq3cUP1vLZ8LKOGip3YMrqP5WMKd9wuciyAtzQ99h//ujlwHTpz
	R90ubpdFJVUVWUZCqgeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx3wg-0003e3-Ns; Fri, 22 Feb 2019 06:04:26 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx3we-0003dH-2A
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 06:04:25 +0000
Received: by mail-qt1-x843.google.com with SMTP id p48so1352973qtk.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0vcj5TQMcSsyJZJCbz5AUMj6MPBG4OxfRpvXpAZkqqc=;
 b=gFdpBV9C4Mbd2JvBgbU8Y2aakbjO0gu8esadO4ez8gXH7Y5Sy1O1H0ZhpcDK7krSz1
 agGsV1YuujI3QZEQ/6wUsS4kTPCTmfnSql7iSx41yuBdqUrQr5xCehSIqIkeA/PFYL62
 XnGs+zE+vQ/FdiZUVmTNfA3mFkveehiGUMXCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0vcj5TQMcSsyJZJCbz5AUMj6MPBG4OxfRpvXpAZkqqc=;
 b=qXsLvohBr3flUQAijUW5iXIB7ouAXRPFin3038iRwkb7vFUHkBigb81LnlLRPTs3vi
 IQfQ/5D9Vu4TcK6ALp20L9Y8VA2SLiIywTvsxu7jzPhYlfhdKJIoOdwTOo0cEPDMDSS0
 xRjvRxtsO8IpGpytKYp3bP9FNUSziwbDDO8GnU/71jNLddDJr7GWhAL6hCiR1Le2eaZD
 VjUfOWqlqUi8SRwQIxv65+UeykPY58R2SbosIK4mBHwezIgZB3ZkmHTBrrBXCfNqNnwJ
 nfPp+Vj9eUdk5I4djHz1p958v7ozxKI6YBwpkFWIWhgJrbksMmDINeK9CiPWU5K2LV/m
 ExwQ==
X-Gm-Message-State: AHQUAuYNEvrfODkryaZ3Gj7zbHcmrWsUb/3ZlPZD7bgekJa4a1w5iMEY
 JEmE184LIdYq1dr4OIBW1mTWKZOGpzvn3cVirO+iBw==
X-Google-Smtp-Source: AHgI3Iap6n9LK8B6/S8114PPRxStcC3fgbTuMGffb9kFKBSwbga6oCEbs6VF/0jkNvBwfmKJGV3lunzNookHZBtSlaI=
X-Received: by 2002:ac8:2922:: with SMTP id y31mr1756160qty.187.1550815462230; 
 Thu, 21 Feb 2019 22:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato>
 <20190215163657.fs6t7p3vqez53su3@ninjato>
In-Reply-To: <20190215163657.fs6t7p3vqez53su3@ninjato>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 22 Feb 2019 14:04:11 +0800
Message-ID: <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
To: Wolfram Sang <wsa@the-dreams.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_220424_135609_4A999550 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Ryder Lee <ryder.lee@mediatek.com>, qii.wang@mediatek.com,
 Jun Gao <jun.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks for the solution.
Previously we were testing if the driver can handle zero-length
transfer, but it turns out it will timeout. (Also checked this from
mtk's datasheet)
Adding original owner qii.wang to verify that. We'll apply this after
verification.

On Sat, Feb 16, 2019 at 12:36 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> >> > Ok, I can add a check in another patch. Should we return NULL pointer
> >> > if msg->len is 0 or print out some warnings? Thanks.
> >>
> >> No warning, msg->len == 0 is a valid setting. But interesting question:
> >> I was about to say NULL, but your driver would assume ENOMEM there and
> >> discard the message which is also not correct since msg->len == 0 is a
> >> valid setting. So, should we just return msg->buf then? Will this work
> >> with your driver? Can it handle zero-length transfers?
> >
> > dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> > kernel if msgs->len is 0, so I think it doesn't handle zero-length transfer.
>
> Please don't drop the lists.
>
> Then, the correct solution is to forbid those transfer with this
> controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
> like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
