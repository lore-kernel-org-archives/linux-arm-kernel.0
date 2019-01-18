Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D00C1B0FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A852054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T21O6GX1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J+vDoW8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A852054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mmE7wm1GJiE2zNg7ZfcdFVNhDwvBGRl5AwLs4PIZU4Q=; b=T21O6GX1vX0Qk3
	+FHksdKoEQZJkub5iGpQRoXV3V2D5uCGm8sTpoqvpNoF5vvAbbA4v7cHmi2b3Qvgy38HSvuivorLl
	gkmVejp94h/J0EGK/3re7Cp8NqN4+1U8cL3PbBSMcaBlTY7/+z7AB0kdvPvMKCP191B7YnOTJ9RIP
	+gy5QDlkG0nZsPyZDUt4tXmYuctYAsIGrGv3rznWWw3iinM05MCWjHVqWuavYYZWBy1nmIoxmZMLl
	gZyI7YifOqzlT+VarVRgdoDzeOd4KhL5+KjjANFo3awcXdZlOeoEVyrSmt19PMO/JVwc9IpyPRaAd
	hZtvtRHP9AhmTp1Cm8Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkc48-0004Fx-R4; Fri, 18 Jan 2019 21:52:40 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkc45-0004Fb-5O
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 21:52:38 +0000
Received: by mail-ua1-x943.google.com with SMTP id j3so5183206uap.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0eOPfx1oRo+N7wuBX4DqqAFZ4MGnCdoDeMf1bAjWf7w=;
 b=J+vDoW8TF9asc3EJ8NrMqFopNqf9/IvnisGuqhZwhpUJ1PXyrtqU9k3tgCBDH35fSL
 m9Ez0EZTK29K0qN9TwCyxoC7hVbGwt/CP85S465wMpfn4ACI9xgD/fN7ZsjsVici+qY7
 Wth9In0MfOyMaR+6EVEWzNYT5izovUiMhdUAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0eOPfx1oRo+N7wuBX4DqqAFZ4MGnCdoDeMf1bAjWf7w=;
 b=pCDQIcd+7rFIkqsOnZbNF0s69e5LCR7l1nSE8Gmq62IvgTSyWjgkKrLMcJJN6LP1Fm
 RTG5LwnErSQOCTcNfhdk+yVidhWdQl9p5Wqt8u1OesGNf4UEEUWFOhHYPYwvh62oc+1C
 NllViuXup3/t2Jf6eodFawZyeqTsb9BlVrQ6gIeowwDCDGoZaTA22t1EMtC9/5jDW3Qt
 3Zv66OosKExaqvKIsAUKVu9wQECfc9ODGhDlRI98bjyBa70QLh1PWj4nJ7lN4iuuDwMr
 vksuksVjKvBy4obMXh8+qXh/ATKmpkqAyyXbdF++PiRPG9H0qiKSN8unoi4tMxCgIr11
 2Jjg==
X-Gm-Message-State: AJcUukfnqxlaO3JdmONvlG2rdUPwnTpwWYLuIHCY827Fyb0XNR2fZegM
 lYQTKodmWMBWBYSbyjm6HteAQJHjJFM=
X-Google-Smtp-Source: ALg8bN6Mur0ekpDl55V2eclp5o+ZXw2xrHp2MLaRgeKuGe3KWDt9ErgbrMeiZrcApo977Brdcsu7jg==
X-Received: by 2002:ab0:5590:: with SMTP id v16mr8392401uaa.132.1547848355323; 
 Fri, 18 Jan 2019 13:52:35 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com.
 [209.85.222.46])
 by smtp.gmail.com with ESMTPSA id l10sm87219108vkl.54.2019.01.18.13.52.32
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 13:52:34 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id j3so5183176uap.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 13:52:32 -0800 (PST)
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr8051406uau.52.1547848352515; 
 Fri, 18 Jan 2019 13:52:32 -0800 (PST)
MIME-Version: 1.0
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jan 2019 13:52:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
Message-ID: <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/a6xx: Add support for an interconnect path
To: Jordan Crouse <jcrouse@codeaurora.org>,
 Georgi Djakov <georgi.djakov@linaro.org>, Rob Clark <robdclark@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_135237_237981_2D35E626 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: Evan Green <evgreen@chromium.org>, Kees Cook <keescook@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Stephen Boyd <swboyd@chromium.org>, Mamta Shukla <mamtashukla555@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Andy Gross <andy.gross@linaro.org>,
 Colin Ian King <colin.king@canonical.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Try to get the interconnect path for the GPU and vote for the maximum
> bandwidth to support all frequencies. This is needed for performance.
> Later we will want to scale the bandwidth based on the frequency to
> also optimize for power but that will require some device tree
> infrastructure that does not yet exist.
>
> v6: use icc_set_bw() instead of icc_set()
> v5: Remove hardcoded interconnect name and just use the default
> v4: Don't use a port string at all to skip the need for names in the DT
> v3: Use macros and change port string per Georgi Djakov
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
>  4 files changed, 33 insertions(+)

Presumably this should go in together with the bindings:

- https://patchwork.kernel.org/patch/10739233/
- https://lkml.kernel.org/r/20181220173026.3857-3-jcrouse@codeaurora.org

...since bindings and code usually go in the same tree together.


As per discussion in v3 AKA v5
<https://patchwork.kernel.org/patch/10739231/>, we're trying to figure
out where to land this.  ;-)

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
