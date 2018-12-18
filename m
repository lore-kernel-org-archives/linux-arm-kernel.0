Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB54C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:54:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A345F21873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dbU5rg8x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qt9nkYTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A345F21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=McVwM+N+7GhxXOVFi6hRIkbYufJ8X7NhYLJmev9hMng=; b=dbU5rg8xQRG3Rb
	gIqS3uq88IV2/NYHJKfwjK9ABIF7xpzBo9uzNZXAE/2AsSQjUmRQ5dxLuF6ETdthnTSgPeipeO0dy
	3p3nHISDTI5jAMzxnNHIDcbnPWNzkPbSmIeHiNgzlGgqr8qnXCeAET6e/AncRCA5HnDseKU+7BINl
	ES/Ab1feaU7VMA/eZKLaKikCNLoVww9hMpwiBjctwd141YMK8V2CFKjCdFU02mZz3Uhrp/bQAD0Ce
	JjprRYMWJnK+jiqWGmcClfCElRwKUFHXWkKLiFGbrtHVdS7NAG3UHiZE3ZBUisBGnEh9/FsZ0+HLo
	1M/OGZqCQX5weWcW9Kgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZOGA-0002cF-DT; Tue, 18 Dec 2018 22:54:42 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZOG7-0002bQ-Q6
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:54:41 +0000
Received: by mail-vs1-xe44.google.com with SMTP id n13so3143876vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fq7z7h+WV8fnvnZAPjzqjNjVLsmr2sgjuI9pvh3fuDo=;
 b=Qt9nkYTN0l2vIK+e63E4i1xyW5pST9WsabBbHHgfQfctax1e68Y9kP/hejFDbT/C4w
 xm5H9eNOBi+UeZDnPsBZw/t/w2MEKUiokELY7kVkfikxDCqf7w0JkjfmqajhPTurGxUf
 81XoFUAF1ZZQPuOmQGEacdnrou6RPdRkP+QDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fq7z7h+WV8fnvnZAPjzqjNjVLsmr2sgjuI9pvh3fuDo=;
 b=hMS4RU/5Y/lSwtNDl8QijWp+iduEgzlld/1ECmPAI1aRB5bULoL9LTN/AfxvNcth/w
 6YzcB82U/0gsRui8y8aU1avhc/olml6p6LxIAwS+Q3USeMKFMrxqEMQMWjvqVyFe4ubu
 IfDNICPPCgdo12qwpr8MPSATA8mf5ElIllJCE0oF294eRx6nvZFUYNK+TeiGCsKYHCZh
 jSHhECDu1f2cAHFYmDXa3KfUoAUY9URpv5klAL9I/+V/IM97Uk/E+6uDWZQsc4HjFPBg
 WX0+wyDiHF1HPwrKsmQAkxf6PF0V1EQNRxfUK9aKykdK8Lmh/CFEZx6lAUrKonMm11Wn
 H3Bw==
X-Gm-Message-State: AA+aEWa2+rjkiMCAcDZIa/d4FBISQvgXWAHbxWglYfgMJE3A+9poEmPl
 kR4BxA502XB3bpNEzmSilzo9+ryh86g=
X-Google-Smtp-Source: AFSGD/WlmDhljRCAj3RoP5M+EUHbvKDeUNtaowwo/o3grfSPsS1Zz6QYSTiRoOXBi8XCTGXAA6KFvA==
X-Received: by 2002:a67:e81:: with SMTP id 123mr8179159vso.43.1545173667143;
 Tue, 18 Dec 2018 14:54:27 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com.
 [209.85.222.42])
 by smtp.gmail.com with ESMTPSA id r130sm8220246vka.55.2018.12.18.14.54.25
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 14:54:26 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id z24so6321376ual.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:54:25 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr8466722uaj.126.1545173665356; 
 Tue, 18 Dec 2018 14:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-2-jcrouse@codeaurora.org>
In-Reply-To: <20181218183241.12830-2-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Dec 2018 14:54:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VU+7LNkDke59cbXXcF=tEExALW+N24iEZn3vXMBuMZAg@mail.gmail.com>
Message-ID: <CAD=FV=VU+7LNkDke59cbXXcF=tEExALW+N24iEZn3vXMBuMZAg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] drm/msm/gpu: Remove hardcoded interrupt name
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_145439_848684_64E2B7BB 
X-CRM114-Status: GOOD (  11.04  )
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
> Every GPU core only has one interrupt so there isn't any
> value in looking up the interrupt by name. Remove the name (which
> is legacy anyway) and use platform_get_irq() instead.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 1 -
>  drivers/gpu/drm/msm/msm_gpu.c           | 2 +-
>  drivers/gpu/drm/msm/msm_gpu.h           | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
