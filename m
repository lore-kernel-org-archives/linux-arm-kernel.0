Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84267C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:59:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA07206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jR+rjG/b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivI2TUr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA07206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CEeptQVUR86rq+YfROhy30neqBqvOYdli8xDQcg/Jok=; b=jR+rjG/bjUfU6N
	Ptm3YQyKbcNqh2qaiRbRKWILBfqsGWd8oCl2AbQq9Y3TNgPy/8rnqbaPIPE+JIyYuHhfYUCIm1mzq
	EB99KLShSKK1IZPg3mZ7Lw4Y8nP1jZYtnSRj74dotWISFh7I3aS8zXyvgJ4zIyS72D/SiidhZ3si2
	gfNOMnSOweGpLf/GnpWKIYA5Rbds1Zje8A5SNYfhnnOYIBGvYc81YZBw/up4rUMM2iQOY22n7m1LM
	L9j1gKiwvXCJq6Zn/yJ9QiBZRXw8zdPZFz0jZKKvifc2+2h8XjevH/fQZdxGCk1NdFcAv7QlJ5RsT
	77Q3uw3OmNdXMlD5c3xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXxMg-0004gR-9G; Fri, 14 Dec 2018 23:59:30 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXxMd-0004Ve-42
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 23:59:28 +0000
Received: by mail-vs1-xe44.google.com with SMTP id p74so4456233vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kFEMGOQh1fvQCJpUOp2wPQpGwxwzPfkvO6V89Ozmsy8=;
 b=ivI2TUr8jhtt8RKVNaZSJjN7x/z1rY42Lx5H8rxixp40YEWL5pk0UXn9/MvvQd5lJ5
 Iqrk6Xq8sFf4vKE3p8zIj8fTVIXV/1eEdckNO5sRffA+Uavk+mV3HIrbbi+ffzs7jhkp
 CnTv+LH6SdyWmFgZws94DrCVGv4fqoyaE4kTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kFEMGOQh1fvQCJpUOp2wPQpGwxwzPfkvO6V89Ozmsy8=;
 b=YxUcFgXNXnmgkuoOZ+6j+djv+2ItOtVRte31MKwE24acH4i4o2/bT2a2ZVYOB00eDk
 b5zREyh2fbwlzj68RrrjTQ0qFHaU6PykjgqA8v3Q1ddRTi9u6kZP3bFTNtgjACHbBIUs
 e3yxAtwOqiOQm9uLvmcowSYU9RENMzffDRb7Rz5fpncjIxxwxQer/w6x9IOpkWpZcH6Y
 yeGIZ3mVqZE8YZeUl/3w43v5VQGIz9G2NmnjU50aNi6lZiuv2Fb1Zeom2oGM5TaTgq/U
 jJoIR5CQqz8os/QsnrPw6DpsA+IDuViE+lb2TINBAI2YDyhITqYs7npaRiLBGMx2uVDX
 mkHQ==
X-Gm-Message-State: AA+aEWYMhVNdWYQVbVQAmz4hDg1rl0O4fF/fzDKPDTjfSWPL8FaWgClh
 WrhKAHM/fQtH3hrON6o5VqTBrZ8lK2I=
X-Google-Smtp-Source: AFSGD/Who9z0F2Fm4VY+YcPwsCHQct/hMrI3fRq4cY7xNdG+HT31W5AVWjqWf9wFiYLlmad4TydnIw==
X-Received: by 2002:a67:32c6:: with SMTP id y189mr2356650vsy.105.1544831955564; 
 Fri, 14 Dec 2018 15:59:15 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50])
 by smtp.gmail.com with ESMTPSA id k133sm3319555vkf.19.2018.12.14.15.59.14
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 15:59:14 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id n10so4418279vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 15:59:14 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr2124711vsv.20.1544831954220;
 Fri, 14 Dec 2018 15:59:14 -0800 (PST)
MIME-Version: 1.0
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
 <20181214221640.25354-3-jcrouse@codeaurora.org>
In-Reply-To: <20181214221640.25354-3-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Dec 2018 15:59:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W91Y5Eoduyi4NhhwV_Kcs20kQ35O9eqA-5vSWaPOv0mg@mail.gmail.com>
Message-ID: <CAD=FV=W91Y5Eoduyi4NhhwV_Kcs20kQ35O9eqA-5vSWaPOv0mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: sdm845: Add interconnect for GPU
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_155927_161579_BE872910 
X-CRM114-Status: GOOD (  10.00  )
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

On Fri, Dec 14, 2018 at 2:16 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Define an interconnect port for the GPU to set bus
> capabilities.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Looks good to me.  This could go into Andy's tree as soon as Georgi's
series lands somewhere.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
