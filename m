Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47150C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:19:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0458220811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NoONyG63";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="sGjhNdNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0458220811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hBZbjHxHU44jrIGLQ6PvS25Fqse91Kl5E1ZWPWOZ+ps=; b=NoONyG63eDPNlo
	afsq+L1xLFVYc9G1qVcvBTKAbLV0KAI/iromCK4olO9N0RUuHUlh89bhMv6FmY4hVMqO0LBeqF+e3
	vA5J9+cpQxtanT9i99wfrOPwk7hDg3qQITu4kI9bnKgHr1+VJ2LvtloMIQNTKso4rZm3u/48BuLL5
	aL25uVcrFx2W+BB4K782thdZBLuMjjUywEQ0BwquAmwb98FiBrgO3f99U+cXUwNLp6P+HSfxaBMur
	ODVwNvMO2g7eebM7f/xxLFaYkSf4Xvfvp58kPDCzyl3XPiji+Z6kJMyApHUCnj7zzdo31vQzzjmcd
	HV0eaXHTYFk9bqoKBb2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBv3-0002Fw-4u; Wed, 12 Dec 2018 21:19:49 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqw-0006bD-R3
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:46 +0000
Received: by mail-lf1-x143.google.com with SMTP id n18so14654957lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TMLzE3Hbz/RrV/10INNcKQgOJ8EYeahX29/gxqf4YuU=;
 b=sGjhNdNqvwofDgpIYBl+XIcXCJPvfIPMx7u0hdSc96vFV4oRINZPRgt579OyVBdjK6
 XE4YguoeOFD3WsIEtHqWuUIy2A+INBqOYd30s5RxMbPUzWLLa/inRwVRU6p+I4YrW6tB
 9o6s54MhcQTwnnFihw3jceRkWTNrEfsjcJsJ2Os8isrgu2PUBD5U5iF1RSEe3sUDg029
 uR1OaMKLYgLAy69F1DwEOx5KGVn0wwQCLe12Xr2zSEduwJmuDQ0x1KiG+yZ8cBedOwYL
 xYK6Dqx0ZDyV5AcprqwD0TOHrYc8WvuX49dhg+KJXuOAtv0eEWDHNnItCjwCRH5/AWqB
 WdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TMLzE3Hbz/RrV/10INNcKQgOJ8EYeahX29/gxqf4YuU=;
 b=PMbz2bNuwvaPiSr/n+c6jPqkcy/vLemGzu8E1amKYBuIbQI7YyQhfPgN3DWsdLn/RI
 zvYRKUzSQogsAb7y0ikzWRJgyPZrbP40+wcf4Qj4t6s/kjPxvIEnp68/tEjUSl5PXnFm
 yYj0h0uo1ZW9i0toqbgAEWiO7Bac+EE3cn2DRHXXlI7boEBykZCjCgkbX9Co0hX9G21B
 pXezDWD1GSmqMPDy3coxrYWxQyDkKtXYqsIpilJuEcbmNad774MX4IANlIIk7Ys1iB+6
 lpJDizGFi7dWVv+lbuKx53pZpDTNkXFvWkwo1tJKkiXepYFi+LojQ34uvjbrYmQnisdJ
 BMBA==
X-Gm-Message-State: AA+aEWa9zcRmuehTxSPpkEwMI9t5rZVLDggWwSQ7Hqic0wYv+mDUdat7
 aWKItQXBNIUX9NH9xjWV1UO9u1Wq4xMPtw==
X-Google-Smtp-Source: AFSGD/UVAMVVougJFeJuYoU/xshdTqiLkgf5AoKFvMQtX81j5nE2AruFkPHdx7R1BOuvg/loqJMfYw==
X-Received: by 2002:a19:a302:: with SMTP id m2mr13581045lfe.108.1544649323015; 
 Wed, 12 Dec 2018 13:15:23 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id g70-v6sm3486635ljg.92.2018.12.12.13.15.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:19 -0800 (PST)
Date: Wed, 12 Dec 2018 13:08:06 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 2/3] Rockchip dts64 updates for 4.21 round2
Message-ID: <20181212210806.upjts4z4axh756zf@localhost>
References: <7153021.iXIDTOc0j0@phil>
 <2442209.9nBR0uFduZ@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2442209.9nBR0uFduZ@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131535_312225_A0A3B97C 
X-CRM114-Status: GOOD (  15.27  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 09:44:31AM +0100, Heiko Stuebner wrote:
> The following changes since commit cdd46460fe278e04d8ee665d975aa2962036838f:
> 
>   arm64: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:35 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-dts64-2
> 
> for you to fetch changes up to 953d9f3903659fb1e21f6453ef5221a7652ec908:
> 
>   arm64: dts: rockchip: Add on-board LED support on rk3399-rock960 (2018-12-11 20:09:38 +0100)
> 
> ----------------------------------------------------------------
> Support for the onboard LEDs of the 2 96boards (ficus, rock960),
> hdmi output for rockpro64, vpu node on rk3399 and adding the
> always on 32kHz clock on rk3399-Gru to get a more complete clock
> tree.

Merged, thanks!


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
