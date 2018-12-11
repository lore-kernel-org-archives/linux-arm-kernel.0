Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB4C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149852054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZIN8f3w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BztX15TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149852054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w4O3hyblIshpk1Rg2+8LYyqV630/TjjJVIL5NQzFzlw=; b=sZIN8f3wrxu/8B
	y/xJBGAi16GEM2ALDD0zVawlvvN7IbiMw0zYO2rjFti+09AmhV9rN6nNPvo77WK7yAsdRRW0Y6aMN
	BGtzXOpbSyXtmLeCjMG3LLu4gVC7ErPlJSiHYREHqLGGxbUdPtno/Jo7vkUhqHDzjUegb61opYyq+
	qOWdl7Rm6O06WKE6qQYl5udSVsvW8uk0WO07JojezRth1rUEAhfOFaXJf01wmDkdUzXSPL0YxF3LD
	iNXS13tP93j2ZfHCuSMloG4ZFrayBGUeWHBuFFQc9ynp0X26dFjlnLlB069qJ72as/WJe67/rZ5FJ
	HCELcvzrtQzapkWxinnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWaBk-0006kn-QT; Tue, 11 Dec 2018 05:02:32 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWaBh-00063T-3b
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 05:02:30 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so11715789ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 21:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wVQRKeA3LrWUFCWj38YW7UNSSMR/1M/U3bbK4X1HaM4=;
 b=BztX15TNf7C7JxFUBcuRZ/qB3t398Eo2pCh/aQzySjA0fVL2z47AuIWjYtd9qAIZVP
 JQ8BkW9bc7OgFORj8f0r38W6zQOGCULUcuHq4fVi+m5vMZ/kar0V9KWUTk8pE85WICXA
 8ZXYldkg03UzrpCEzpUYfhDg7oYWNX36Eu6Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wVQRKeA3LrWUFCWj38YW7UNSSMR/1M/U3bbK4X1HaM4=;
 b=obXVGbS1I/mS99Wq1y5r63P24bGTcVn51c5KS+2vrBUqEu0gyg/XW09yQTug2AUjaP
 au0kqqGlIMUcoGG3nQ6nFx+lLSkGh//NOFU/uN/cO5fZwnzjRSo/AzcLJt8NkzHJZ14B
 7TIjoWyr5S1kdn9YwwyR5vc0BJk5h3RY/HTUheOhoFzpqb2V8uUz2C5z+yMh4WY1qa2R
 xkgWDIR+av+g+yYeX0I9DURXZIlcWMfOFfi7E3pmIxCgdlLpnLBhx8k0QVFk0ikaPJp7
 W3MC2kBIYYeqDHPcUkV4pHYHWneLTFd/1kRZ76NUjjd1SVaVsft9km98Me0fF+U5efgf
 kEDQ==
X-Gm-Message-State: AA+aEWb2PZdZ7koWoU6rVmI3R/Yibg2oVMA/5ZbrrhtgaUNlHmfV/WS2
 tsqhkaovGMBC0c65jchbN9fLpT4FMkmLNl4p3ApGVQ==
X-Google-Smtp-Source: AFSGD/VuMe2A4VysUGd7mBU+4U74dImBJpPyuFVbtqtcDzpRkOGYUHnvT5qGhhYPmns7cS0suGaB68PC4l+fdz8wiqc=
X-Received: by 2002:a2e:b1ca:: with SMTP id
 e10-v6mr9693666lja.16.1544504536565; 
 Mon, 10 Dec 2018 21:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20181211035725.5084-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20181211035725.5084-1-manivannan.sadhasivam@linaro.org>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 11 Dec 2018 13:02:04 +0800
Message-ID: <CAMz4kuKtJSmUheV3F0P6RP_prCaS94NC2uBh05g5DNp3pJ=9XQ@mail.gmail.com>
Subject: Re: [PATCH] Add linux-unisoc mailing list to Spreadtrum SoC support
To: manivannan.sadhasivam@linaro.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_210229_205930_2440B2A0 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: Chunyan Zhang <zhang.lyra@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?R2VuZyBSZW4gKOS7u+i1kyk=?= <geng.ren@unisoc.com>,
 linux-unisoc@lists.infradead.org, orson.zhai@unisoc.com,
 Orson Zhai <orsonzhai@gmail.com>, afaerber@suse.de,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 11 Dec 2018 at 11:57, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Since Spreadtrum is now merged into Unisoc Communications, let's use the
> newly created linux-unisoc mailing list for all discussions around the
> Spreadtrum SoCs.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks.
Acked-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6682420421c1..d1f768fd4f49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2108,6 +2108,7 @@ ARM/SPREADTRUM SoC SUPPORT
>  M:     Orson Zhai <orsonzhai@gmail.com>
>  M:     Baolin Wang <baolin.wang@linaro.org>
>  M:     Chunyan Zhang <zhang.lyra@gmail.com>
> +L:     linux-unisoc@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     arch/arm64/boot/dts/sprd
>  N:     sprd
> --
> 2.17.1
>


-- 
Baolin Wang
Best Regards

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
