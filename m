Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE48C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:23:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B521C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J8tYr64q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPbnRV8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B521C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4oBKPL0o22kNdFX6yZbaCJWIO65pGm9n0JHaeJRJbpU=; b=J8tYr64qcXr66b
	yKcoCdd4CN5ump/Yju8IGFvqVQWrGP9nOLa2ncSzYQPLTGPcqhcod1KjuTBxeg9/lUs5wO5N9GE15
	Q2tRBWulSitzDO0QLyvCAA42j8cqxi7mSXzvFRM5vx9HyESBfCeGpDletOZEN72AKTK92QphLkqwt
	gNTRI1eW+zwV2POJHzxNELB8RwLNjVfaJQ9CyxQxiXXMKV5Xx9A5E6WuQAJjxlw3/Ist5o4rajXsQ
	osGw53prf6nG8/YMV+Lf5nlCvDsz56AP7626Qwfm3xSKqMrFtDuBdTZucdssg1H73aUXF8I7bzcwW
	M8j9GZitSpnckCWszXqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTXKf-0003sH-76; Sun, 02 Dec 2018 19:23:09 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTXKb-0003rh-C6
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 19:23:07 +0000
Received: by mail-it1-x141.google.com with SMTP id i145so5994344ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2w0buL5Xx8UbDc2kJnZ6NfK8EDqL7Pfy1r5E8R5uED8=;
 b=oPbnRV8FT/ht6o9E1+KiFJ64OFTWZfbxV26EghXct8lJJzafXAeSHiH+P0XcM9J6Dt
 u8Rg1rAm1ylkqoo4+oRbvlagXm2BBsE3peMwUAEuP93ph9L7vcslyXw059Fadty5A44U
 XaJe1Vt2WblsA92FgcZ4qemImAi5wDIQbm3kJvi3ffH3BBXW3qMxsrZiH6p2UdUkYfcd
 ky3vcP9bWU4nGzEXciA0ZVjunau0A3c03MbKPMOg1m/zCUsZPoRpLZMdY8O0E8OI9UO0
 ZucFDD9MwAvj5Mm9B6ODHgPMM4VlSt137dS+RS8bGpDHcFumaeXhc0/lLg4r+QYAA0DH
 +evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2w0buL5Xx8UbDc2kJnZ6NfK8EDqL7Pfy1r5E8R5uED8=;
 b=golI/KqOAoh9aWVG+D0uchZ95adSI6ZLpWsjuW72nRt6bB6m4B3IRBJpP7meROqM89
 vwKd7RBmZBRPQDqwT6fmtZ5eDI9Gx1l/1fxrC39jY76abXSuA/i6Pz5Y0elo+zIDwJSJ
 w0tBtWlHrXHJ1eLNxkiAGof7v1uuE95ueKSBb8v5gUYbAMX/vPn2uvS20iXPsMP1+JNq
 9qbSwOuqxIg2PvsQE4YESbrs6AqeoaOl7kfEaIu61mRFKgKk+WUehsArUAlNpfy9teOZ
 Vck/eKEOQPoIOowSLi19wUohdouJD7rYnRtnCkU495FDI5/SHc6ZPAILoiBTCT75ScEc
 8sGQ==
X-Gm-Message-State: AA+aEWakJ+DwByZ5J61KyQ+k/fCqxurfTYHVb5Mvrh4U2EbXsu2ZdtbA
 YLNJFMPocjsCm0EJdOoZ8FGWq5NRnaL8Z84otA0=
X-Google-Smtp-Source: AFSGD/VX3sNsaVD7flP+I2BXz+ZmJVwZWinDch4PSIlu8LzTcvYuscevmkX/H4wQ+mg9hKQ6yIbnD8Z4PbOkLwcrf5E=
X-Received: by 2002:a02:f42:: with SMTP id h63mr12310050jad.133.1543778574068; 
 Sun, 02 Dec 2018 11:22:54 -0800 (PST)
MIME-Version: 1.0
References: <1543504220-10870-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1543504220-10870-1-git-send-email-festevam@gmail.com>
From: Chris Healy <cphealy@gmail.com>
Date: Sun, 2 Dec 2018 11:22:42 -0800
Message-ID: <CAFXsbZoUPp2aNT_K_=SjKY8uX-0CLCPXwnRiY9hM52E9W30KKw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
To: Fabio Estevam <festevam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_112305_440248_ACFE5D28 
X-CRM114-Status: GOOD (  13.08  )
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
 linux ARM <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> On the vf610-zii-scu4-aib board there is a hi8435 ( 32-channel
> discrete-to-digital SPI sensor device) in the DSPI0 bus.
>
> Add support for it.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> index 52bac14..a1fd49e 100644
> --- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> +++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> @@ -397,6 +397,20 @@
>         };
>  };
>
> +&dspi0 {
> +       pinctrl-0 = <&pinctrl_dspi0>;

Reviewed-by: Chris Healy <cphealy@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
