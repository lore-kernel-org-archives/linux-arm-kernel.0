Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC361C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:05:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F08321906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eBYXO13Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjHDPvhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F08321906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AWT+y1+I6bSC3a4qtJVvliVtSFQ4D2Io8ult6UAAbgw=; b=eBYXO13ZRVv1RE
	Wa7OsyB0MB+IGruMqKmP2Sab9dYefDYVHm8rYAuXjsPaM3jkerMRBuakltDhXQHEM5seQW7wF9dSB
	ex5d0ZYH2eLlahUsC09jnMl7mSZmYoQ2P3GRiLG4B+zwJM+tdHlVZ/M92CPVJ+A+Tec5iojQHhviy
	TcnbXxl5VZSWD1cq3x6bC4lZCx9HmT5z+YFSRHpxKg9sLzgaZxmFaTV0qEazPeErmzkMQh0fFnOOo
	uNBZXJiOKg+fX+76v34Dd4HCxtm4t4/E2Zra5hS6iqjstONcRaADy92R97h1MZYZisWoaMfrgB2xD
	o9FHLV1Is/fC87a65TnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHgJ-00016B-4d; Fri, 21 Dec 2018 10:05:23 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHgF-0000sr-Fe
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:05:21 +0000
Received: by mail-lj1-x242.google.com with SMTP id v15-v6so4186365ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJlcKOLQnvhKYroKH7E8Qdx1c90yFqhYAEl8+l8TJG8=;
 b=PjHDPvhH6+CQdsNeRty6xKvvO7wl4A8GHtbKqReOHpfpvFp31uDO781qLJEFj1tHsW
 R2OVhA77XssvbWp1l/S5ziw8q/7XVf/OBHGFJvO1OCTFQQil+/3idD8yb5oWxXVUhmWa
 qqbrrmPWXuE+Lhwlr2CAJM+H3JfQx3hLO6BUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJlcKOLQnvhKYroKH7E8Qdx1c90yFqhYAEl8+l8TJG8=;
 b=hraGweNh7wfsKV9/zslZB1qScLL3NVxSWh3g7o3qmMfeGTmLs3VVFywuLzqJzRt68X
 nrKMZe+7w/ddq2jNU/9/qyOC9PjVWQkxRXjmQ1BwCZnAXw+c7GEXsYHr6nhcglLX+Mss
 SMhjtnx0XSaxEeB1t+by1AiONHZeOFo2PBsdOqUWuAidcLEM5FBv8mtpt3OwMPtS2+J0
 yvN71lxX0GdimTjN++PZ7gGt0y6gTNX2Ib6PbbmExjtcTRaajKVAOHHyWiXli3brfVZI
 lyhvukftVa7rEh4oHJKlQ5AaNxdOFm0EFnB8gczVUDpOy9qXB3FlaTFhA2fQdGdJ9ERi
 k0mQ==
X-Gm-Message-State: AA+aEWZU5kQ4zmuDQ6oF02aYeqQkhgK553kymGslf9JiIGuD5nirJ9IR
 ULo7StPkEH0B4PCb9DjII0HLkC8fTCd+qBuzbAsFPBcbPog=
X-Google-Smtp-Source: ALg8bN79V+vNUKy2PmEA+WIef4xhyXVM4awzJ9AXOMzZjHjowDozD3/dJVP5wKpqXXOMzHGDOojS/UuSjnSfZ26l6Ko=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr1155040ljg.23.1545386707008; 
 Fri, 21 Dec 2018 02:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20181217131626.17098-1-maxime.ripard@bootlin.com>
In-Reply-To: <20181217131626.17098-1-maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:04:55 +0100
Message-ID: <CACRpkdavvJKhcOGPTRW1DQabFaLh9r9WxC1vd60r96Jcww1Pfg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: sunxi: Add supply properties
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_020519_530653_EB4B5F1A 
X-CRM114-Status: UNSURE (   9.48  )
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
 Chen-Yu Tsai <wens@csie.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 2:16 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> The pinctrl node can have multiple regulators for each of its GPIO banks.
> Add the property descriptions.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Patch applied as uncontroversial. Voltage regulators are just
standard bindings.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
