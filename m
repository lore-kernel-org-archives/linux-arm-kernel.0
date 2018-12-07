Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAECC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:25:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EEA20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ox0ep2fC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgsjKIFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EEA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=flaVY58ACZeUNNmd1bTKUDDG+avuKjdx8yDICVNDOx4=; b=Ox0ep2fChzPdiI
	trjIR3Ig2xeDV3OHsUjNDShQDIcZVcIJddTUNExlpUnKrryLDz3vDJJhE42ptM3r3L+wGJlmwu82l
	A6qYCx1Hy3iHjULswT75xhF6T+izUCzynrtNXdQ49UjlEvjQluP1TzwYZzUPB6VeduTormOkvjPef
	ceqDif4XuFE3U9Md1ikL7vzagfJmuuaXbfsT7cptV2FVzilxRjOUDlG44hQp4YQvYTbygTk/Jr6Yw
	NfREHx5i+dTMjJGzJXS/zBcm/6Aj6sI74+mtYGRMvIPvaHNuKF1B7Nmi1bEALgaSk6lFr8kxlXap9
	9Fi2MlkxuuRLOweZ4BWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVPV2-0007O9-TM; Fri, 07 Dec 2018 23:25:36 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVPUz-0007NJ-0u
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 23:25:34 +0000
Received: by mail-ot1-x343.google.com with SMTP id 40so5388269oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 15:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qe0ACQZfyNvg5zbmOoLlaU3tWbDrKhhv2hmO8MfdFGg=;
 b=LgsjKIFJ/CrOa7fVuG0DScvLPmSRgiGdBHmwNq2OmHJb3jsULY+LcUM9kVJC1dWjNb
 KkoFPKBJwPHBRMrUiEZaTBDd3g1PbvoOPnpQfxKJuJeGcrtfc82rwC1mfAvJDlA1NWWB
 pKxyTSZN0WURtk3GacAtrNaBmBajuJrmmqadklLeNF4jp2TDTUwQZGFh3WFCJDD/e0zi
 inrI5b/3sfNZaSQD8Yt0+SNkQL1o/BRGcqEtMYlg8erEJsG4AbTBLxbQ1a2s6GXc3P3l
 XGjUWmbxQR1cbM5YZAnwgWR6cUQy+ow6CW1HD+GIBYsfImq6ZrHflb3h6nUS3JSlnjGI
 +mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qe0ACQZfyNvg5zbmOoLlaU3tWbDrKhhv2hmO8MfdFGg=;
 b=Sa4zQsmBn5Z9DgPwrSwiiURis3X11U2HjDfBny8qO66FF+oXQb1Ww69aXjF8THAGeN
 ceRTmA14nInmHxB4vFHuvRhSTlIWu781vQB2/ncn4g12AMDv1m0z1fYfA0jzkPywHmKQ
 S6aKZnsVYz8FKGbWcIz5Y66I0LflVo0GlDXjXM0/ofCZqGpQFZ9eECejG8qhhSms/ezT
 idBk+iWesT0voSWwfTVNsMc7c/G2zGXHPatdfPHBQuV1Bo9QpUQpi1zbDbhipodonwTk
 wekX/BIrEmMYejjTO44HYULQVSxPY75HXlvfiR1brv06su4DwZ3dDMH7AqU3dgkg6M5m
 PrJg==
X-Gm-Message-State: AA+aEWY/4Dy+Tqgd4o2aLUxDBh73+BqWS5+8h0Nx40fsKCEtblnXmTpZ
 JEoK29uZUUJyNiiBW31riD/oTR66EKCn48sGSoA=
X-Google-Smtp-Source: AFSGD/UiF25joLw3rdcLWHClw9dmtWXr/cPRsGbTMpcYSvD6K7HKDkfLF9Q/+ov6Q3J2UBn5iAYKU8Ry/n3MOj8/dMw=
X-Received: by 2002:a9d:84e:: with SMTP id 72mr2864107oty.203.1544225121368;
 Fri, 07 Dec 2018 15:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20181204151702.8514-1-jonathan@marek.ca>
 <20181204151702.8514-4-jonathan@marek.ca>
In-Reply-To: <20181204151702.8514-4-jonathan@marek.ca>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 7 Dec 2018 21:25:10 -0200
Message-ID: <CAOMZO5CoBj4OJ++kKgzfksJ6seqKHJN0W-4YwTKKSrwUkM6gMw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ARM: dts: imx5: add gpu nodes
To: Jonathan Marek <jonathan@marek.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_152533_072775_1CCAB931 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, freedreno@lists.freedesktop.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Chris Healy <Chris.Healy@zii.aero>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 1:20 PM Jonathan Marek <jonathan@marek.ca> wrote:
>
> This adds the gpu nodes for the adreno 200 GPU on iMX51 and iMX53, now
> supported by the freedreno driver.
>
> The compatible for the iMX51 uses a patchid of 1, which is used by drm/msm
> driver to identify the smaller 128KiB GMEM size.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
