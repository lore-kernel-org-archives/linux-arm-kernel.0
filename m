Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD694C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:25:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7DB20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SMVtx1IJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsvY9CXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7DB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZ4Q6pHA2xJTIh1h5FHeo3ojirf3qIyDJKpJUM8quUw=; b=SMVtx1IJ6t+NkQ
	TIl0/X26ySeixfzSs23EKmM6s+TkrxYBS8Z3WsKie3chYLuBBHddyRs8i7xVfTE/LTO0brLK8Tg/5
	EQ3VIUuKsk+f6dPUnfTj8uvQ9R3spPFxzYRAGztXeyMbdTYQM2uaZ1eSKWTQ2CEavTosQKVQd0iEl
	9F6J17ZZ7w1yeKwp8FSADkBAHuDKM0z5BNX1ToMoKILfcAVtOY4CGAVKRD9WLl+nRcvZSYUPzzuPc
	wT1VFUetQb2yUT/N6IyTp4I8Ze3eh6UY0MBWtvJ0DoKjr0hx29XtOKJtcetiJZFAXP7VG9qQbnXyR
	JOsoCx3YdfJj+a6KQUYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghxkz-0006FW-Gi; Fri, 11 Jan 2019 14:25:57 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghxku-0006EC-MW
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 14:25:55 +0000
Received: by mail-lf1-x142.google.com with SMTP id u18so10895433lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 06:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eMezhPlibajiGAUTYo08rPGVJy9LI+52kVipFELMAgQ=;
 b=CsvY9CXuHvuP2vTpRQyKuR/UFoKr2gc+Zd1n5HWeW3jeQeJrAzB8eBNZmGtnEZ6RdB
 vp8jZlgGDUgSR1AjbcHxNt00u5/mn/ScwOaE3oM2AZPDZJnNDU0+VSxfpEH1JEA9Rfk+
 LDNQzmeGNrE1fq1QcUooxTZdilxSiv5vEXc98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eMezhPlibajiGAUTYo08rPGVJy9LI+52kVipFELMAgQ=;
 b=klnL8+tf6ca3ZoH+wZsAfQfxohQLqY4Ht1mVUQGYxXCZNrDHcaJZqTIEinKIktKcxY
 aWmDtDJMO/hrPApuWuUB7gjKKO9n+39EO93ApiTCyauRALDfcsUY7Xn48lrsvBuZT0mP
 bmVVs14faHH5E2gijGESibhkr7pp9kriizqrvVMjGE3ckQ4oHhGjsqg4mhoW0pt46U6I
 FeEDl342tzgD61b+GELbMO8qY0LnfQmlhOFsuDJaO7fLvpEojmaXPm9xt+DAS6Pnyc/e
 Piwd4pqjqUAJbtuLLYlOsjhm37PII/RqVA5o036LNxE1qcaBv2+0DaQAbKx5Loqv39x4
 hY5A==
X-Gm-Message-State: AJcUukd6v0AaWHkkuAc7nsEjJPElbMmikKiiTi6e9C1+tzckIx+Kd+Fg
 rjBZcwSgVXhCxokSvueimRhGqFuSIUvv87Z/B0oXUA==
X-Google-Smtp-Source: ALg8bN6aiLFd5CFB+xSIBHKWd6SdJTQ+kll9fKsdXbyRMUwy4ow0dOqzUTcdToXSWNu3qzVWZgxi9O6aBOv+ycsVxok=
X-Received: by 2002:a19:f813:: with SMTP id a19mr7889089lff.67.1547216749948; 
 Fri, 11 Jan 2019 06:25:49 -0800 (PST)
MIME-Version: 1.0
References: <64a23e6f8751ee6f1387a611a9d5dba43694b0d0.1546999151.git.ryder.lee@mediatek.com>
In-Reply-To: <64a23e6f8751ee6f1387a611a9d5dba43694b0d0.1546999151.git.ryder.lee@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 15:25:38 +0100
Message-ID: <CACRpkdaJ29di4GxcHNa+pUtV62aF+8SRKTzYMAJHd-8j0oiX=Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix build errors for moore core when
 CONFIG_OF is not enabled
To: Ryder Lee <ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_062552_785735_EF454FF7 
X-CRM114-Status: UNSURE (   7.80  )
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
Cc: Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 9, 2019 at 3:14 AM Ryder Lee <ryder.lee@mediatek.com> wrote:

> on i386 or x86_64:
>
> Lots of build errors for drivers/pinctrl/mediatek/pinctrl-moore.c when
> CONFIG_OF is not enabled (but COMPILE_TEST is).

Patch applied with Seans ACK and trimming down the subject
and commit message a bit :)

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
