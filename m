Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99015C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:29:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657162184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HDXWVh0X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GR/dI8qE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657162184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rqN82lxrIsoB9NgfmJAsI7P9nZgUWkWpqnmC6+5taE8=; b=HDXWVh0X2v06lc
	Mv1h+mpsPlG+QbVQB+mXKkQKYoFcpBDh2MTvJUY7DVKeEouVrTR+idTVKEpFUFKuF6rgvMnYLrjKw
	tgO/i+f+ZV1do8VgSS9j4CZYFFKhINgxRGyfQFDtXvSG43BnqS1JhOhAwMi/vvka6vyQuhHDxkrCo
	I0thvPneS6kpL9DAvvl38nWYvHN8/1xF8cCGjvZk6IWpFG+7Xx/t+UD265iaSyjuC+LlMX81knrum
	WhcieBz4J6F3cPD22zQZyIr8I8IjzakxfloS38cSDAtkOD/Aemlrag2OjKSBZtKxvq/M3/A9Spakb
	HcDGM62+grRA0HXQ5PVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNs9-00040R-A8; Tue, 18 Dec 2018 22:29:53 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNs6-0003XE-Qs
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:29:52 +0000
Received: by mail-vs1-xe42.google.com with SMTP id n10so10995041vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2CAQEVNnQuGAORgaQbQM/cx/vkzjKmMroAyCUvtSZK4=;
 b=GR/dI8qERZvnl6VA+KkK5HHQ9fGzM9+XJxnoyO2pNvFz8ZvHFmC2nO6snGBvz2idXh
 d7YhSnE/h46gTsy23zZxTAoDixSOQ1SWclCgvpMDm/vm8dck6SJNDr5r7YKmJFxQLyVW
 k7ruOogsd0qZ9M7i0kN9HQyA1YPWL1S4rks3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2CAQEVNnQuGAORgaQbQM/cx/vkzjKmMroAyCUvtSZK4=;
 b=b/Epa5C9LhQ/OT7Q7KkZFkoOGXuq71uTIMEB+wGCnEXmRFEG2r+EaSx7SMUZCFB1gk
 doaXJyiGiYu+X4T2ebYxBUMRuVFHFbgziq9mAadpB9R2ImVq7qo3zXYEOG/C38Rd1meb
 WZdTd9gHR95sEYK0r8+Ci2iztXQV7dvMpWUvvQQlR01h3l2UBsao0Wf5nIOslVCLfG3Q
 JWeNtk9Z+gwiisg+g9MQ9CepmIXB950s45YR5zFBvsH4HMUC2EoqTAq3zD1K4Hk2lSjy
 whCi1ybdsyf6/8Ygq3DeDpSXhuJY+mMMSRFvc0AJ/02yd0dNSPQCIHHF5v/Sq6QGrMnQ
 V8IQ==
X-Gm-Message-State: AA+aEWaSDgffOolgpiIhbs/q23tnHJq9nKCx3WpXoxhyUcstTXGL2opr
 FipbHRksaG/Iha4XuQq5mawS9GMVy7U=
X-Google-Smtp-Source: AFSGD/XNyzQlJBGcUVTCfC/1ITH5Pwm5uCG7BlfqVtvgmCX187Q+W2LJBtwtVgAJdwXvIoE/CqECnA==
X-Received: by 2002:a67:6d42:: with SMTP id i63mr9101711vsc.158.1545172179197; 
 Tue, 18 Dec 2018 14:29:39 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com.
 [209.85.221.173])
 by smtp.gmail.com with ESMTPSA id s11sm4356709uao.15.2018.12.18.14.29.37
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 14:29:37 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id v70so4055291vkv.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:29:37 -0800 (PST)
X-Received: by 2002:a1f:bfd6:: with SMTP id p205mr6400543vkf.70.1545172176853; 
 Tue, 18 Dec 2018 14:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-4-jcrouse@codeaurora.org>
In-Reply-To: <20181218183241.12830-4-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Dec 2018 14:29:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vi2bNCQ-A+h=1w9P15-XwCq7weZJ7LP7HBfs+GMTv=rA@mail.gmail.com>
Message-ID: <CAD=FV=Vi2bNCQ-A+h=1w9P15-XwCq7weZJ7LP7HBfs+GMTv=rA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] ARM: dts: qcom: Removed unused interrupt-names
 from GPU node
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_142950_867982_21FE2A69 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, vireshk@kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Dec 18, 2018 at 10:32 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> 'interrupt-names' shouldn't be used in cases when there is only
> one interrupt and it is not otherwise used in the driver.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Looks good to me.  It should be noted that Andy shouldn't land this
until he has a tree that contains ("drm/msm/gpu: Remove hardcoded
interrupt name").  ...or he should Ack this and it should go through
the same tree as that patch.

I'm curious: is there a reason you didn't remove it from the other two users?

linuxnext/master:arch/arm/boot/dts/imx51.dtsi:
interrupt-names = "kgsl_3d0_irq";
linuxnext/master:arch/arm/boot/dts/imx53.dtsi:
interrupt-names = "kgsl_3d0_irq";

...also: if this really is only for "apq8064" and not globally for all
qcom devices it'd be nice to mention "apq8064" somewhere in the
subject.

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
