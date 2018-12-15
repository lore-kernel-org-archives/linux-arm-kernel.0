Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:00:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FAF20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lsfw67sO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSwWujwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FAF20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C6vzU14IH26/d7uBYb7HrRZ8HMIWtAv6r4B+TvfK874=; b=Lsfw67sOPpVwy3
	20pfCu3U3e0o6dvdgcC4giNYQRpm8AN7NSTs2AjR53jf05DFlIBUWASbz8s8i3IKXb9fS7cYFE+Xi
	dsJxXciXjs1mu786TKnoAoVViu/AXVIQB7qHGBrrGBa3oHi9yvMNnBDsS5y2TVNAbZBRC7xx8iGtl
	jB6mWsw9OVMbN7Q6QxurTCLa3Y8Mso8cLP29cJZrZzvE9iq3/dM/6CDmReFfDbUuRePwYl6f7IJr4
	fz87D2Xlx68JiT7Mgj81UXLrOaIGOVVScQvr6hSQhzn+u8l6wry05mbAu1HXubNGFj+yPWeK0bAWh
	cCekSoUt7Q8VymqkCCIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXxNe-0006Ra-Hb; Sat, 15 Dec 2018 00:00:30 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXxNb-0006Pz-4B
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 00:00:28 +0000
Received: by mail-vs1-xe42.google.com with SMTP id x1so4419376vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 16:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8BaBCagR3qbLAVt5q17wq19g9nTIxQsNRR/b0PtEjbE=;
 b=VSwWujwfHHCqqUTs7LikUwG7Ww36RGoOXkhWKM4h3KJNMGBY0TGx3a0Kgdo9LQlVjw
 tp5YRSBx9o4+29WBStar7A1pg4Ia1TH1vAdohSQKb7t5QsyWm1KllsR18dR4/hk4gqDe
 MtQbwXrPbQWPYIqY1Hy4rRz39QSGgTY7TNkFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8BaBCagR3qbLAVt5q17wq19g9nTIxQsNRR/b0PtEjbE=;
 b=mzBoRlXmFUOKSSsk6R2yczf6UK9pCj1QCQ7W1mVnwSbS0iGJ/KxydlzS11uNREQIS2
 mZGaxjAs/RDPF2YN6puxh80j86/NPuLYsLuP7CI+xIeon4ETh9LDS2m2sb7JMFQTeg9I
 40+45mzXyqNr1Q6Mc+sd5VnprLliSIzo594ULiMDKcBBFFQ0njCojWhLUC6gtcH70Eaa
 LJUZEGpB+H0LMeqDcvLuRmx3ySABdCVdRWuLnLruyEYTX+ybh33/ad9oeWNYLyHfhnpe
 2Ern4WjSRH85MMykKqiYXrTzHi0Ot/RBxWL1aEuikVnM3BDxUYj3WCr0c/T5Vc7JmL6g
 beGA==
X-Gm-Message-State: AA+aEWb7UhXFLVf9yGlMMs6FtqYcZUsF1d2wNOTTNUk2eOedcP0JF6Ik
 0DTKvwX3fIOiaLftxOTCKQYyOFTAlxU=
X-Google-Smtp-Source: AFSGD/W7CYJdouuJZSceEFXD7tWw2LXjxx2wcLQ7GjN+wvX9eyv7SmJzNWOVzB8t/iW1x080TCIE1A==
X-Received: by 2002:a67:4985:: with SMTP id d5mr2354641vsg.41.1544832015804;
 Fri, 14 Dec 2018 16:00:15 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47])
 by smtp.gmail.com with ESMTPSA id b131sm2481261vkf.45.2018.12.14.16.00.14
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 16:00:15 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id t17so4417728vsc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 16:00:14 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr2366290vsj.144.1544832014543; 
 Fri, 14 Dec 2018 16:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20181214221640.25354-1-jcrouse@codeaurora.org>
 <20181214221640.25354-2-jcrouse@codeaurora.org>
 <CAD=FV=WPWvUb2t4YdKq5-m0GpO5k-iuwrAnRx3VCgBkCaWZjeA@mail.gmail.com>
In-Reply-To: <CAD=FV=WPWvUb2t4YdKq5-m0GpO5k-iuwrAnRx3VCgBkCaWZjeA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Dec 2018 16:00:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WUL6w-e8iF7OXoKHjoSDHVNCDV7jCybite0XiCzwaiaA@mail.gmail.com>
Message-ID: <CAD=FV=WUL6w-e8iF7OXoKHjoSDHVNCDV7jCybite0XiCzwaiaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
To: Jordan Crouse <jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_160027_167656_4952CFA2 
X-CRM114-Status: GOOD (  11.35  )
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

On Fri, Dec 14, 2018 at 3:58 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Dec 14, 2018 at 2:16 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
> >
> > Add documentation for the interconnect and interconnect-names bindings
> > for the GPU node as detailed by bindings/interconnect/interconnect.txt.
> >
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> Looks good to me.  This could go into Andy's tree as soon as Georgi's
> series lands somewhere.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

To correct myself, this maybe should go through Georgi's tree together
with <https://patchwork.kernel.org/patch/10718587/>.  It's the actual
dts that would go into Andy's tree.

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
