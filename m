Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B41C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D9820867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dEc9ErJv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sfTlrWXh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="YLAMpuqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D9820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sF0R6ZPh6+nNtdv4dzbcnlM7AyWPbKtVDenHUTZVztw=; b=dEc9ErJvvk9Zx+
	HECxse6uYtznTT0YmkVorgO2mLKFhpx01szHCStAgDt76EkTb11gd6BC00PSuZnaOJ1cmmSuzJKb2
	UDVH2jgF1SgNBsGneCd0nGvHYMzBmPSgD1atPreUxUT4Y6dXj7rnVq8BRk6CpY3LdXwfALR3erBsA
	rLEEUKYkVsYKg+FktSgqP47AhbgUAJoqomxSwzYCKTuuTonAE0zn1Je93cSpxZCbPPBB3YLVWlEcb
	9X0yuh0cZ4pggIrXThIZntNih55uxUWftrLmwzOIc11PTvywYEbF3/43gOYpwkdACLCUs5egAutxs
	JGTWdk6QmyZjCLZvkHHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSshz-0006b2-Oa; Sat, 01 Dec 2018 00:00:31 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsfB-0002jl-MK
 for linux-arm-kernel@bombadil.infradead.org; Fri, 30 Nov 2018 23:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lQKM5yXiGSf4lMQEmO7w25LIcorfD4s+FFvHlS1HwgQ=; b=sfTlrWXhWVBX0etYEdaRfozS4
 NpD+K1OSsCR40gtaCMm42v7oyHBj57P9Gyk2C/1ozV3A6/2PXdFLTpicX9/4kzsWy3GZ6WZsmD3n1
 oX84OTGbdtGa8uvjBMZsIS3tQQ83t2SVoXbiM9uYaaVpniAxZddZhb6uWzDUczBngA9hWY6ulowei
 aL+ZFuYksTjG9ywdg6UazSu0CbrSc2Rxisxt5/ah1nTOMTmAcFFnNuwjnv/8jL3DqKHamlPy+epAk
 kcmB/E3FPsfN4MG3822XLN2LwCu6M4y897zu/gMHsUCj+V0bgYIiOR9qUBAk7IjizN37gURAWrrCJ
 53+TlWnKg==;
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSsf8-00089m-Q8
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 23:57:35 +0000
Received: by mail-lf1-x141.google.com with SMTP id l10so5312445lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 15:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lQKM5yXiGSf4lMQEmO7w25LIcorfD4s+FFvHlS1HwgQ=;
 b=YLAMpuqtisgajgnx/KnAPjK/ruX8082ySsAlOh/wzYZkQbJNl6WclFMEEUAtpizVtM
 STD7r64ZlEqNXoCmYJcWOl65yKgBlMtl8hExA7kmfSGrERFkltdtaGr5Z/zRPp6dCLIc
 gsjKya+cpElK2W4D/NIKBFKbDKkwTRK4GfDDy4q1tnbBppW2HOVcHkGi0RRoDTz9MYMt
 al59C4FM/nxVXoSLBKkOX1nJtOsFN+YuRo1hgjnaxYVxQC4Grj4mWqZbE3G6GxvJeNjg
 EXAg5cP9FmX+zS123YRaLrCXDSBou5vYvX3dCA/1DHW5hd1JMOc5OUpn8n/ttTSsN2/q
 i3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lQKM5yXiGSf4lMQEmO7w25LIcorfD4s+FFvHlS1HwgQ=;
 b=TYD+17NdHdAiI+PoFUv21NRWce1XnGJG0Yq9QhJmwPMefh3P7hjNImY/svFqvoUGRj
 iA1UFseG5rL9boh/2VNErHO0M8maUpHTG/yLJ2aRgiobn/Ov4aVi0eF1g8gdRsN1+Fa9
 DPYVKIu3bGm2dkj7Vhv8iZrkdDczcQAv0g7cDwDoV+icyZR3EbC6ZQX1Nnlp2KZubxnO
 wafTVDmy3bmoYu49Vd1PpPjpKXQ0T7Utn/VHTKfv1vU0yuKIYWHB0S+7Ge4BYT/BPOtN
 KwAehbkIBbUoVwPRkn2mMqad9dvEp1mt06lfkcgYhfXou5v2M8FdgObw/FQuyOiHryaX
 vWlw==
X-Gm-Message-State: AA+aEWaHEVdbuM31Sllm4oHEH/xqaEY/fJ8jihttlM4Ouuu1ciohZtRo
 emu9mi+Ywnf5aM9QJ616HUuYgw==
X-Google-Smtp-Source: AFSGD/XDvMIxsMADCdpnBXvY4qilKJNeiowM4OEi/H9HYtuWtlBRtWRG9iJq9Afd4Om9TX9AvuVZaA==
X-Received: by 2002:a19:d242:: with SMTP id j63mr5076300lfg.26.1543622239609; 
 Fri, 30 Nov 2018 15:57:19 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b17sm1054424lfc.21.2018.11.30.15.57.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 15:57:18 -0800 (PST)
Date: Fri, 30 Nov 2018 15:44:24 -0800
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/20] MMP platform fixes
Message-ID: <20181130234424.vx5y46wqvziywbk2@localhost>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_185734_864397_25390ECF 
X-CRM114-Status: GOOD (  26.41  )
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
Cc: Eric Miao <eric.y.miao@gmail.com>, quozl@laptop.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lkundrak@v3.sk,
 arm-soc <arm@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Nov 28, 2018 at 10:39:06PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 28, 2018 at 6:53 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > Hi,
> >
> > this series contains contains a bunch of MMP2 platform fixes.
> >
> > Previous spins of the patch set were sent out over the course of last
> > three months to the MMP platform maintainers, with Arnd and
> > linux-arm-kernel@lists.infradead.org on copy.
> >
> > Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> > seem to respond anymore. That's a shame, because the MMP2 support seems to
> > in need for some love. The DT/multiplatform kernels can't even boot without
> > 14/20, 15/20 and perhaps more.
> >
> > I'm wondering if this cat gen in via the arm-soc tree? Would it be
> > appropriate if I followed up with a MAINTAINERS update in that case?
> 
> Yes, sounds good to me. I looked through the series again, and
> found one patch that seems wrong to me. Everything else should
> just go in.

I've applied the DT patches and the ones that touch only arch/arm/mach-*.
There are a few driver patches here that should be reviewed/acked by the
corresponding maintainers as well, so I didn't apply most of them yet.

> > The patch set has been tested on an OLPC XO-1.75 laptop.
> 
> Excellent!

OOooh, I have one of those... somewhere.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
