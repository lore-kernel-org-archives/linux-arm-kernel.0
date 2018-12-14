Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33769C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:59:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB7A206DD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t31Oo9kl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHrR8Tu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0lut7eeNcb+QK/0Y+6qMS+dfaBQUhJPnCQ/ZSuYrfnA=; b=t31Oo9klbI7GoB
	9TCbOfO8T0JaQcZWQhckuOB41Xpd0w6K1OYhAjjzYtzBzhrRtiYmnaO8ZelYRMpoLs0DYNgBrt4QH
	X9LpafYPe20PVtbeUt6wVQQozToIvgp7d61k19oMLOEemMci5sBVLkgd0nPcm+IdkMDbSAKgwDLiy
	sRHdwShTM5lV9qYpOgiNbw9rnnVedR+73EiTLTRk/YT89eLzNaEFIIeiEHUKwcOLPy6L2/qcI06SL
	2SFJsK8ICtgWos78LOIeNRkZRk1ccwIWQWlAhzLgNzvQ6rjUYNKFExVBzmVPnDRX9h9xdQu2o+B6a
	XBb0QvtEMGLuCnx3ACvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXxML-0004NI-0M; Fri, 14 Dec 2018 23:59:09 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXxMH-0004Ls-UT
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 23:59:07 +0000
Received: by mail-vs1-xe41.google.com with SMTP id x64so4441336vsa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E1vDxwZYJ5nvWbHl/wMHQ4T+3C0+x5e5dZ4wlD0StiQ=;
 b=bHrR8Tu8wTBebo6e5gsRxuo6krI4o/GHFuyDh3kwBJvjp7Pq4Xra8fYHvobiW+tZM7
 GPF1QB4HqtAwW0ro3hjejkDFI4gt2hTMv9NSu9MRFKvoep606+NrGofVD8kJ3cOIMeOc
 K8RuTrHbdmM/45ikaNPhAFnkNt4Kap1xbPN5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E1vDxwZYJ5nvWbHl/wMHQ4T+3C0+x5e5dZ4wlD0StiQ=;
 b=a86Qk9kTLay58QrPWfb6in5OpRyt4BgpHTmoeXnEAkY2buD9J0nSC3KogRsxEbyUtQ
 YrLPMlehORd6Pb3xIiyn9FMCcaqRTqiHRQ/479cg+8eYYwqQdhgJtWEQRsrGuasFmVHG
 rGGNDmZ2LXwX+1q3p/Yr9em58HuBPA4temV1cJzU83i9w9/hQKC7WoTekBgWLnjDq/+a
 Eq4xmoQ5I0QqKjo1ZQGvDlUHij4S5g3JDyrNPZMtd49nGluugviApUcm4xXLs1fUMIYB
 ElpJxS9BUm/kdXfPtkjBEuJxOzU4AWoo7lGUM/6Kbx8mSUk9Ee9La/aTV3UPjHiHhRgg
 naSw==
X-Gm-Message-State: AA+aEWagRts4H99FXlI1j1FfWGBxOaFiR6nSO8BffkKOeHssoiR/yU5x
 wJVijMPOuaV6u5cg7ySL5UwD+oV1zCk=
X-Google-Smtp-Source: AFSGD/UrcjEYA0XDCIzeZoKIPcXlSLYScu/Xksseif4DZTCFX9MY0fiOlGdrcLHVJBQVHgVZGzsPsg==
X-Received: by 2002:a67:df04:: with SMTP id s4mr2156231vsk.212.1544831934421; 
 Fri, 14 Dec 2018 15:58:54 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com.
 [209.85.222.54])
 by smtp.gmail.com with ESMTPSA id i17sm3204476vsg.30.2018.12.14.15.58.52
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 15:58:53 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id e16so2600020uam.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 15:58:52 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr2316518uae.9.1544831932486;
 Fri, 14 Dec 2018 15:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
 <20181214221640.25354-2-jcrouse@codeaurora.org>
In-Reply-To: <20181214221640.25354-2-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Dec 2018 15:58:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WPWvUb2t4YdKq5-m0GpO5k-iuwrAnRx3VCgBkCaWZjeA@mail.gmail.com>
Message-ID: <CAD=FV=WPWvUb2t4YdKq5-m0GpO5k-iuwrAnRx3VCgBkCaWZjeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_155905_982905_4F1BF8F8 
X-CRM114-Status: UNSURE (   9.74  )
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
> Add documentation for the interconnect and interconnect-names bindings
> for the GPU node as detailed by bindings/interconnect/interconnect.txt.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Looks good to me.  This could go into Andy's tree as soon as Georgi's
series lands somewhere.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
