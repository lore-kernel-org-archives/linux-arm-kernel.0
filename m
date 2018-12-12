Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDA2C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:48:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2942084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmUODSI5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR2xwDDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2942084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kmymprFmAHxyJlUP9ouXh5RQhCfAMmnw457tYDN475I=; b=mmUODSI58KiiAi
	CMB3Ve3llWxqIR4fH42oDxFAN7e3X+YJHYCzBixyUKsDXFwUhC66DmjjTdAvPHbmahrVCxaAvHtb8
	NyH6NRFHV7C3YYvsToZ/Ql4sVe/ja8xkRtYEgiubgSCztWt2wyjGjx8mMHiWU51Ak/Iz4F3uTQo7U
	LkzD2Pxn5tpkmUaxPrWaXZROxChWvsYCcuztLN87YzjL/vizsYxXaVLY7lOEmyjoSu3nay/1MUQmu
	lrV19O3ZINPDtF4xuIJAJfsVRGmjYFoeWS2uzF99QFx/Y/zp7bHHhXVDbuLE/M3QTnoJj9oo2misn
	8HK9P9UsbjHBMn7AcsqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBQy-0005QX-Ls; Wed, 12 Dec 2018 20:48:44 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBQg-0005Hq-BX
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 20:48:27 +0000
Received: by mail-it1-x144.google.com with SMTP id h193so391766ita.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 12:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cEHyyV/TajagJAZqxjoI+Uay0+GuOSTpYkYxugBDjU4=;
 b=qR2xwDDBSKyXknft5XzuX1miVWC6nBKbTiScxaxGs/Fg+PLZbbh8GMKcCaN5RzGqzn
 CoTt7S8EGTncqIxzV+ANLJrq0GIYwoITITXQ5udJ3a7dZFJLawWR+sbLjtKuVvY5hNnE
 LP7TxdktA7A3Xi/Pu26Q6j1l4QuvsvtetYtKxT31wzEkLWfwLPqw+fPhYj6Wv3fnFo7r
 CI/kBtaVpZn0HWc+hgv5nl+0oaJkKTTWKC/x0rZ7wQrwXGOs5RIeJqZSrIpHPZJh0XCU
 LT/rsxCcO/UB4LGb5H0SIUUb3TGiACoyjazNuTtCSeE2cVPE1jhRlDCM2HuPdl3knr6Y
 ovSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cEHyyV/TajagJAZqxjoI+Uay0+GuOSTpYkYxugBDjU4=;
 b=Gr0ygfbMBDa2e2d9h+JtrE6U6O7UHcKx6qJ8cR/mfi7s/rHsGIm3uexJWa9Fq9eADx
 USKl7+91d0OiA/Pno8VaFvQst3l4YU/DNMo220ht3uF/otIA4fiJ4Y2xmyxKVqxRJ5Pi
 lw5Slc5D5LzonY6GSVV/y9sQSX0Q/l1SUfyy/YinBXBwfW4cLBqjA3k9oiQi9zBzpXzb
 FWdkU26XNHI1/6KiiXRwVDwaYxsHqrPUWfpxygw7KEkf9X1uIDCNi0cQkA91bfPQ8xJG
 180giDd51FP6IXGpcnc8kS5O4D+IS9/7kJWttzP6Q8dAx/0QQ5vQFkkllLRKYKBO7gnZ
 /DBw==
X-Gm-Message-State: AA+aEWYOaPy1NnXptQFLUhnrf2LsMsZdD5uzN2hDlh2vOOaWojbV82vD
 2sQrLFOJfqyhe7anGg8Xk+4PY1EjQF13pBn2EWBfjw==
X-Google-Smtp-Source: AFSGD/XPbsozAOlFP6/0Ldul2Ihp2nYCSWHM0gDT1FyU2BSXFw50ilkgdVz/o9O6KLkHm02TTivnt2QCw2ZPF4S96AY=
X-Received: by 2002:a24:89:: with SMTP id 131mr6894588ita.105.1544647694953;
 Wed, 12 Dec 2018 12:48:14 -0800 (PST)
MIME-Version: 1.0
References: <1544529827-22842-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1544529827-22842-1-git-send-email-festevam@gmail.com>
From: Chris Healy <cphealy@gmail.com>
Date: Wed, 12 Dec 2018 12:48:03 -0800
Message-ID: <CAFXsbZqyx2N_mOuJTcLzS7poZZfXLrHCX70d-=M8cn11Jq3dLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-cfu1: Run I2C0 at 400 kHz
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_124826_391720_F2398CFC 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> All the I2C devices connected to the I2C0 bus are capable of
> running at 400kHz, so run it at a higher frequency.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-zii-cfu1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index 7cdcc5f..445c7dc 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -207,7 +207,7 @@
>  };
>
>  &i2c0 {
> -       clock-frequency = <100000>;
> +       clock-frequency = <400000>;
>         pinctrl-names = "default";

Tested-by: Chris Healy <cphealy@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
