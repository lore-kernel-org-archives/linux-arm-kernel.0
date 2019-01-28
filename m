Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D1C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:02:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0029B20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucY2K+a6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEmP3Lej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0029B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lYiIi5BTAtER30YgZQtUT1tYVI+TDuQpcwvE426fExY=; b=ucY2K+a66qIZMm
	jwqt9NzYuhAKeRGMDVaZWU0CZ/mrm72Z8UEuKLpA5C9sTl6NyK60ZESvlUK0i219bwSoA7u6gLdnL
	fykHCBCP6Nasr26t48Gc7E3G++pBFBjoYUD5RDUgaWdbb7H5NsVrRztfghm2254MNKCu6vpyRchJO
	C4lZNGmTTyQew4o2iY4iroIDVmpETtbIkn2g8KjHhSayij/QttkyW2PsAs4LCsqkiBa0M2QScOQO2
	n877muiy/tTtdkn+rL6fb+92BuzYdMGeZavajQY3tLqJSrOES66y+Y02dOytvltwa6ojS/O2VTyz4
	IjSWyq+DZPBMvamQunZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go1sM-0008HJ-4H; Mon, 28 Jan 2019 08:02:38 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go1sI-0008Gm-HV
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:02:35 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so13358026lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bPJfvzHeViWjZ6IlN45QJhbkieZEUXysyLjfWUB5tp0=;
 b=fEmP3LejkJeme73fQ/ZXmnFHL0IDxcI8mvyNDkE36gf0LyL/7NRxV4nw1rEO3vcBxV
 tTK8L+Eyv/6Z1qrcCarUzZO2WuDtysov36xzmevZzePkWRxOnvcolngLTylIeEz3p3Yb
 rZdNBfUtpjokfChIxNKApUih3ebHC13A9KrdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bPJfvzHeViWjZ6IlN45QJhbkieZEUXysyLjfWUB5tp0=;
 b=oiXbpEyTRyev0eDQQsCT5KaXRX6WCl/HSEMA0uTplpNH39fe3OUNFLOHNnFrOJQmdX
 S/N5X6me+i72+kwUOPZ0rMPIn3ojmyz5J4PqAlD4DoEzXPSPzd6yhYYfo2wvIFxl6WJY
 psZcX7zLZFMUxini7gdl+G48qAz26eeeRWSiRaWdizpAMoCm9v+TLfAHdLgTpjJc12A/
 +NCbZ+EcD6BH66Zhi01+KJg05iRmj5wcQfDKSU9ukctQ+wHZPH/hH9ZNEPjEblztWUIh
 HLdEnWo8BYpQwSFjkgSMWuDNDcFqqZ9ZlD0cdIX+Y2uLA3LyFR1GucY3aCzbn+nhlbuy
 zL8g==
X-Gm-Message-State: AJcUukcNQSVT+/RNkmbOEIYkbE8/XI/e9NnTTp3vF+IP0PDCNcY2eGnG
 9bJfmXd0w1MkFQwc1v17mxt5D+8lPDD3p5S47A72Jw==
X-Google-Smtp-Source: ALg8bN7DpCH1TrStr4KWWnVP+DD6Fmvhed+iA4fwEdRx7DxzZyBnddFCTw96fClEzze0BvYL8s60qZaT5BqwVgtP8KY=
X-Received: by 2002:a2e:9356:: with SMTP id
 m22-v6mr16122873ljh.135.1548662551675; 
 Mon, 28 Jan 2019 00:02:31 -0800 (PST)
MIME-Version: 1.0
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
 <1548054685-3781-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1548054685-3781-2-git-send-email-stefan.wahren@i2se.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Jan 2019 09:02:19 +0100
Message-ID: <CACRpkdb82d0roqCW+NV_PbchamtoJV_gr3ODRzjwac7Rwi=kZQ@mail.gmail.com>
Subject: Re: [PATCH RFC V2 1/4] pinctrl: bcm2835: declare pin config as generic
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_000234_577185_9E438BC9 
X-CRM114-Status: UNSURE (   9.08  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 8:12 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Since commit 0de704955ee44 ("pinctrl: bcm2835: Add support for
> generic pinctrl binding") this driver is capable to use the generic
> interface. So declare this accordingly.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
