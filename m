Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCBAC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F61820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+buKUTt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TCdIBrOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F61820811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LFO+22KqZlvKPO5iSmf9Mp0vffDL7zhNmNUEnF5TeEA=; b=e+buKUTtZkwsHD
	rGSn42wqWr7oDTmL32FF1yleo2F9a24A46jF3fsAXFRflVkYXutAoB1Z3Squ9DWSxWl36mgYHF/Xe
	ZkK2XHjiUqpjhNODGnZEjymE6BAIGfxOeIRYfARJORHPGWbWFDKZy774YvyrWYNRRieOWQKQJG+On
	TJ758PdpsIkGJPtK1a9hvm+O7gYnAASaESJjxoju6b5DdzUp+r+O9RGKXcm3SCQcdsp93Ll/7oSKX
	yMr2g8W12JTm8nH9Xdi8l0KfNQBb9T+JiDt1g0r96XvJ+uX/ZN2hqGapyOvD4pbZbmkRXmA08BA05
	3/Ok3pO5EHRIWLZ1cGiw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBt2-0000X0-8T; Wed, 12 Dec 2018 21:17:44 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBqg-0005Rx-Nl
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:15:21 +0000
Received: by mail-lj1-x242.google.com with SMTP id g11-v6so17596728ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 13:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iVcaQ1GyN4FndFZq9RpBAWgDU7+sqQQkc/XiJFhjGWc=;
 b=TCdIBrOoNOWyWqm/MQcPDLChgSWRx+hK86zf9Lkb87B0NyYRyYfDWk6Twn7sS+Cgm0
 fumEW0tySyzRpC/4MucTJrkFdZhuVF6rCP1SUhCbLiY5pRzNFzRwapfhQDGpRNA88e3J
 Sbwkx67F2VXxCyBl6nA5JdVtIRFNyXEaOgecobGusk/McoEEtPFnMN9b5UOgcLdpIIoT
 4piaouzJwMcEUIXUJ4IyRida/EA0cfGyEfARQxB9xVy0q58wPvx3s9wiU1bnPX2TdfNy
 NubAn8+qRU55PtqP92C6JVl11ZQLpMU2kqO1cCJmc04ZiitW3VCwVJaIMRdcCIG1h/LF
 7U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iVcaQ1GyN4FndFZq9RpBAWgDU7+sqQQkc/XiJFhjGWc=;
 b=Pc+G6m55U6PhDMHCrWFSVQOIpZa9W/g2aCI13R8nJf4f8VyO32z+CFO3IGIV9I6GMM
 BxLC4NpGTqrkMS+Wcw+FFe58pOeB+JgLTlkjQoiOw5CirOlyyaU5wgnQtPVWCtk7ls8d
 vmWhAPSrTmegrbgZBJ3KTq96mEQ9BVeKb9rSxZt5JEklqR7ZUwiyB+hqU5+LzRnbaRzr
 2XJj+vkNbeyysxYTqQ8FyiYOfcevnupCI+/hKOT9liyhXJodYc9uq34roy2FLXOT8F3V
 IzVdtjep9hi4YYuy2orO2Zo0nRwmLwqqbvCCtjamF/aiDYIZ4fkunH4cgnXFtHRYsKyI
 n65g==
X-Gm-Message-State: AA+aEWa11UVpgGxns72JFrpDAD4cf4V/meiE1sYFnN4A2cUdKETGt4cf
 JhWjVDWVxnxnf7KoXyeX/3E36A==
X-Google-Smtp-Source: AFSGD/WHdwf3Zxj49gSBPumAn8zpIP4Hyv1Gca9XF2GYI5ebWauQAyK6MDCeCYrpOY/qGzizA36UoA==
X-Received: by 2002:a2e:3803:: with SMTP id
 f3-v6mr3182954lja.169.1544649309117; 
 Wed, 12 Dec 2018 13:15:09 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id x29-v6sm3464264ljb.97.2018.12.12.13.15.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 13:15:07 -0800 (PST)
Date: Wed, 12 Dec 2018 13:01:55 -0800
From: Olof Johansson <olof@lixom.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [GIT PULL RESEND] ARM: dts: uniphier: UniPhier DT updates for
 v4.21/v5.0
Message-ID: <20181212210155.wgpix34vo56rwoxl@localhost>
References: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131518_910608_B9591C89 
X-CRM114-Status: GOOD (  17.01  )
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
Cc: arm-soc <arm@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 01:37:12AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Please pull UniPhier DT updates for the v4.21/v5.0 MW.
> 
> 
> Thanks!
> 
> 
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt-v4.21
> 
> for you to fetch changes up to 5fd98eb7e8ce0f7d7e4f3c138e5b46fc98389804:
> 
>   ARM: dts: uniphier: add MIO DMAC nodes (2018-12-11 01:31:17 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.21
> 
> - Add bindings for all SoCs/boards of UniPhier platform
> 
> - Move binding docs to socionext directory
> 
> - Add all CPUs in cooling maps
> 
> - Add MIO DMAC nodes

Merged, thanks!


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
