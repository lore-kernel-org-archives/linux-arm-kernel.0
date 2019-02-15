Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:39:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24FE21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6QKsBSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24FE21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tRfNo+XKl4C1i3oj1QaAN06f3cRSLe3OhWB6wVgclWM=; b=O6QKsBSMyb1yHl
	GkQkJjLcpE3B7Ie3ycu0AYk7Mw+g/FKllMOF3xWLDaUeNWc1/lZTQJWXZck7YMxa7CqN4m9Y3pcu6
	nuY1M5ctzHTJbWgoGM/Ge0jgsxND2MfVGaf3z73eg1QK+tkBVpsZ7U0cIu2Can51sMWGFvTd2o41r
	+3cS/gN7A2hh8Gv3fLxHCddaNc6BcBYVGDhYPit4lqMVoXwvs9R5UJCaIXWMThVXfGmKyQ5EeN46m
	PWIZpTXKIh9HG9WEug9SX1W7FYMM8JmROtRvzUeOKbz5nLMIwKmnm9mpcTU/lhf/kWkV4q0QrDdZ3
	uP5tyxg6DAc4+2sZwzfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufZv-0005XX-JS; Fri, 15 Feb 2019 15:39:03 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufZs-0005X0-B7; Fri, 15 Feb 2019 15:39:01 +0000
Received: by mail-qt1-f195.google.com with SMTP id b8so11260080qtr.9;
 Fri, 15 Feb 2019 07:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jwSUwuZx+nhQNaIaI2pM52XDpBQj/dl2cccqy9n2h1g=;
 b=je726AR9GwtrZP4ZyGu53F6LE4I6w68SvkxU5CrjcvtI23fk3EnQf+Co87GmppIss8
 LINv8e2WJtrJjYbqPeqw2T3chGGgwOPTWw/rPC9sABK12M/iMuXqaVxpV0hdXUiRlIsp
 GFMzhQj15O0p1/fT0b+388zwop8lk4hgGpZ8BDZUdAnoaJXgEK6mG9JD5ROMsjdRLXDO
 /Wt4Xl1jIDfULD96EJoCPC83bOrVpUpjwe5ulrQekoD+zOW+0WM1zNFlVSVe5qqI+eVk
 1f/xHxCI13Mr9fH5mGhv3/wVZIJpWHrB5TKXciM0fUdpKzjcs0tZdmWFG4N9rbSot+I0
 QuBw==
X-Gm-Message-State: AHQUAubkHY16UvwkCz9h5A+yvsqlLXKbOdWmT8kEGNFiyegFoaXK7ORj
 bRscvqMKm7UaXJnNqNvMPcP3uuzqZGnP1x2iK7s+NyKU
X-Google-Smtp-Source: AHgI3IZfLUmpnmWytjABctjfCDWA6ZERNqV58HCHOxnlyEbMwnxXUsoU46xQA2EUXvV5wxUt/mwGPsnddyJv68eFaNk=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7724142qtm.96.1550245139422;
 Fri, 15 Feb 2019 07:38:59 -0800 (PST)
MIME-Version: 1.0
References: <2570520.8EeqtpO5V7@phil> <1744093.FyxTZ0jN5f@phil>
 <CAK8P3a2drxVzNgsKcM2ii62+NsVmsCiOKGirQeby0kOFRQnX_g@mail.gmail.com>
In-Reply-To: <CAK8P3a2drxVzNgsKcM2ii62+NsVmsCiOKGirQeby0kOFRQnX_g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:38:43 +0100
Message-ID: <CAK8P3a2UkmVOJDddi3rC=GFcBSeqciNuYaT8s3i5E4bOwJE1Bg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Rockchip dts64 updates for 5.1
To: Heiko Stuebner <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_073900_383737_42474125 
X-CRM114-Status: UNSURE (   7.90  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 2:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 1, 2019 at 12:24 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > New boards are the Rock Pi 4, NanoPC-T4 and NanoPi-M4, with the last
> > two being part of a family and sharing bigger parts of the devicetree.
> > rk3328 got sound-related upgrades and a wider patch drops mmc display-wp
> > fields from nodes which shouldn't use it.
>
> Pulled into arm/dt, nice to see the additional rk3399 boards. Thanks,

I still get some warnings during 'make dtb', all specific to rk3399:

../arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts:25.9-29.5: Warning
(graph_port): /edp-panel/ports: graph port node name should be 'port'
../arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:46.9-50.5:
Warning (graph_port): /edp-panel/ports: graph port node name should be
'port'
../arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts:94.9-98.5:
Warning (graph_port): /edp-panel/ports: graph port node name should be
'port'

Can you see what is going on and send a fix?

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
