Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F75217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VO06fOfa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYiDNk7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F75217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x+yaJ122T5MfWc6xHy0/aqmO6lCuXwwhz3lwOjQshPo=; b=VO06fOfa7fnB/e
	2gSAWzfGIhNV93K6kxP0/IdQVECNhKDbrdoJgbDt5fASyR1plOAMoOGq5od959tbpiPn5nZa8wYRB
	9rMzNlL8wLvMVrMppzHtl+0lu0SzpxYnEOcEh+gP7MHRb7005/Q3qp/2EsitZx0+WuRRDy/09qBZH
	+eit3hqKAbhf9JfCafh5OsCduMUK1xYLZYdJnU6kEgBLDb5LM7EAT1qOXlTipok8eokkXPAzknXSI
	fGYQLILFqug1n1uGvoRrUF7eMaVB38CasG/u83/2SGaEGgs9BryKmvUiRQe68MyFIRhZAD5EtDBCC
	IK8GgcedbV57PNkWjLUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZOIy-0004Ne-SW; Tue, 18 Dec 2018 22:57:36 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZOIv-0004Mr-EK
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:57:34 +0000
Received: by mail-vs1-xe44.google.com with SMTP id z3so11078477vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6G6SWY+XuJtLE2LHATgfZnugZcZJBbrunNyGqKOrQw0=;
 b=aYiDNk7iwehnSglmiQysgZObQMa5icxtUZ1mj3qnyx8dVNKI7XkLWbVEPQrrp+mc2e
 bE8Wo0msdViR/XQkuD4D3EJizDr2gOpFzBK3FzlgLu837rnGruNA2mzdFyi6eQVGIF0+
 SKLIppx2gQT2/TNNv3NyCZ2M8gO+xQDzOPRvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6G6SWY+XuJtLE2LHATgfZnugZcZJBbrunNyGqKOrQw0=;
 b=G+YlkMJbmGJ6mAM47fHTV6DgnLltC+PSI8Mk5jHRczJEXsMW3XdM4uEsxh9Ea1RNk8
 k9KKOI+u8pYIi0KJcS5GkXyL5kQoNup1bWhp/TRnDaOMFYWCppFIsv8L/tpCuF1mCWCw
 XtD+qsgUfoolyQMGCkqUqagYpWZ4JswKTITCJPJ4ZYP5GESlGaSJSPt1kxUWNl4a6yef
 1u8bOabMm81Z7Spp5NlhubDo0w0Ku9Es+cMsRSQceWndU7AftmdLw1VVcw2LENX+Ho7P
 b4fdPv+guvXpXI9cHrCzJeBGSd7muREDHDFzHUXEFF86RI8KDu2j83E9PZqDfowidAGg
 xw8A==
X-Gm-Message-State: AA+aEWbrJdM6MsHTwX4WvcIrsA9UeXy6hBLpW5jRZHzOMJ+XnZ7t9H5x
 c7o9MKr80Hx1uezLPLD5VZ1o07nqWH0=
X-Google-Smtp-Source: AFSGD/UbsFiw3pk64mEiByWHmyVAKD4NVvrT2+gMe/GQxxs4XKFT3mOi8zJ+07BmzK6KvNSg9vHj4w==
X-Received: by 2002:a67:6849:: with SMTP id d70mr9278309vsc.199.1545173842462; 
 Tue, 18 Dec 2018 14:57:22 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com.
 [209.85.217.48])
 by smtp.gmail.com with ESMTPSA id o8sm5956691vkf.4.2018.12.18.14.57.20
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 14:57:21 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id z3so11078436vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:57:20 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr8256052vsv.20.1545173840602;
 Tue, 18 Dec 2018 14:57:20 -0800 (PST)
MIME-Version: 1.0
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-5-jcrouse@codeaurora.org>
In-Reply-To: <20181218183241.12830-5-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Dec 2018 14:57:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VD7Hnu__k98bk3-SyrVwb=cjuOtZj=A3wv1_i813Jk+A@mail.gmail.com>
Message-ID: <CAD=FV=VD7Hnu__k98bk3-SyrVwb=cjuOtZj=A3wv1_i813Jk+A@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] arm64: dts: qcom: msm8916: Remove unused
 interrupt-names from GPU
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_145733_488263_9BDF4C24 
X-CRM114-Status: GOOD (  11.71  )
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
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Looks good to me.  It should be noted that Andy shouldn't land this
until he has a tree that contains ("drm/msm/gpu: Remove hardcoded
interrupt name").  ...or he should Ack this and it should go through
the same tree as that patch.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
