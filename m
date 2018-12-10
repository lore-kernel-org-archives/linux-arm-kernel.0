Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDCC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:09:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3B32081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WmcoXNAH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y2JGgst4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3B32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GtoOG1oYcAYVThoy+OP0uRaeH6f8ZbKVvNY6q+BJjiQ=; b=WmcoXNAHMUYXCY
	X8xanQUzUarvyUcd4zVKw4Px6LPO3PvtxXtHNbCaqkoxgfOvclzdVoNHBCvVpxycawO38T/6ydoQU
	ETEKUfRNne7rusDNkAmDfKxej6EWOFLJc/gDaMGxXhwes2rbmCY5x8shBgAJwZhYMiKgDjhqwLynn
	n2z0UXmY+2ZyD/bbKD8i7zaxTjXfrzj+yT5uDrpq2L6Hrj7z4Cj8GFT1iCdiEGFIVrzNOuWKUYaX8
	skCeXH/w8Z553FLCWupxdR8giQwwMLtKMogbv2el/D/D9Li8nMp83TZH1cpxn59J7rtpAfWdJMVZc
	FMCZqHsZRrHPEbMGz4Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHYc-0001RR-UF; Mon, 10 Dec 2018 09:08:54 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHYZ-0001QH-DJ
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:08:52 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so9593345wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O42yOUsF5m+Lm0y0IAiKsUjTDgPRlx7ZlXUb1Wixasw=;
 b=Y2JGgst4Wq69089a6dMvnE9M5RC+BX2YAWO6UZZttNO05XPoWtVMyr38C2YaMq3RCE
 YDP7QX6iQh4C5tPGD1wULR9qZx4wnifTFlM4zyGE3UJhPzCxebjocTLx76R7FK6hAXG3
 IVYzN96axke57HiP47V/rBbqnu0Hi9uz2RN+EqBlEhJOlM3QPW4UwdCBM4PDHgYMo7yn
 OZj0R0t/wczy6DkOTN2fB8C4jCBt9PLJfY3IoYCa91YgO2S7OFNbOVzZo2UYJAKX0IYK
 7PABEnL1LAlWAwmNUy0ZgstotVMNxFDaQlXv2oYA+v0MPNLjn7vPMbaZi9UgCQ4GqXzu
 ldhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O42yOUsF5m+Lm0y0IAiKsUjTDgPRlx7ZlXUb1Wixasw=;
 b=f3wJSGyFLwqPHdQvQS5EexAv55PZlLLUjPBp9HSfxZmMaKaJ1voqV0TtgH05Vfjmjf
 Aghnvxq7fe/KRcj4dgb8EkpM77kTzVnXTGVgGD5t99Xbkw0MRk4ZwyfcRfCEzFtJ4u2p
 MiGI9HeuE19parhDkgzxYkmDDzp4oDBFUAGLLSHtHcNKxQHq4oZMrx5yCxdRKwOesJ39
 BXDLgSmEdZEdakge5D/bhwaAS6NcmCqkGQwZalF8GGiowe4JIRVrMXnO+ub7PeO0wbf+
 WVSi0v2SfXUV6yxxzAZ97IKH8ByayzK17CWWFThJLIaO1DzrVnjGXJhD1+i2mXhNelyz
 0C7g==
X-Gm-Message-State: AA+aEWY4Ip+AdWaeBgiwJ/ZbwcNxNVCN97FNhpXhuq/dSpkCq1/p6eV8
 Yd2wkvHVk2Q2M8bU3ryQkszLENEoRAHOGy/7YYKUeg==
X-Google-Smtp-Source: AFSGD/Wd+hiVKRniurs4QTQa1A0ux9tGPXRYixIMksqehfHHfQUFs9Uri/NN5VsRGqFYOy44DKCRqw3HOXcjJFTypcY=
X-Received: by 2002:a5d:678b:: with SMTP id v11mr9948524wru.245.1544432919775; 
 Mon, 10 Dec 2018 01:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20181210090448.4301-1-mjourdan@baylibre.com>
In-Reply-To: <20181210090448.4301-1-mjourdan@baylibre.com>
From: Maxime Jourdan <mjourdan@baylibre.com>
Date: Mon, 10 Dec 2018 10:08:28 +0100
Message-ID: <CAMO6nazQaBuSD=VN7+e1jcmgsMx_Zvj+yAENhQN5PvJKvyR0qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: remove firmware framebuffers
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010851_448250_7DAAB9B7 
X-CRM114-Status: UNSURE (   9.71  )
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
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 10:05 AM Maxime Jourdan <mjourdan@baylibre.com> wrote:
>
> In case we are using simplefb or another conflicting framebuffer, make
> the call to drm_fb_helper_remove_conflicting_framebuffers()
>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>

Woops, some spaces made it in there.. will resend, sorry about that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
