Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D6C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:33:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168862082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="anObiLUE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiEnxpDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168862082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vvc1J0RPAp8ZVt3ywIi6msw/EG9qqAN61L2Ogkp/Kn4=; b=anObiLUEIJxL6U
	BNiWxKAQwGiJ3/0Q4G3YQAbm0eBvatP0RpHJpq5yM+T6qbXuPzeoLCROk4ZMjlW1Qeg7fqVvtrTGG
	BvO+mhTGUAf1/Q5eBqLG36RCIKhW7+eVfepzE5BT2rjrjupZUJ7oNRpggwVDEhEL2yV6K18S/LldY
	gFDOmVAvAO2wlP47kk8tzEjOwBYzb2VHb6AEfcAooL1B9WNlzdeNI8YR7CRJa4CfaIDkBTGLrGWJO
	sxKe2Sl5JzC1pQ0hKM2AQcrVTdhl5Vb7mwD3FK7Y5budmB0Edw0pIyDGKbN+LParUXeVA2qlMGw+u
	01Lh4vbpWnH4Dxlm7L6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV6t5-00069i-F4; Fri, 07 Dec 2018 03:33:11 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV6t2-00069J-0H
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 03:33:09 +0000
Received: by mail-it1-x141.google.com with SMTP id c9so5096066itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 19:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lImpoPquEFPRLAbtM9c9WiJ5WZcuZVDjkP8vpeAT/x4=;
 b=XiEnxpDXxEKhXwwnwB5DUlXwV7efZ/Ar9ottXGeJnMpySNjtBLk+ajMiIfzOLdM85q
 WBM1S3L9He8DG+J8ok0RmcyQD4KZUy/8/0XFdXLZP31a3pRHI4eFoL6lcCa/oSClVPDh
 aDaArNohQYn1jjDeWpah04HQmsHTuKqNmugW0BE015jBjBoNCdslqduAOL7NAz5vhr+J
 n81FBI/NS0tQ0i3bHGXAKzkRQlgMweb0MY0R6NzHSQz1Xp3p9MDSq2Cxs5OWhXdN9NJq
 NJXdn2XQwkAoQ+EVXFY3p+4DEFD16aeoxgoUozViRNKgaQo83ifSopdvH06gFiy5BgZT
 BOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lImpoPquEFPRLAbtM9c9WiJ5WZcuZVDjkP8vpeAT/x4=;
 b=JVJMk2d/WEc9LuFNk+3mF8NPL+GT0Sel/V2IDMJpGNedrbwSFWoOETQT/8d/K6CjIE
 S5pclWsPBoZPzUPNRidEdbOddzmZTW1cgXfSBDEiAgp3yAduzke10tUbmE2iEbKarEgr
 D+/Bce94S3szW09Xj82TKDBnLfGt7Qh17tyctLagrixbhVvfdnh1zOTFnAay5z8WmXw+
 dqJ7kYBZkQC8GICujmoVRfhGCHeipfgaBo4aIHuKkpO0Vp28SU/b5nMfGv6JTkZYLsGJ
 VGIkwyBenZSD0BXGk61Brh3h/BqZFii5CEDFIx69iYVNcyNakYVjPSKIn5gtS2fiaXe2
 eUtg==
X-Gm-Message-State: AA+aEWbq2iiD0j96USTs6e7NHxLVVpX8W5qpwhwWJPLHspvEwDBqAQCi
 2Me0mpBcYjhBlzqsYxZOb5afR34vrHkwJK7/SPU=
X-Google-Smtp-Source: AFSGD/X2KRp3YzR6BoRMuiHEz3XqPJcZ33U3SDAsJXse1MTkNSOCURjvCPK/ctND/eisdvXSsoxJAtA2Zg8bVRgcFW0=
X-Received: by 2002:a24:94cb:: with SMTP id j194mr811615ite.117.1544153576285; 
 Thu, 06 Dec 2018 19:32:56 -0800 (PST)
MIME-Version: 1.0
References: <1544139677-16904-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1544139677-16904-1-git-send-email-festevam@gmail.com>
From: Chris Healy <cphealy@gmail.com>
Date: Thu, 6 Dec 2018 19:32:44 -0800
Message-ID: <CAFXsbZok52X1wjouFvxZES36kYFWJKBRJnt37rAmZtLoMO=tFQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for
 hpa1
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_193308_047904_D338DA36 
X-CRM114-Status: GOOD (  11.91  )
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
 linux ARM <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> From: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> TPA6130A2 SD pin on RDU1 is not really controlled by SoC and instead
> is only meant to notify the system that audio was "muted" by external
> actors. To accommodate that, drop "power-gpio" property of hpa1 node as
> well as specify a name for that GPIO so that userspace can access it.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 28e9dca..a8220f0 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -478,6 +478,15 @@
>  };
>
>  &gpio1 {
> +       gpio-line-names = "", "", "", "",
> +                         "", "", "", "",

Tested-by: Chris Healy <cphealy@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
