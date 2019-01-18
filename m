Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D14C1B0F7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:04:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6064A2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3c/9o08";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P/TCebjH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TUzP/gYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6064A2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Kp5gV7m7uNtGuQ5K73GMjhXkbmqCSw4xWphfxuvd8w=; b=q3c/9o08iFSMi5
	KPhopa8g+9kVPoyBDHP3uPt0121umbvDxAE7ubQ07+D9Dvn4oIsbdunh03eThPlM1Mr719cpr5i2m
	kv3VK5WLSidSLmz4HgtrM8+slJyHhFbyBSC0MPCZ5g83rqh6Y0bMqU422dQk6vn12LSlB/bjErE9X
	kg3aypcxFWTh4HY5nXX1xVaEaqHMEB0Pmp9g6JRAT8hx8YrL18VxbWAXHPQ47u+SfeZq1oYJX5HAL
	eyPZJaeFMi9RehPuppm5PMrnbFWVwJ2L8TlkQrYT1Oz4j62xJuosXOVCPdxBk1rqhgdCY0LgK/DY8
	BagD29MFr4NzleOCm6uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkcFW-0008UE-Ur; Fri, 18 Jan 2019 22:04:26 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkcFT-0008Ts-Qm
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 22:04:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 95033605A0; Fri, 18 Jan 2019 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547849062;
 bh=BOgPAZwW8IKRhRcPizoEbMnDotDEOB+or5QwhH4AQhY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P/TCebjHEhMnrOD0Tmo2fhScPNLmYxTxz5+AIrI5Z8nWasaDXiL5jJIv7piUXU+JA
 IjNln3eCiQiFbOgYhwn36nVBT0Ws2IMzSLH0Ngu3aCGS3cV0okbfjWZg8PtpkWFu1o
 Pj4/D1+f2IQxe1510FxCgasoN/w9AMRDRIP2RGIQ=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AAB226053B;
 Fri, 18 Jan 2019 22:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547849061;
 bh=BOgPAZwW8IKRhRcPizoEbMnDotDEOB+or5QwhH4AQhY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TUzP/gYj16/g5/ygA8K1PVDdjDRMdgTaWcgxXKAJvvez6TiLa6qC2XlQMa+3qivlG
 WxnqgqKbkK39Q4gyuwDudVDWAFWCBTLl0kogR/Ueq6MHQ/H7Ts20i4YNohaPG4ao8U
 6GFgoWTilXFFNidagV8H9xqZUezJRnnACIA+cLOc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAB226053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 18 Jan 2019 15:04:17 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [Freedreno] [PATCH v6] drm/msm/a6xx: Add support for an
 interconnect path
Message-ID: <20190118220417.GE4140@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Evan Green <evgreen@chromium.org>,
 Kees Cook <keescook@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>,
 LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Mamta Shukla <mamtashukla555@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Andy Gross <andy.gross@linaro.org>,
 Colin Ian King <colin.king@canonical.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1547843058-27933-1-git-send-email-jcrouse@codeaurora.org>
 <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD=FV=XBBk31zqgJMqcTeNLoEWxLzow=LxQ=2geJAaf6Cpui_Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_140423_915805_40020601 
X-CRM114-Status: GOOD (  21.97  )
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
Cc: Kees Cook <keescook@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Rob Clark <robdclark@gmail.com>, Mamta Shukla <mamtashukla555@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Gross <andy.gross@linaro.org>, Colin Ian King <colin.king@canonical.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 01:52:20PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jan 18, 2019 at 12:24 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Try to get the interconnect path for the GPU and vote for the maximum
> > bandwidth to support all frequencies. This is needed for performance.
> > Later we will want to scale the bandwidth based on the frequency to
> > also optimize for power but that will require some device tree
> > infrastructure that does not yet exist.
> >
> > v6: use icc_set_bw() instead of icc_set()
> > v5: Remove hardcoded interconnect name and just use the default
> > v4: Don't use a port string at all to skip the need for names in the DT
> > v3: Use macros and change port string per Georgi Djakov
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
> >  drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
> >  4 files changed, 33 insertions(+)
> 
> Presumably this should go in together with the bindings:
> 
> - https://patchwork.kernel.org/patch/10739233/
> - https://lkml.kernel.org/r/20181220173026.3857-3-jcrouse@codeaurora.org
> 
> ...since bindings and code usually go in the same tree together.
> 
> 
> As per discussion in v3 AKA v5
> <https://patchwork.kernel.org/patch/10739231/>, we're trying to figure
> out where to land this.  ;-)
 
I'm just a simple caveman driver developer. I'll let the adults figure
out where to put what. LMK if you need a rebase on a different tree.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
