Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677CC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:50:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072A72086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qUycAJjM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z38D6aXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072A72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q0r+TtDoK7SFFM8lPEMmtFU5UC0EHf7Y0w0Um1jg2YM=; b=qUycAJjM5wGp23
	ZEiLoatSvK54n6hxsT8ddDCSS7YJYvDLBa9QPHjXIfD12r3sn1roCInUaMTSFF8thGzS7mD6KJmyL
	aTFrJWvZNP7L/FR4XR/lxN/pT3L9+Y1bIk+DuZXVEDrW3GKtQ+f61hOiYJNys+iHpOqD5hZuKIzbx
	ybpD6U0y0VOrTm/8nlRWjJ31N2wSpiOZrQBFLP+mynpLslZ1IQUUS4Mt6yk3OETlxxPMBTLdDvq/V
	WuCiUvZoEEm6V1a/J9Rz9mRK7hs27PfQMsMcaFSx9pbCVokvSJuZhgFRZATDBHLYx8XhvrbGA3SC1
	mpU5AGWI/PEx3H17eDzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUBZ-0003eq-RV; Thu, 13 Dec 2018 16:50:05 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUBT-00034f-QB
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:50:03 +0000
Received: by mail-pf1-x444.google.com with SMTP id g62so1365725pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=9e9x3U0MfZ0tl9wJMH+qJPfAjABgmKqgJejMG0aExLM=;
 b=Z38D6aXCXZqSqTjQ6UDZH33YzFzNUpW3L6mbctIZjPfl5aVGIZcwauLPEqiRgOigk2
 LbL8O5nD+nwBtTiqfaL6LkIay18sYrQSpJe9V1uMbXfjLIsNdZXJGGnzmufpkksyx+mz
 q6e4LePlHav9T+/BRrR+PRq9br8t3aw+ZSfduFXSdQCT54ypb6XmJbEZeqcCiUYd9Let
 UVd79P2A0qKg7kuAPQY+WsEDqh/npD4EsYKXqQdOzvqEM34R72xQEE1NfF14OMAqmNm7
 Zed74nUIJVN0v/JjP59yUxC87WeemHVQacFyM6XrkaAlYzoC9oELEHBJ1s1Le0B3e8HE
 nTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=9e9x3U0MfZ0tl9wJMH+qJPfAjABgmKqgJejMG0aExLM=;
 b=T4N/WTXUOgLzF4R6TEkKTdShn3Lwt4BGw00Xp7df+FM9JML4Jg+5jPkZo8quhAo40S
 kX2/z2iiAoKu+g/TqZ7aRyR1UDqn4vbTzrs2nVxSOaICSZhMzpYnpj6BUeRc5uAu9jAC
 Ofeyb7X8EoHzhI+SBUlb/2W+pK7y+Q8F/0vJz7UvBaMr2WSo3hykM15omCz3DZrvtgkI
 AzTNASgubfSnCZUrBU+zS5yTcsbFr5bvpGjdXaHFUqn3OSeQipwJfvmsSpc/zJaVCJv/
 kkM4m2tTGquxpHxZMED9ZnrJEGxun6usolfX9+NL7OSzVSGCuu4dPC75vwUdOdLPlJul
 lNdQ==
X-Gm-Message-State: AA+aEWaF0sWVRe9UdT6gMTNeLy9UBFQM2UbobtBJ+Z265oNTXjWcoh9/
 9JU+BaSvSXAbh2kZNPK92jf20g==
X-Google-Smtp-Source: AFSGD/WbhPkEbmFXr2PL6usEvAwDCzLLR/JiGFl52dFwwQFM3DU1zYLGy/CDkSsdC5eb9c6TsdA2vw==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr24436724pfl.120.1544719788504; 
 Thu, 13 Dec 2018 08:49:48 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id 85sm3359463pfw.17.2018.12.13.08.49.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 08:49:47 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
In-Reply-To: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
Date: Thu, 13 Dec 2018 08:49:46 -0800
Message-ID: <7hlg4ts76d.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_084959_844923_8AD89A51 
X-CRM114-Status: UNSURE (   7.55  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Remove prompts to make all pinctrl cores to non-visible symbols and
> make sure the target SoCs would be coupled with the corresponding
> cores.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested on the mt7623-rfb1 board which has been failing in kernelCI, and
this patch gets things booting again.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
