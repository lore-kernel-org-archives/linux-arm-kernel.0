Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BEEC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:57:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36C82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CeHBG+Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36C82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BeNhVMmO1hyl5YXjvE5rxo5duYs8CKL7fjvdtGXZ9Nc=; b=CeHBG+GkuPINjo
	Q4uT1nmS+HZ+/ad893p28CdcyJF2+7QRAzigbs0+6cHcFFb9EiqrTwbifuPMF05KJO4xhCF5Xlyyv
	QA3uCucvzSqDcY98aQ/WlmzSbPUD3P/tJy/Xfqailqgz16yQFozJfHe4LLA/wf07yxPdr2eVBL6DR
	6d1U6BMQUha0zFns9C/L0Yj2z7SXRqf3pJLYe078tx1QOB1C6uN59NHMe4fSmD6vThUsL526ciZl2
	1yngZ1YqCVra7DNTpyzubT/nWpolxezQ4F5GFwFjHflrVs9FP6l9dq8TrJRwIu/bdFfFnYISGHlQA
	XMrOV+Lgnesw7KsqEqmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXY2j-0007Bv-KV; Thu, 13 Dec 2018 20:57:13 +0000
Received: from mail-ed1-f68.google.com ([209.85.208.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXY2g-0007B3-NZ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 20:57:12 +0000
Received: by mail-ed1-f68.google.com with SMTP id x30so3224195edx.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 13 Dec 2018 12:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jiloVI4DrNhUNu7aY7/oZysl09FBOMw9CGKSD2mADwo=;
 b=HpkULnn/QcLm1jF3xUyX5tDqPfmzLK3NSSKD4oBqoMFdqAUc5vAI+g7/AgLN2icbrh
 Yym03+yLoPhs1pcVSMIAMOqd9/MLYsyDiTaabU+E5mfKO6fURmpXHEWTZBHhnd04t3zi
 Sn6PwxE+CzPJvQS6FtoxqBtDOKDWmpopOwJgXx8PbpbpEOwn+c3vvYRT4hmlgTWYynPB
 cvbEj1jHk5gdQ49xLkpsa/FYzT6fYkBd4TqX0NxQF3SuZ8eyEH/sVYXyLtV97YKJjy2u
 SQ4uZMwKSv/dz+ru4QvT6a2oBD/QB+DPZXNqFCOFJy1tTnKL9Dlp22X0TB7KDFGG7ahc
 Vx4w==
X-Gm-Message-State: AA+aEWZyM9FfyGYeWAnxLQ8vLUIGI/AgOq9bfMny2/zAEmW/u8YQAF2d
 ZpczoBoFZobQvECpKjFK7BA=
X-Google-Smtp-Source: AFSGD/U9XmS2tnwU7yZRrWHUL/Q2DnsFdknROFBl/iTeUqL5CbvUd+O1yT2s+TJNdtxoUQfsw4WV/Q==
X-Received: by 2002:a17:906:7692:: with SMTP id
 o18-v6mr524296ejm.63.1544734618522; 
 Thu, 13 Dec 2018 12:56:58 -0800 (PST)
Received: from kozik-lap ([178.38.170.116])
 by smtp.googlemail.com with ESMTPSA id
 w24-v6sm497373eja.71.2018.12.13.12.56.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 13 Dec 2018 12:56:57 -0800 (PST)
Date: Thu, 13 Dec 2018 21:56:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: Specify I2S assigned clocks in proper
 node
Message-ID: <20181213205656.GA799@kozik-lap>
References: <CGME20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab@epcas2p2.samsung.com>
 <20181212175744.8287-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212175744.8287-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_125710_763118_87CA8225 
X-CRM114-Status: GOOD (  14.11  )
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
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 06:57:44PM +0100, Sylwester Nawrocki wrote:
> The assigned parent clocks should be normally specified in the consumer
> device's DT node, this ensures respective driver always sees correct clock
> settings when required.
> 
> This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
> that appeared after commits:
> 
> 'commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")'
> 'commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")'
> 'commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")'
> 
> Without this patch the driver gets wrong clock as the I2S function (op_clk)
> clock in probe() and effectively the clock which is finally assigned from DT
> is not being enabled/disabled in the runtime resume/suspend ops.
> 
> Without the above listed commits the EXYNOS_I2S_BUS clock was always set
> as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
> with not enabled EXYNOS_SCLK_I2S.
> 
> Cc: stable@vger.kernel.org # v4.17+

I gues your format would work (got recognized by stable scripts) but
strictly speaking format is different:

	Cc: <stable@vger.kernel.org> # 4.17.x

https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable-kernel-rules.rst#L127

Thanks, fixed and applied.

Best regards,
Krzysztof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
