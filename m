Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC26EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:55:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD962184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rARWyerL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Up6mppFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD962184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3ji3FN+GT2XYZ1ARBrJeLp9SDErEPUfJHQWKokv7Ziw=; b=rARWyerL711UDrZFzVU/qLotB
	hPWcKu/DIu+qdLJ3N3zJKoqVlAJbjh+RqnmZrh/Nx54SpdeSGAAn6TGBH6uSPbkoF/U3TwgOQiwak
	VD8WpNMJFw4L1ubCy559YNO0muVuJX8Bv+LBH48xR3P189yYGTP/L8aUOVefLADrFtGehZSZegI9u
	YomdE9PAcpy61uHyP1C9+mYIHd+8uFH/GFQgBoU5rzJcImNSGdpi9+5qjXJn4mLc6lGcEy/71udcG
	3OWd8OwAKgcShISLezRRd63YO5z4gsDDFx41fq2YNvc56ubOXMLN4kKcgIBDPx0CPTWHCTwmmX2nO
	sApcpddwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmRQu-0005V8-KL; Wed, 23 Jan 2019 22:55:44 +0000
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmRQr-0005UP-EQ
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 22:55:42 +0000
Received: by mail-yw1-xc43.google.com with SMTP id h193so1634110ywc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 14:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=I1uIy9CFk+zv3YRtcXdTv0UdXQCtUkXX4ROjpszRCJ0=;
 b=Up6mppFd5/8Ka2VldJ6oOki7AlcbXdykqHg3K5IaHhvg1eq8LBbBe8cK8hgNpo/bsU
 IXdBH//JCCW+8TtS1n8SMODF3jXNxe1f4ldo3Ya0KJohWPsf3Eq8EZbA3jexpe5+nU0a
 ByNih5RLRaS29cmrBPrMEPcWavTEjsxcCN12o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=I1uIy9CFk+zv3YRtcXdTv0UdXQCtUkXX4ROjpszRCJ0=;
 b=F5F2WEqniNbPMyfIBLsTzrrOJtnthqG1ZQinQsyv6KKrejCSeyH+MEvQJ2u+IL1uNK
 tgl7AjfRFwZ3FjI2EKDoFvz1WuPBuqUdsvTlOnKKfbLSU1qMLEGfbFXOWEOPdGfJAi5L
 0zen2QZZ7FtMkk2NxQ/n3lK+0e0TScNPFOqqPa1GZY1uz6iTDQVos/a9xBoEB/GlhJUH
 6mL9t5zzdeZydD6/VdWd2lfrgW9DgdM5lR52mQBvURis3bU1fJZLmqdqUpirN3eA5hAW
 9b6UdV7hXVGFXMO14AogZlXpluA7LCEvqrAGLcWI4gbNSidph8CsrOzYeJIR4smkVyas
 QNQQ==
X-Gm-Message-State: AJcUukf8/7Sy5oEIWCf4yueVwlW7f/F2mluRm1QgzygZDMbcJdcrw0/e
 0tC7LJeDsEg721DkdGSf63FyR00qh101t0htC78IpTAZRX5WG3KBZhsiTUu4oWsUuKaI6ZHI237
 vVLq49jMJNFAOoxBTd2ORBNmxA5pqRqBvYAq2tbipGBgdmTvGQ5vhVlnYcWZLhPr6HAecKTpnmy
 D9acsalI2+JYq5We2x9hd/aw==
X-Google-Smtp-Source: ALg8bN7DJyfq4js/zFWYJ3Q8s1eSBHrj9RBhh9KTgzQIj8w6676zTByDi/Y5nDpzpmRvpPz8wHquww==
X-Received: by 2002:a0d:d144:: with SMTP id t65mr4152071ywd.15.1548284139019; 
 Wed, 23 Jan 2019 14:55:39 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id x132sm16154661ywx.27.2019.01.23.14.55.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 14:55:38 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: BCM2835: Enable PM driver
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
References: <1548282236-3962-1-git-send-email-stefan.wahren@i2se.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <5fce5b60-c603-ea8b-b33c-331aab72b1cf@broadcom.com>
Date: Wed, 23 Jan 2019 14:55:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548282236-3962-1-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_145541_487914_65B4082E 
X-CRM114-Status: GOOD (  20.50  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan,

On 2019-01-23 2:23 p.m., Stefan Wahren wrote:
> Since commit 52a4adbaebcc ("ARM: bcm283x: Switch V3D over to using the
> PM driver instead of firmware.") VC4 on BCM2835 requires the power driver.
>
> Otherwise the driver won't probe and HDMI output stays black:
> vc4_v3d 20c00000.v3d: ignoring dependency for device, assuming no driver
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   arch/arm/mach-bcm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> Hi, please ignore the preceding defconfig changes.
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 4ef1e55..b7dbfbc 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -165,6 +165,7 @@ config ARCH_BCM2835
>   	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
>   	select TIMER_OF
>   	select BCM2835_TIMER
> +	select BCM2835_POWER

The use of select is discouraged (as then the driver can never be turned 
off).

If raspberry pi can be used without BCM2835_POWER then select should not 
be used.

Should the change should just be made in "config BCM2835_POWER" to add 
"default ARCH_BCM2835" ?

>   	select PINCTRL
>   	select PINCTRL_BCM2835
>   	select MFD_CORE

Regards,

Scott


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
