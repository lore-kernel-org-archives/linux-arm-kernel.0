Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6799C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728F62080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YeHezUTr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="k9Wj1Ga6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728F62080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aDpMS0uQuS1BWAd5QVuxmd1LtSlnrJwffxWyOQSt6Pk=; b=YeHezUTrGX7O3/
	Z4fRmQLa31zhzt7w3oRfJ9H3XOK7VbQ+m6Jx6FXiWttyrnVdZB7adhCdwaLGr9xoA525DOF9TNOgb
	/pz16Dc7LgNhEw4uP+Mtxw+04iqwEjWl+U6zQHD6/RAh6UjJlBIOGY2JJtt0KzakrIDhMS/kSAE23
	C9wvxg6jhX8IiYSsJiefeOnX7e6bGfYlOXgisNURwXdEupyeGBRcLiLgNr+TFfVF1eK2X2IUZOaLj
	7ws2zuFMv3eMtJYoX3FdvLpyEstmwVXLqlWyPL/vSMReeYTh8K0dT+Fw6hzNRpbSqpeh4tWE29fUk
	IY+ufjOUFz6HP3cLoCcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKr3-0004bT-OM; Thu, 13 Dec 2018 06:52:17 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqT-00045c-Uz
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:43 +0000
Received: by mail-lf1-x141.google.com with SMTP id v5so695299lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sE4Z5OU4gaOrko8m/wFq96oa1vJFoTEj3lKqFuj+qR4=;
 b=k9Wj1Ga6Xy98cW4q6l5O5Kdqi3BlMMoVBstos1JvgNOZPvDnX33+fgG+3GN+LhDWEA
 tCPlFQ2D6Od8NWOwwttZPHN0qxQbrvshfKndW0VkCJ3RH3Rm63kduuRKN6qOShM+GAlx
 IncTIbOGS9Q3dLmW9U6o28vSAhS+TkDHZf500Rn1fiohLue2zraCsWwAvumr09sedUnY
 AD8x7OVaKhuGtuS/SHbgkD6690rIm5/IrMkTrs5sp2fh0INDnEAHFrOOnNesP1sTvcXj
 C9dvCMmQlPZCQnSsMn8s0VMuwZH//sk6+BGilb9kEgaAbeFTRuUXv3MlN9DaxvTWeeV8
 OXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sE4Z5OU4gaOrko8m/wFq96oa1vJFoTEj3lKqFuj+qR4=;
 b=J2AFI77DU5t/Chn53v6OMHjiqvbKGjdM1ABKzGFKVg3byZUXDIPB8iQcQSxdKOkUMe
 k8yRtxIK+l6+6/MRpUGPjYbrVfa0ji4M7TWb8MQ5JPlN4WyXnPiaJs8QIodxfAKH5dVu
 AxU712ppwjVU089sdmwXhCnqffBEFOoKRnDxT/9Chi6/56ndR+9CYocktFEcAjC760wW
 VilO7EQOucBsKh+vvaX4gw8T5HzF859Hms3+pd8FuB3qlu+Tgdo5VB8W+IiBzM2k/Ktc
 7uwocybIOaVa1HgY6hO6JaVQhziZ2mpeK1Cq+mgNZeCZb6ANdoyeHbZbPdHzkuFs6ViV
 ubhA==
X-Gm-Message-State: AA+aEWbJvy/Hq/DjqXmTpB7odfNxQE5hg2y7lfKbhMBRLuuxG3Q2bK51
 tZZo+woY8q1RR7LWwOAlI0YMkw==
X-Google-Smtp-Source: AFSGD/VLlqcEQhX9qCU3nPZBNtoDj6HHx3IuTrmydp7Sjr2ZYZIDZVyG/d5o8X4AiS79TN9wnHMPow==
X-Received: by 2002:a19:7111:: with SMTP id m17mr12886205lfc.64.1544683889839; 
 Wed, 12 Dec 2018 22:51:29 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id j76-v6sm155849ljb.12.2018.12.12.22.51.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:28 -0800 (PST)
Date: Wed, 12 Dec 2018 18:09:38 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 2/9] arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
Message-ID: <20181213020938.oazz77dq4iat3ivc@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <281cd6fb-138a-956c-999b-58d9e04787c7@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <281cd6fb-138a-956c-999b-58d9e04787c7@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225142_002824_A2ACDB9D 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 09, 2018 at 02:00:28AM +0100, Marc Gonzalez wrote:
> Commit a7314405d83c ("drop ARM_BIG_LITTLE_CPUFREQ support for ARM64")
> dropped ARM_BIG_LITTLE_CPUFREQ support for ARM64, so remove it from
> the defconfig.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

No longer needed since patch 1 dropped it.


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
