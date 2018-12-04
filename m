Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D65C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:32:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA8F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nCiEp/fa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLnYTrV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA8F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5yWChsjC6t+wEK10FuGkRZvAyZrC6lCuju6eJX/jAEI=; b=nCiEp/faOYHDp7
	kreMwPS/NHExk78cuMgckAQqoqaCmoeU9Z/LrfX9urvDe7fpkeac6wFLlp5CuOfCUCBmGCOWu7VgS
	a9rqPq0jOXEiuC2nrquNPWycHUOUJfVv78xk3tL/pjxGLx+J8/HdYhgROIaDR6SH0wmvKHMoBWhxg
	F/X8UDCCM9onC+2mc697GESAj8PRSlhicm/G0y5gm8XFTLPpeaYPgtJF6yEiBONgdgoKzd+GY+bzE
	w96Fe1S4PubzGmntDQ3kd7LVpjnGggorCyDdL0mE40WrqJCUvsm6q22fqJdAuw+znV3E9QDfLdJAF
	UktfyU5VAnHKhKaqO17Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTyd5-0003t6-9K; Tue, 04 Dec 2018 00:31:59 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTyd0-0003rd-Rl
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 00:31:57 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so14043269wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 16:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gYmMpe+dwKX9iz1wS/BSQY7uYIuWc/jRARr3zggRsk0=;
 b=OLnYTrV2D85Kh9KZ5rsrNjZGW9oTQyq1cWre87kiESIJtMx8bj/HKMqYeKN+ynSm2D
 NDyZaoq8TUrg2PgIrFzp8ep2y+sZzLd9ZCuAa7HwCe6id9kIQSgtt+C2eEo2/XZLuzrH
 ari84Pp8Ltd4/P6uFXrKtTgNYpfZx7Th9/rUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gYmMpe+dwKX9iz1wS/BSQY7uYIuWc/jRARr3zggRsk0=;
 b=VRZBTeboUCXdchXBWMWrWU19qF2pWq4QTpyufdr9pefv3X/6kkM5Wbv3rbQM9FBqH6
 5Dnim80AtYMXo8oVfyAjD8+LVNoa4+9bDwn0/25caY7gQH+fFX8MjBkjby90IhFNmBAz
 2YhrUEG6F2stUXSSQIxpXuBugcfqRmH/QHlJeI9JoeQeB4mGjEj5QNaIpPDa41yKbFto
 Fzdc8iZOoRL/TZQwEaiEBMHjhXN/lyj/MlqgmA2tAmOMKmdfEpD3XCaILdB+qYa2sjcC
 UsVYmGXEiyKCHZeAwBHelr2U8tXI9Lk3AI2AjsW7lWfM7M78figU1WolkbEiuINXsprg
 VLVA==
X-Gm-Message-State: AA+aEWawxAXiVIKgJWU7aAtsRg7C1qamaYsm8ufcUVFmdtY1At7aRY1V
 tPi5UlMwoD2+WOS5Z/yioHQA2lDN7Jb8DA==
X-Google-Smtp-Source: AFSGD/Wdq/gqhVUMh/CK75JdE/P1cWEpNU2nueN2B4WtA99hSzxRGWM06bCzY9MCgJc8Q/7Ql5EXbQ==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr16759111wrr.162.1543883502249; 
 Mon, 03 Dec 2018 16:31:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
 by smtp.gmail.com with ESMTPSA id q12sm6741201wmf.2.2018.12.03.16.31.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 16:31:41 -0800 (PST)
Date: Tue, 4 Dec 2018 08:31:35 +0800
From: leo.yan@linaro.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] coresight: cpu-debug: Support for CA73 CPUs
Message-ID: <20181204003135.GC22447@leoy-ThinkPad-X240s>
References: <1543540924-16321-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkxc21RbNft+k_oBA=4ZPCBr_rhYSV2vxiHceyJH3M6jVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANLsYkxc21RbNft+k_oBA=4ZPCBr_rhYSV2vxiHceyJH3M6jVw@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_163154_896128_14AC9B2C 
X-CRM114-Status: GOOD (  19.95  )
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 10:34:07AM -0700, Mathieu Poirier wrote:
> On Thu, 29 Nov 2018 at 18:22, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch is to add the AMBA device ID for CA73 CPU, so that CPU debug
> > module can be initialized successfully when a SoC contain CA73 CPUs.
> >
> > This patch has been verified on 96boards Hikey960.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > index 45b2460..e8819d7 100644
> > --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> > @@ -668,6 +668,10 @@ static const struct amba_id debug_ids[] = {
> >                 .id     = 0x000bbd08,
> >                 .mask   = 0x000fffff,
> >         },
> > +       {       /* Debug for Cortex-A73 */
> > +               .id     = 0x000bbd09,
> > +               .mask   = 0x000fffff,
> > +       },
> >         { 0, 0 },
> >  };
> >
> 
> I have picked this up - thanks.

Thanks, Mathieu.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
