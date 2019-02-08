Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D72C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C9A20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pA/g0NiE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmBaQFmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C9A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S2JTWQ9W3865eW3NwC1rVxDNQAJmiE1sjO3DZm/NdFY=; b=pA/g0NiE2hR6rk
	FhcfJiLDuDFt2eaIPvlc8Ue8U93t7PpFD1UjO8dfP4paR5aLYKCyWCW1QzTL8e5I1UCDMHdjTnCeF
	KzxltxBywAocog8FhPoFd1EW8Mxf16enS/ntzgcT3zDDp4H7ufKO6F3OvW9Ya8S4byyFSWZYEW31W
	ECdrZQJIkZXA2ElU5lJbIPL3q/qELtm9aAUPLj0o8VZrs7HBNCpkeMDflMxMVXeQrfWBAO3QPjuut
	g4kROVzkI930r/mM6hBDctz2L1Lu0dF3GUZniLEUlHCdnTAy9I29V8wcUzloM9PAZvD8xCJt/+PnT
	uyyvD28ESM3gPCNg7NRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs6IH-0007Mz-7t; Fri, 08 Feb 2019 13:34:13 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs6ID-0007MM-AZ
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 13:34:10 +0000
Received: by mail-lj1-x241.google.com with SMTP id v14-v6so3048819ljv.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hT1KpY7uPwpUpPExJQn6LeYhsQy0SUPQZ6+Yia9oUwg=;
 b=GmBaQFmcXEalcDOu4gHMRZ21n9xIEPIl9HxZcel8s5jmjPclNDRkM4jbYPMfZILZtA
 nnxOjLNCSOby5vRyTXetSzD+ojNuR5vMkDE5hklsCSQEZjk1KqK37G3a9KW3TyFd0EFD
 cJw13Q7Y3Gc/vFmTKlggFs7nAamUXu/VL7bWdsU+LNL9ftKHQPvJy2xsAgt+IzTghvqo
 QrkcLZlbnh5G48Gei1pRR1wIbb5ulGE6Jg1f7cakCHFkfgSlH5bwD2ZdfSW60yGlbsm+
 VuVSFBk2Hxa/JfLRxgLLHUF416rLsAmAENaR/ZEaeywVqL+I1Oms7MWluxOZdcz96CAJ
 DlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hT1KpY7uPwpUpPExJQn6LeYhsQy0SUPQZ6+Yia9oUwg=;
 b=Enh5jIIv4geIEWHKwYBop25nnHDOBwWPDYlE16pLyyt7DOUKMX5gXFX2suhRlAwzjd
 0kBsYx5X3tME41EydpbqKwZ3nHaoAm6MTGy/1/z2S9jkwMO/4qRpqpVqQeMuBsfZosI6
 uMmr5EQPT/aSsh068Dwg6pDSIBoneFNS9n443jTwuZXMUc1/cHTS/AlTM19/kSschZcC
 3V8HPfQffPYIOK29brz9MjYnoKIwyF5RZYEM1RzmFYUQDI/9eOi+Vfc3CMzktMFjTWx/
 OGzfcWCPkbRll3E5qz6E+l3h3XghWpGQbvzDJYhLklL45cp9of+4Kd/aDvTjSUSlhF6g
 1Q1w==
X-Gm-Message-State: AHQUAubods+wDvcWx+zvo/sJTPFP4tXLHRYxzDiwanr/KIxBxF90ZmRP
 iChvnLeV28jir29aSSiKAapDDncT40Lvm8NrDAW57A==
X-Google-Smtp-Source: AHgI3Iaa0doTUcfElIHZkbhRRkiTXKSNmm7NJ0pPtA0V5s51LJ2KkNa6Zn53Exc4EUrJT0jR4A1Sy1mIw09I8Xbj+Os=
X-Received: by 2002:a2e:6109:: with SMTP id
 v9-v6mr13293584ljb.126.1549632847307; 
 Fri, 08 Feb 2019 05:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20190205102546.29457-1-brgl@bgdev.pl>
 <20190205102546.29457-4-brgl@bgdev.pl>
In-Reply-To: <20190205102546.29457-4-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Feb 2019 14:33:55 +0100
Message-ID: <CACRpkdakUOgnkNb1FVfycoq4u50wVo8Aj_57EUBs5QkvrYN7wg@mail.gmail.com>
Subject: Re: [PATCH 3/8] ARM: davinci: omapl138-hawk: use gpio lookup entries
 for usb gpios
To: Bartosz Golaszewski <brgl@bgdev.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_053409_364968_59C62167 
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
Cc: Kevin Hilman <khilman@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 5, 2019 at 11:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add lookup entries for the vbus and overcurrent gpios for omapl138-hawk.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
