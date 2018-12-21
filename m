Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D226BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:25:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1A03218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RpD8TvvJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVpRf+bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A03218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2PFXFdRAYphrTFr6RzG96Vfqgic2/TlXlLHthW1Xa7Y=; b=RpD8TvvJ8IOb8e
	aY6clRsEijogknXNQZOFadqLvXTrKwoqZVAcrnCJKV135/MsZlx85I+WbO5y4SNkLWWqhUQdhqwr0
	jw/i3bHp2L6JUvwsU+rgGna/gnixiekemet8CiwVCY6mw2booEL9PGsY8zQ/hJ17NwltEsRuxMuzz
	wxkM47+dzSZfJOwKyF1evbK6BvKc9k76QWBlM96pGfk26tX8yF8VIKK2yrOkwQXua4A6hpZp7IgPH
	5+WDYjLEop4Wvcr/E1Wl0fqKwJlC3CFenqXDg88qeGDStnaxcjJAiXZlFqN1vWH/zkiJlF0A4z7OY
	1UeX0zLKTwrzWe2rlLDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaI05-0000ma-6f; Fri, 21 Dec 2018 10:25:49 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaI01-0000lY-NA
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:25:46 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so4241848ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d54mjpoCvwfoRK+Zm68khJVKSLkPNDF4ThJJGQnnyRA=;
 b=OVpRf+bVWkqOX2SKf2q9Cu5igcfaXKdkliYxa8C9oqBbKvumPuWoPTZK2ZJNYxSgPf
 npImjYjOaMlY5Hd/XmtP5yhRsXmDd8rdMcjsInH3YeFdARY5RpH52PhBtepDx3WB1Mf8
 UX3mRvtPVa8fWnqeAsbaCs4xXrSFyibvygICs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d54mjpoCvwfoRK+Zm68khJVKSLkPNDF4ThJJGQnnyRA=;
 b=a3jNKiIFXhYC4TUMxihV4DPcDode9VfTy7mR4vdd2U9XecrpQ6mMYPmaCEg2acpx2K
 T2wdUMlHD8f98ZIsPc6P0jU5pCIsgXgGqfajLLU/Uu4wiBUIWpl2JKkKNg6EIkE2enLj
 dBDfl0VZivywCz2YKcCuIyZI/7Iidints/TzArtjbcRoil1wpewWl3wHQ0exST9TKL8x
 ZNbWboXRLfQ6PPqXS7TDNa5b3jd1g+4G+JcbykhRN77rAnKjea3oybR/gcxB3i2cgWB4
 yYXoBM7yNAVjZ6/TGQgHV7H5kz29jRcpGLGPXn8F2IMhM5WCyCbNF2GfOCJObEq0G2Mk
 1scQ==
X-Gm-Message-State: AJcUukfOl+r9pyb6PgxU9oB0LwQ09RTqv3Qnnx2LN2JXK/n3fZ3POnQc
 8eyjFuJj8X084aKZdfTjhBfy+FfZX/mPO9ESo4tvfg==
X-Google-Smtp-Source: ALg8bN54fcbXTfJ6/IvsWTzUd+zqtel0GjfSwej2/yva/6QzmiRZMlEHZmA9EB0n5rGKrDHfxicPAVDg3kHu3SjJwXU=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1209488ljj.9.1545387933976; 
 Fri, 21 Dec 2018 02:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20181108131442.27911-1-ludovic.desroches@microchip.com>
In-Reply-To: <20181108131442.27911-1-ludovic.desroches@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:25:22 +0100
Message-ID: <CACRpkdanMiqM6kV=ZZao-K8_7WzRFb3ymVV6eMSBzYZF3xA34w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: merge at91 pinctrl entries
To: Ludovic Desroches <ludovic.desroches@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_022545_755102_29B6BE8E 
X-CRM114-Status: UNSURE (   8.58  )
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
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 8, 2018 at 2:15 PM Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:

> In order to be aware of all changes related to at91 pinctrl drivers,
> merge the two entries. Make use of the opportunity to replace Atmel by
> Microchip.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
