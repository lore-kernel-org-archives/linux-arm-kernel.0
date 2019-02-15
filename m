Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E39DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:02:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D348206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqcjwdEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D348206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ub3W8wA99EF76dwOvZH0sWCwB+i5ISZzUNE45YFhuCY=; b=iqcjwdEakc71q6
	TDKq+BFOPlKniAfFLLcgzG1EXEu/d2nz7zyNjkIVxsJHaYoynUF72aP4Pnp7SM1psg8nvmtDO1vpN
	DK5OxzzLzg4+9h3COFCwju+YQUpf08hiPIarNvZJXFZaDTASHWojaYluFXMHpyJnD83pF7CXuB9SY
	beIg0lkKKbKkrMcnZeHSCxyZuNg/LTheYEAtzQ2Z9Xisn9fRqs5yssTDMeiAswkqXKVkeVo5LWPZC
	d3OVje5OgI79Sr/JoCOlDHFzfDGgLmrV3kvEu/ejdvRkOYA1KwPBFKCT2yzOmfpiHsTDNZ6HPM9At
	tU8jcXx93UkMCIBD/wQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guf0F-0004sH-PH; Fri, 15 Feb 2019 15:02:11 +0000
Received: from mail-qt1-f181.google.com ([209.85.160.181])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guf0D-0004rz-2j
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:02:10 +0000
Received: by mail-qt1-f181.google.com with SMTP id w4so11211725qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iFyYV24fxJCjF9v6qXt8wOU+q01IZLoouXybQqhaZ44=;
 b=bIgisgRgZV2JXSVvaE+PZD/eos7iFhDmuCvuVVi1QarqruL7+N3m6oO+m9AhnwBuj+
 5fF94xmG0WgNPHVr20k34Ek6aS7Ze/SgR/qcUgubjnk/Gr15549m9pgQ2kmeoQMSbJGa
 GdsQW+h8au84WDD5AQ7QLn/xI55+Zt/8SBzKX+pJGLYnV1emKm6YJfsOL15Ftj+hZQtJ
 5Z2k5KpD4zmIAWAFoJbsG0hrOrrUAsaZG9LTVGYg9T4qbtqthOucF4cdrUymRLT68AZ9
 mxf+YUlmxwXScmkL1eh64Jqsv8w2vE8Dt5ak+QcMOQHM57KrZoC4sXmufFI614U7o/59
 VdnA==
X-Gm-Message-State: AHQUAubTHjvfqLI8L3uJfHAKu/KM5kHG1FtDZx3Mm3mHfngW4ygINZT0
 NJIvDTVsd4xDfeAUvauKUyK3Bvzw1+gc89uQ67QV5w==
X-Google-Smtp-Source: AHgI3IZWSpTjWDA6suNNcaf0Sz7fqbtcEjQa+1opKP1FZ+6aTShNxVQZEmrV6bOaVWAtXr8wyE2NDyg5eJHBodji1/4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7754744qtl.343.1550242928239; 
 Fri, 15 Feb 2019 07:02:08 -0800 (PST)
MIME-Version: 1.0
References: <87k1ia561h.fsf@FE-laptop>
In-Reply-To: <87k1ia561h.fsf@FE-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:01:51 +0100
Message-ID: <CAK8P3a0a3Y262Q1bn35D1axTM-Kv_2SoOThK5n+fPiLP71Ym+g@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: mvebu: dt for v5.1 (#1)
To: Gregory CLEMENT <gregory.clement@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_070209_120562_2E53EA62 
X-CRM114-Status: UNSURE (   7.34  )
X-CRM114-Notice: Please train this message.
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 10:22 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
> mvebu dt for 5.1 (part 1)
>
>  - Cleanup marvell,dsa properties

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
