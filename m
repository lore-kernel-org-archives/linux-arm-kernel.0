Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7FDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:13:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FC520673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEZ4N+SO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfcyVoUV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YR3+/Cpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FC520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V32pKeyhScu/adh5qYzQ4Cbl3RLGfTK/a5Wr3zbtD6U=; b=qEZ4N+SOTmM18/
	mPrTl2ymPnJti4fJRwPDICwB09gjIKMEAwp5vvl7aPRXAkMIH8iqcmjFIPT/UrFm/gct/3H+xCZAr
	YSk4hqe45L4D6mCAcmt+3ocNEws/JVnFSChd4o0TIfTcy8TAMIM8r0ViFF4TYpCdH3QnonG2A4JSB
	KmlFnxYgg53xi/MqnN1/E0KqxHiiGIwcAjQD1lyS1C3TgaRiE8MdoKhfqGQtLhYUau/OSxhB177Bc
	fu0JsdGsd2fEzpfAUiVhK+m9Zs8xEaLc4sqJZ3lmBm3jyffcNz8RteJs2O+a7sjTn6qqsjRaoXE2Z
	1kKPOOs569xhlxH0gnxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSsu4-0004oA-V2; Sat, 01 Dec 2018 00:13:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSstu-0004WB-DJ
 for linux-arm-kernel@bombadil.infradead.org; Sat, 01 Dec 2018 00:12:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W5t3HZoYLRFMDy2bY8gUWHcnmXAX0dJvgxyM8JSpx8w=; b=jfcyVoUVWeIYY7lon27V6EBLk
 Pop3Oq1JugIP5o+SbW3sb6sslGE1zZD1/IEWhUAAfuPkr9eQ7atOumfGawfXwBsukSq3KBVLvgS+x
 QLOUxF29CpHQ1MQpcQeoRCaRz2D9L0oZoP/AOX/bFWlKLqs7x+lJRik1yV7cg0QoH+E8yFGuI92Ye
 a2lsCJ+tStTetTKOqm9+zncNN1Aq7QeHnPgfkqS7fM/MWXNScEz3P4KLtYbc6h+284Lr3fSipB2jW
 8nRXsPuVAQeBUY8ViZQwjpqgjh0qIh/9SRgZCBHfWHXa3Gy1VImGY2bNVpDq2N9VuwepdTcBsF1Qn
 F61rWXz+g==;
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfG-00023n-I1
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:44 +0000
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so6471241ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=W5t3HZoYLRFMDy2bY8gUWHcnmXAX0dJvgxyM8JSpx8w=;
 b=YR3+/CpdK/J6OJgiZA0T/CiZqCr/6GW0jzHCb+rbRfh2uFv4gt7AhZHBavqxJQ9WNZ
 3CKK44ca9cV/XKokONM4C02xIYovmmfWIl3KBIbqpuOJ2CveNC0kD9jHZ0h2EOXCPSR7
 SW0Qgs+umfHkyP73OArIMZcfVVZQM8Qj/Zv+SspyF4TYDg5uc57my5JoP+wUsI1f+Whw
 +OH0L1aEfcjszrSTV70wL41T8I5q4mW8HREURZL1tFZRWF/oWIylxTWC5r9RVM/UXyHK
 EcGOChCoFUqiDxXvPnZ1GObe3qt0OSylvE50d+A6Tc38FBw4Tb6XfkBODqqAQi0/arIg
 HtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=W5t3HZoYLRFMDy2bY8gUWHcnmXAX0dJvgxyM8JSpx8w=;
 b=hEwHdvATNVdd4guq96yaqpUO2nu2RQ8SmQeLzti10AeIzEfRKdl5T9zaCSjmgY+vgE
 Xz+XxI1LBdx6TN2jFouXf9kMIl1MhCJ0uyQNh206h+17lqLFRIrQtH/pbABMHC9pcmYW
 pwA+AtOBsusR9cZcsUdxlzo7W4rTY/AFYSQXu1sjZkMHBQhFw4JAuGcTNgSdt8d2YxUH
 vlF5Gq+l5FoxSDyNR/sbRX4yaCO86j3BcwUliRIn5d+Mfm1eERYSwW0JZXCJQEEDj/KW
 LM80nvuFJE2x3L4egMMF6ZOyh3l8ab6UOgqLrr6Zwd5T2C5AW1rgdTBDbcclRiaf+xEE
 iObA==
X-Gm-Message-State: AA+aEWY6j/WOOcdZReqY/hCkKD8GzyJ5LguidBhdL6m+VvENXKt+Igo8
 IzHC3SlvPFxoZMjoyNXgf4PsayeG/ru9yw==
X-Google-Smtp-Source: AFSGD/VuZWop6H2jwdnuAGbF+xlRY++ZNkm/M65wjyM5P1uf4mWRsD7N537VROEoW7qYDKVxyN9xhQ==
X-Received: by 2002:a2e:4a19:: with SMTP id
 x25-v6mr4850961lja.19.1543622250250; 
 Fri, 30 Nov 2018 15:57:30 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id p19-v6sm1041676ljb.47.2018.11.30.15.57.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:29 -0800 (PST)
Date: Fri, 30 Nov 2018 15:51:07 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/4] soc changes for omaps for v4.21
Message-ID: <20181130235107.wvtp52bdbs33feky@localhost>
References: <pull-1543521343-338334@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pull-1543521343-338334@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_235742_597604_43C83E3D 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 11:57:40AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.21/soc-signed
> 
> for you to fetch changes up to b76455335447fa8b73ebc0ca768e46ee74fcd329:
> 
>   ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h> (2018-11-19 10:06:36 -0800)
> 
> ----------------------------------------------------------------
> SoC changes for omaps for v4.21 merge window
> 
> Few more non-critical section annotation fixes for Clang and
> remove obsolete timer header inclusion.
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: OMAP2+: timer: Remove obsolete inclusion of <asm/smp_twd.h>
> 
> Nathan Chancellor (2):
>       ARM: OMAP2+: hwmod: Fix some section annotations
>       ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
