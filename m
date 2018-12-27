Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A00C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:05:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33AB2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3wfq18D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuBPV1SY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33AB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GcRd7mp5NeOFOXuSPG4lCHN170Ad76o/gJDqpmRsGcU=; b=q3wfq18DL42zPy
	Xd3FRKLVwJt2XjliNPIRtCGb0yoyDpOH3qPQ0FKF0ORM+PcGfOhYApZ+2xqDPW5+hGx1UX13wGC+k
	PVUW7uX6SyUVTf3jaiZkzlwLypGyE5fzW1Y8oHwpt2GH9Z7Pt35hDloKEt7z1iUwYIyImNtg+tXbc
	2UWBIl9hPFxJm7esP0Y29r+rGmBmOeFAWhVOkXmODYasSubFNEqC2H+FxPXmBtbqP05v9WArxzVHa
	d8nzsIi1j69EJi+DAHRv2HbqoH9l0FeoJrygpEFVNtRpRIn7HKp+7QPFuh0g6IpSbMOaGhYZHdwsL
	QXGFqRsOEL+trU2ZTCyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcMv8-0006Vh-MO; Thu, 27 Dec 2018 04:05:18 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcMv2-0005G4-Og
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 04:05:16 +0000
Received: by mail-pg1-x541.google.com with SMTP id s198so8291572pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 20:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cvXQ4mLFRGvm8zhEeMGUp5Fx2IDR+KBFGhFVEaC/w/0=;
 b=XuBPV1SYKUgBhRhQ0vneoxdAM8a4F3343q8jR/tIzeCVZ4Z3x4dZUL6y1uGiogE7Fy
 4v3+OJfO0bfRRQer1tVCKXWzRhIlzhFLrfqw1CMJAD3UzLStTcDYqCS0pcWk/bhwwy55
 ayNaag6o6MGobiQ1q1DuGmAAiW/6O4FQh4m4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cvXQ4mLFRGvm8zhEeMGUp5Fx2IDR+KBFGhFVEaC/w/0=;
 b=aufVdVUY3QQKzO6Z29ZDBqzZhqdX4wHR9r1QCJa6Ksxi3ScWtrhaGC+cmZwQ8bNtPx
 vk0mhHb9L5UL8d90oiwQqRY6HM94PfboKez+3Jh8sgZHddVXCwypJ1vCzSN9EgOXhSB9
 h7I79rAap5A6qr+QVtOz1l41xiIaVcVO3J0zjNslI3oYhnkMIJvWN6CKD7O/t0hY7xEG
 7ap3mykjS3Cwn/4DcSXuweFRxl82/h16an3coZcQvLzdVk69sAZMl5y9Wocidty9XQIG
 abdqbe23mleg8UM0Is0n2iAzdGafS4cOETLQsEdp/Q4Jq9Ni9EoOpORkh6rxAp+A6qZq
 cHJQ==
X-Gm-Message-State: AJcUuke4Bf5yMxQfRflGHKDSS+9zziaj9vSzWPsHfc3B4GJs1IlYjYaF
 wpc8NyRk6/94vJV9Wz6i4vtngQ==
X-Google-Smtp-Source: AFSGD/UZs+p52NYLcCx/BqpT/TKjoGHJpi7g8759+hfAuWmg2k1L9MpVuSEa/lTZw7oOTQNa4N05wg==
X-Received: by 2002:a62:6f88:: with SMTP id
 k130mr22476992pfc.234.1545883501100; 
 Wed, 26 Dec 2018 20:05:01 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id k63sm69080469pfc.76.2018.12.26.20.04.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Dec 2018 20:05:00 -0800 (PST)
Date: Wed, 26 Dec 2018 20:03:41 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
Message-ID: <20181227040341.GA9651@builder>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_200512_808906_E826D3FD 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, MSM <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham <kishon@ti.com>, David Brown <david.brown@linaro.org>,
 Matt Wagantall <mattw@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
 Mitchel Humpherys <mitchelh@codeaurora.org>,
 Yaniv Gardi <ygardi@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri 21 Dec 02:13 PST 2018, Marc Gonzalez wrote:

> The private copy of readl_poll_timeout is no longer needed.
> Use the implementation in iopoll.h instead.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-ufs-i.h | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> index 681644e43248..f798fb64de94 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> @@ -23,24 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> -
> -#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
> -({ \
> -	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> -	might_sleep_if(timeout_us); \
> -	for (;;) { \
> -		(val) = readl(addr); \
> -		if (cond) \
> -			break; \
> -		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
> -			(val) = readl(addr); \
> -			break; \
> -		} \
> -		if (sleep_us) \
> -			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
> -	} \
> -	(cond) ? 0 : -ETIMEDOUT; \
> -})
> +#include <linux/iopoll.h>
>  
>  #define UFS_QCOM_PHY_CAL_ENTRY(reg, val)	\
>  	{				\
> -- 
> 2.17.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
