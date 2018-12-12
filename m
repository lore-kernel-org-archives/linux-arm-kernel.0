Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F10EC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270F420672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHiLeZHl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vSYeKoME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270F420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xo1ntsq8D8YCDvL8/L34U3xt2DkBx4GPH//JE8iLhjc=; b=sHiLeZHlIqF3vv
	fHc+HY1IOgxIfyu3b/xsTJjV76NZ6bOa/w+R2nR/fE2M/h0wQoQLdUgNaXllFoAdvWMO2zepd41is
	0OdWjrXz9SJ3tYlSI1uuEfBumraYEMAdDEiGbeQx9WtAxD1hxGZfz+w9rfDxmclDEONxN4HTLxnSK
	5NT1DPKX14fz7k1aTXI4/PC3I9O2QkD8oXDVgiGOmqNfH7fLYze79z9eShPMy1slIwYxPQ4fTXve6
	zCI1OxTntSbRKaQJkholnHAapWSCJTDPnd0Fy9XKAi9CV5aHNaZCGttXE+kq5X14Gv70Nke+ZtU3Y
	E/0w6Mci7a0QYcnx9tIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXD0c-0001YR-Bi; Wed, 12 Dec 2018 22:29:38 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXCom-0007Zj-Ux
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 22:17:27 +0000
Received: by mail-lf1-x143.google.com with SMTP id p86so7700lfg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NTgwZDxEtYzfr3woGH/MPYE4jafl6MSilZUjalYjpO0=;
 b=vSYeKoMEiZ5Ho/BKG8dUIHWcMj+06Rp7G9eWaSVW584nmt+ILieZ3p2vgJJSM1tjC/
 tKZmQ9/E2hiIeb2sE2bA+KscaxTRGbYChIT8Gd4rtc89ur5IRbfRc2mgXrgh6MVBXdH+
 e5uqsY+CzkZStir9opg0grcQ+cmk0/72BWnw/zdcTqDosex/Lc7fTqmbMQw2GjscOeUM
 TEbx08Stjt6qvDJzVhbv5mA5/zBVcbh1UdzgcuX1ZqD4ZzskVox3d4lqXOrNSA784ueS
 plXh/N7yAcSX3BXETY09/86YuJtEKNQV1sHng+58ZK1DsTP2+R6HKLUry2cnMq7DZEa+
 bPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NTgwZDxEtYzfr3woGH/MPYE4jafl6MSilZUjalYjpO0=;
 b=GZF6jpD9C4lxNrjKHbcRFfbE5dDVNVBm8K9gIyKCFRfavom135jqOlPcW1+codfsyv
 QnntJJd/Lx8OkxpykYKtD0YPGWP3P2i8W5sSdTVx/dU9Gw5L/44VACjH1ln7gN0HpWLX
 E3MHEqlXTFx6egvAKao49VDpBF0GDZkdtVp/xr4lDmy+vAq7KoiUE80yo0sdSMZTfHSl
 VIrhAGxspuNfVjAwuedbSaWzZsutRyaop9khy7e57VnHhuB6QYE9TtubNx4Xw16uMVxn
 DtwyUl7GqAd/lMAVhdVL5F1eg1QFy8V7bHS/LULnncgDcZShaM0q+2Bev8U3daR00RVo
 0GcA==
X-Gm-Message-State: AA+aEWbmRttt9zvoQLDfOeSP4aFag7g7fxrUC6mFoMuojqT6wUcaku5D
 pIwZjiVb5qwgWCICKYWoYK2sug==
X-Google-Smtp-Source: AFSGD/UxnUle9CfHwQWfcL4R/PwBYjLzMEa7WQvPO3XMb01N16KDd36bLXnunRMCyPRKKaU76/oN6w==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr12019667lfa.1.1544653033306; 
 Wed, 12 Dec 2018 14:17:13 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id 11-v6sm5142ljv.1.2018.12.12.14.17.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 14:17:12 -0800 (PST)
Date: Wed, 12 Dec 2018 14:05:30 -0800
From: Olof Johansson <olof@lixom.net>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Message-ID: <20181212220530.m2o3njrvjcja5pfu@localhost>
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210220926.GF6707@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210220926.GF6707@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_141725_937352_54BC0738 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@kernel.org>,
 linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, arm@kernel.org,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 02:09:26PM -0800, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [181210 21:59]:
> > WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
> > The function am43xx_suspend_init() references
> > the function __init am43xx_map_scu().
> > This is often because am43xx_suspend_init lacks a __init
> > annotation or the annotation of am43xx_map_scu is wrong.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
