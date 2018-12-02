Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FD520834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ad1jBzeQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeGQNPU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FD520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6UbK1TECz/VlYOiFYnNcPA/cu9DqHQuh87RkuCr+uUw=; b=ad1jBzeQVSL77d
	om3qXqwF23q3Hekerr4X72bg7r3h+Ii5guaKGLv+hVP71MIgq1EC7mrdoTD6mwlKE+Ehl43ecyvAZ
	9zKuMqdzAQzjTy3GPC2pXgX+dgZukXoUjO9B6eh5Es3MCqgvWy5mC16Ng6Idu3XnAGJm3Og9Ryqj/
	+3H6NzBOc7EPgdvWIizXH0iulH8NmMlqzubdF/7/llCUFYuhm2ymP1OYEeO1Oh7ZObWq2Yb5Zyo3X
	NJosrEAIZOPhoRlU6iALjznpIoUd38fvtjw5RQLZBSd4/az8WtNqUdAeIV4pjJfgh3N7LjOmSAxd6
	aQei5EX7VVIpah9T0ong==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYZN-0004bR-Dx; Sun, 02 Dec 2018 20:42:25 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYZH-0004aM-Hz
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:42:23 +0000
Received: by mail-oi1-x232.google.com with SMTP id t204so9146009oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Na5qYWXnCjApn//KrRMD9lbTN/BG2FFx/iWIF5sDpfo=;
 b=KeGQNPU6ckITwt9y331TWw4o266zXYkBca7ROpBzXUkxHixkj1PDARcE4n0UjeQPUa
 HewrDQuvHKyZemJb5gDOtOPUa+9ZP79itGB1um3oPzeoS0XDbPDkKWK/JmA7LzSBCSCG
 ZQ+aquqRToJjcmpNDIasQ2xdeFK7lly2h5db81XHVrOQxyEZ4WraJFdKQVZ8AXf8NYJj
 n6M+Ut7wPk6OZ8bcrDQNuZVp+JmMZsEVfJCTc+lwmuNaPnV15jtepCYBs1WLBGS4Db8I
 CNaoRacEoy5g4p9ADP0Va0qQt9ZRY87favJfT//TA9Totk8ycItzi+/MN51LFETcWXgJ
 na7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Na5qYWXnCjApn//KrRMD9lbTN/BG2FFx/iWIF5sDpfo=;
 b=tbQ6Gxq3+WdRGfU9q4sv3/1L8IBojzjaPd/Yv/yyOMQNBHPU1jPHVvqZ9V9Bz51Aip
 GzIMnRas0SVMrcXYJW0nnH+m+SZ9yNz9p7N1Tt8GVh7fIUr8dd2q25z7JrnOuV2v9CDI
 2qDbUmQ0uNY6vR2KJ4HjbfuF9gmxrQqSJEVldA23REm42u0omhZJS7osVYC/PhFEHQEB
 XMoKL/vJCfNy43KcvlSzL2X+DXhtwljoLuvpIY8XOpci1sPy9z16/zlvCQGw5UhVuct+
 43CSa0WyZ8yb1b6iyZLJu3TbqyzlsGxzpggM5OHlLWn+sdEWILJsWVNnGvbct8aLWKh9
 hbZQ==
X-Gm-Message-State: AA+aEWavTzSgk36DBC9q1iWl9lnN84RmoFXi0xbB9TQaWLAZ8FXa8pY8
 lzFwtwWEXXfIzWLH/0dVwbL640uugI+8wvnYsKleBvMq
X-Google-Smtp-Source: AFSGD/WS5yJqcUUbxUHzxbuHZ7mfUp04datmZ88XY99WBp5myudnkVpzwnL5P5Ogh+YJuQVt1syzpF7KAfHGOs43Ccw=
X-Received: by 2002:aca:d056:: with SMTP id h83mr8752138oig.67.1543783328014; 
 Sun, 02 Dec 2018 12:42:08 -0800 (PST)
MIME-Version: 1.0
References: <1543542470-4813-1-git-send-email-festevam@gmail.com>
 <CAAMH-ysdpxBpGLpqNo9vhoMtkvtJsu440dRw2HvGfvwYW=36Rg@mail.gmail.com>
In-Reply-To: <CAAMH-ysdpxBpGLpqNo9vhoMtkvtJsu440dRw2HvGfvwYW=36Rg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 2 Dec 2018 18:42:08 -0200
Message-ID: <CAOMZO5DEboD6myFuMUCRgFLsgdFAz+9SwK874SsqbmwcQnQaFg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-nitrogen7: Fix the description of the
 Wifi clock
To: Gary Bisson <gary.bisson@boundarydevices.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_124222_101119_8442583F 
X-CRM114-Status: GOOD (  11.00  )
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
Cc: Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Gary,

On Sun, Dec 2, 2018 at 5:09 PM Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> Actually the whole regulator should be changed into a pwrseq as it is
> really a WL_EN signal.

Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt only lists
a 'reset-gpios' entry, so it seems this should stays as regulator.

> > +
> > +       usdhc2_pwrseq: usdhc2_pwrseq {
> > +               compatible = "mmc-pwrseq-simple";
> > +               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> > +               clock-names = "slow";
>
> Shouldn't the name be "ext_clock"?

Yes, you are correct.

If you agree that we should keep the regulator as is, then I can send a v2.

Thanks

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
