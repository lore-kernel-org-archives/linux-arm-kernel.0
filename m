Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19991C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:06:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA92921736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="apLfihvI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdFpNrIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA92921736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ln3bJTfSCY1HTAcX2quh3RB9WLED0r6lrah29F/mr5Y=; b=apLfihvICI8zoK
	bz5GIoxGd2kUEtjniXWV5hTJN2u38bFrx5SEjr+Iyx9bI7K5YOZyyBI8Qe9jF/GGmEuhuUVajDt6B
	TDhOGg6S2q5tv8UNner0w8Qi0cf/aCVzeFc0HYoWFkfVKdjqXo5lA0KUcZuNq7utiMgRUIWh6PWip
	vB5vnkwI7o8nXp8ZgSbKpIH9f6j26kIjWH8X8LtzAh4sXzo8mtecCsSZU720GG7x1yeM8t24ilFEh
	ylfDXm6MpbrN5PKQMyech0UTeZBdmRjAGOVn3agxEzEJMq8XEshLjxqvPERAGOOQfpJjkp/CHiXdZ
	QMiHes44G0gDU2Fbg8SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go1w8-0001fi-KO; Mon, 28 Jan 2019 08:06:32 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go1w5-0001fL-Bx
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:06:30 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so13362410lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zRwbBGCLsDNOYKT8YI8ize1MmoIPnjQQWTtr7C3YSL8=;
 b=KdFpNrIxD4gwJY9Z12XQkplkSp2xxkdn8murGpSWrhEW+AS9zS/p1NooTdPaY0C6Uu
 /sSl0mtUl54vE5PGdscuZdbQjHQZFZy/dbEtEkmcfjUAHpA8+JMFhbM2SOmD4ap2sYpX
 sgkre+PGHqSvhgApCiz7llOwrU/XfpQyKiauM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zRwbBGCLsDNOYKT8YI8ize1MmoIPnjQQWTtr7C3YSL8=;
 b=JP6XFefErbURBAGQOtS5j3buAgERcuyBAMDkToM//YJI6pZTi1ieo0XDU1Gwky5Z0V
 hJlMedHqz7B/Ksu5NgwWZqFLTXAQRV3dR+lZgw+69arKc2K1duaWf7oeiFy2s5UJ3Zqa
 lcAuUFcUr5m4XIv6I0sS3E73z6TmzdOunv/PuB4nTxhcsV/yaws5weLP5bEFxajK1dMx
 zvFnTCwOABWfZ8TCG+R+gDTxWgIRGc9wL0UUQgHiia16FsIfU86TRtptr3MRvNjR64Nb
 BcdyhkfVWHD1kV80Wji4yHBaPLoSv0bS4o5x1kppluQLOHu7ZDk8nY0HHLy405UiXQ3J
 J0kg==
X-Gm-Message-State: AJcUukc++psGft60MAbUcjQYWVV0lXUAYxI7IFkwniE2Uz4fOj9H0lM1
 7BzYX1BAD46Nb4D213JtvnlQdd4AlSaTFdn0J1MRzw==
X-Google-Smtp-Source: ALg8bN6cOjFf0o6kKS8JTNENg1YccqIqq3FPtaXaj094ooE8z8lwwrIDnlRWmt73cQA3dlxNzUZmpD2Mq6D7oQgseUc=
X-Received: by 2002:a2e:6503:: with SMTP id
 z3-v6mr16349684ljb.153.1548662787340; 
 Mon, 28 Jan 2019 00:06:27 -0800 (PST)
MIME-Version: 1.0
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Jan 2019 09:06:15 +0100
Message-ID: <CACRpkdb1fUYz+a9QrO_jEcKgMNJO3ApZAVDR0gqz_Hd=WVQ35g@mail.gmail.com>
Subject: Re: [PATCH RFC V2 0/4] pinctrl: bcm2835: improve libgpiod output
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_000629_409568_266BD6A1 
X-CRM114-Status: UNSURE (   9.42  )
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

On Mon, Jan 21, 2019 at 8:11 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Based on a recent discussion [1],[2] about the unexpected output of gpioinfo
> this patch series tries to improve the situation. Patches 1-3 are specific
> changes for bcm2835 while the last one is the intended improvement for gpiolib.
>
> Changes in V2:
> - take strict mode into account as suggested by Linus
> - add bcm2835 specific changes

Ooops started to apply this but now I noticed it's in RFC state so I
backed them out and wait for a non-RFC version first.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
