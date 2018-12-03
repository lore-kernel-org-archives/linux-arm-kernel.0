Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DA620848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gFmLV8Nv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUwsC78H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DA620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iUka50Y9B75B5jlLNJF5PybqQ+2M6dxJR9jHnxUV040=; b=gFmLV8NvaikhW0
	SrW8YknubmWtJ4CoEbCd/1u/Q/Vij7m3lww6w7+R3AxNfCA7Av7kf3QdcntPNjJpiPxisWMX2zjsj
	oPzIYwu1312Jxjfq3IDduvuWfopdJ5P0dXRnc6XPFLAuIMAFcy3EjXtmAMFwc8hT765dqHo8Yq1zv
	k657+HNj8SQeM3ZMCZp8hai0NJkBb4MtlmMssmhY7k8VOSGXwbWAb/gj2TCPSam1R+kjd5Y2NEYKz
	z09Jzp/kWVCzOOX9OGKA9H0XPSVVjz3be37UPbBDZiCD+rbnwBFpezjiv3GsytOlIeLhGA24B0BgT
	c5i6wOZ/oDTJ6zvTt7iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv0k-0003tv-0Y; Mon, 03 Dec 2018 20:40:10 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv0g-0002aH-Jx
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:40:08 +0000
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so12730374ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hrbyS7PKY+d19AR77Sghwng4VFgFultDt6XlthnetDI=;
 b=hUwsC78HeKMHlGRoITBWKJpfyFPd3HdaGZAcLpG2AaWT6GNTYky2QPvBfv7V44fpnK
 7ibUsh9ckJ7Uzcv+BHLoh2S4HLyP5iEkHyNfh2c0jJ/si4a/uhHL/rVelKSA1eZKKChF
 17YC9t9J65QV3d7f33PwQ8L9mfF5ahIjGVP5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hrbyS7PKY+d19AR77Sghwng4VFgFultDt6XlthnetDI=;
 b=QFGS/TA92CpxrpFTb0yJlD68MI3v6T3vZpNeZJBy6aTvvmn8dyCT+PsZoBlaB7Q01D
 k9kbsRFNmhQker1Xwd4jLRLEsz90WkSJemk9urhRXAJOcUccfNQezY3SiGvx6OU9rVYd
 dr5xU3eMF1obJzBydaPRVdB4yWUNuIwrr7pxFtHVNyRUdMW0+371Ywk9G2eCoTAKctgn
 ZJDIfwtRFpHfN3drCgYiSpjru3JQrseYhWdZufT1kOcCCde+1QA/FLBcRN3hfY8NZZM1
 +PnPzH0V91YnIR+ZEFtUcSiAS8aSjwEcXdKTo6S/fHp3MT3J5h38sQBFXAmFpCgzVw1Y
 Selg==
X-Gm-Message-State: AA+aEWZRe8AmoCB9qtL/U+a4FiXkRCFLsuD3e59pg+C6EWtnGpxY+IZi
 hEuTOSJMSwzTRGo8+7yKmHTWrRGHZUst2lcnO29n4G+z+xk=
X-Google-Smtp-Source: AFSGD/UHI3rQT30XncDGfM+cjahHlpRe88wpwegkd+fkOSWO1aSt1N8ApmUZrrytGSod1ko5lCFYWxjqzgZujWQXERI=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr11114150ljk.4.1543869593858; 
 Mon, 03 Dec 2018 12:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20181203191248.13067-1-robh@kernel.org>
In-Reply-To: <20181203191248.13067-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Dec 2018 21:39:40 +0100
Message-ID: <CACRpkdZMf+HRu7T4ggzfjV-XktyQpQoKkrEDCmNjz0gxsk8JxQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: realview: Fix some more duplicate regulator
 nodes
To: Rob Herring <robh@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124006_659564_AAAA5A0D 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 8:12 PM Rob Herring <robh@kernel.org> wrote:

> There's a bug in dtc in checking for duplicate node names when there's
> another section (e.g. "/ { };"). In this case, skeleton.dtsi provides
> another section. Upon removal of skeleton.dtsi, the dtb fails to build
> due to a duplicate node 'fixedregulator@0'. As both nodes were pretty
> much the same 3.3V fixed regulator, it hasn't really mattered. Fix this
> by renaming the nodes to something unique. In the process, drop the
> unit-address which shouldn't be present wtihout reg property.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Arm SoC folks: are you applying it directly like with the last
one?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
