Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF4B208C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dlAOCLMm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKORvEI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF4B208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AP/zObwDpQgZXaoln9e+ydWSUK9lFLjQqbNk2VtKOqw=; b=dlAOCLMmXatz51
	34Y60JqKXeckfiOLSO6LZcqoHgtiJI2C/jFmzFzOVtIo/4ih+JEj7f/W9m3zfBzvlbUtBMcP4pZUS
	4EWD5EfDtRg20dPI/wsxjORP5ZJ3WSo4YBICcOOqNXdaVv8xYFVD+2+n5IaovMZSLVZVARc1+kvS8
	+X34/2cAIzffo2+uuUKiutlhKdHP0zg6L6HYZeEAdT4pk6J/JUPk6nLcdweZoNZBc9yNARG41Dtc6
	MphnX1luluvz8Jcvg1a9je6rghBnSyeV5er4HZsaaNIkBj5wfnxx7fnzNp9Wl+cvPGCgQT3xodk+s
	P8WziI7HiQiH7hu+/xxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvTJ-0004dj-Bn; Fri, 14 Dec 2018 21:58:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvTG-0004Tf-91; Fri, 14 Dec 2018 21:58:11 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21183208C1;
 Fri, 14 Dec 2018 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544824680;
 bh=1yovWMreuXoUM+2b/iAO/D3FxA/cPQppWWV2o3g4cbs=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=XKORvEI5AlOTfIBKXUfAZGXBHqLuWcH0T1pp4UQGBTfNkSKgoqsWhLIvSIUGpO8Bc
 mRCYqs5iFHW62LigjHuz79e2AdVS7y2G2UjvhE+sWN5XX+xAweZnhOK9jAUVlLt8Hf
 UZuksrExUu3qAkRZaqrOzuPLXlMyWth4l5YUmXQ8=
MIME-Version: 1.0
In-Reply-To: <20181210073240.32278-7-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 05/12] dt-bindings: ARM: Mediatek: Document bindings
 for MT8183
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
 <20181210073240.32278-7-weiyi.lu@mediatek.com>
Message-ID: <154482467901.19322.4603837071733892594@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 13:57:59 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_135810_390655_8C5BCAFA 
X-CRM114-Status: UNSURE (   6.92  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2018-12-09 23:32:33)
> This patch adds the binding documentation for apmixedsys, audiosys,
> camsys, imgsys, infracfg, mcucfg, mfgcfg, mmsys, topckgen, vdecsys,
> vencsys and ipu for Mediatek MT8183.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
