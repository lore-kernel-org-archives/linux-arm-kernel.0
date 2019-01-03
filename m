Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E88C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:49:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E832070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uIZIiUAn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlebsdW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E832070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0UcRBaXTlS/c576oQfJbkepm2OSz8jm2uNsStz2D210=; b=uIZIiUAnNPNjmE
	3WlF7A7qhBvlWrr3iful8zEeV78Eb6x3nS6ON8qMiZZwzu/o8EF4w74a0qzO5k2mEKfuRHpsA3VwE
	PuTRZG+ij0OblEA5njH+60MDWvkE8i8dRvgpzG0jZoVR64BiRA0wxGzMM7Z7jBw5A52BJDKjn1Ful
	/3DdC7rzZxL9Yd8tgkdSmuSXdVB8nLFSyZoKv2mjw/NVxF5PB7r5OpY2X1/TRa58/mQogFPn65wzp
	Jliin9U+fImj5rxksXyZTiI+68XhI3EoXQ7FvxTWUjJlOIqoEjO0oaAx5qK8RXFS+wb7+Rm6FinF2
	5joW/MLk6Fdi6hUFW+Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geuwE-0003pM-HV; Thu, 03 Jan 2019 04:48:58 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geuwB-0003oI-Ey
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 04:48:56 +0000
Received: by mail-pl1-x644.google.com with SMTP id e5so15389105plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 20:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wD3XC5clJgBcb8qj6+QFlJOKL54hcbtfhGqHXTkeYKQ=;
 b=DlebsdW5lff+RPbGDS2SLByu/C1tjDsxWGxidpo1iP89m+Wnjz9mYRADF390OWvb1w
 O/JyjlVafxkMq240QYceRnXncgvmZNNM7/qrOsaGahRQxKIV+MhiQyJ0CYvmUkxF5bXm
 f+Lv7vyy0k2KjKUUm2Vl4VnHs2JsR6dgrmd2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wD3XC5clJgBcb8qj6+QFlJOKL54hcbtfhGqHXTkeYKQ=;
 b=nxpR4wJ4NCmOXhz4nlCpWw+5l4UPlkEqr/Rlv/10WKWH6w7s3/tXf/+PZPUJvd3Gak
 uJGWRR+4XV/ED6uBQqaNYWffuuEWvhqID8mpDjXWt6MUu3wsF4qb59l4jha9yTV2X9cL
 O3Q5a8cN0/nbcX+4cQWzEbEAWYruPGmfz+QCJHKXRMetgCZgz/wdmlGrMfBiDYLKy/xL
 djBg9TG/irZj1bRD2h7uDxYOS6ivqeBVc6CsCB2DpzYBkJpbMfmO6KUqgxADfJOgK0f5
 9XeT1yBYdPPtxtQtl9qtB/FrwmtUiZsoySQc4V/1BPv0vssf75rkRSZ8F3YjwQqcYgy8
 PnBw==
X-Gm-Message-State: AJcUukf8ABRDxBCG67DAkIcIjschEB8F8huIAd3WYqJlto7SD8haZPsv
 ZqmDT9OCR7Ws3tYHceNksjPZDw==
X-Google-Smtp-Source: ALg8bN7eRV8ClXNiBKmZQLflSwaRLxDf6g9zcU0iaIq0tFuz7/SxTF3erLWkUgrBUsyblij6npzmjg==
X-Received: by 2002:a17:902:1008:: with SMTP id
 b8mr44348614pla.252.1546490934801; 
 Wed, 02 Jan 2019 20:48:54 -0800 (PST)
Received: from localhost ([122.166.131.155])
 by smtp.gmail.com with ESMTPSA id h134sm108167206pfe.27.2019.01.02.20.48.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Jan 2019 20:48:54 -0800 (PST)
Date: Thu, 3 Jan 2019 10:18:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
Message-ID: <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_204855_501506_F2D61600 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 02-01-19, 22:09, Henry Chen wrote:
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 2 frameworks basically:
> 
> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>    requirements from different clients
> 2. Active state management of power domains[1]: to handle the operating
>    voltage opp requirement from different power domains

Honestly speaking I wasn't sure if anyone apart from Qcom will ever use this
feature when I wrote it first and I am quite surprised and happy to see your
patches.

They are mostly very neat and clean patches and I don't have complaints with
most of them. Lets see what comments others provide on them.

Thanks.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
