Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C98BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DA22147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MCfAWDK4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="dkZUo1i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DA22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AKFm6memWbOHUzg/licL5wsu4ZksNR6vRxcGN26ML+0=; b=MCfAWDK4UDSozw
	ZvplrhAKHgAELziFNRamPqyV2vXfqf+brcY3SGfbbefvI9lw0FARybAHgSYL2R3nhyys8T9Cvq1kX
	IwHWH2Tu7faOpvnZkGqirH6HGR0WG3nx8zP+epfaDLINAima1rjzoSWUJAsAii/1t9w8v3PTOqRz2
	+snovma80tOEipLSBD4TOXcN4152rFzk1bCSe1qKD6YF5Xf2UnMugXI+dvcy3vequkKrQxBbmvwJX
	w4LDGjJcm+PIaRBt8/vq/qG6wANaXUCn7ZgQ9BercjWW9zYDj9obcjUhzyaV+b0cVi3qfRDTkL591
	UpAtMT4l2QKGaV9JFxqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwMPo-0007pO-Qp; Wed, 20 Feb 2019 07:35:36 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwMPk-0007p5-2z
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 07:35:35 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id DB743442422;
 Wed, 20 Feb 2019 08:35:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl DB743442422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1550648122; bh=VgylDj26s2on8dTmunX0Lq1xzQCdLIWL7rsFSmzoqLY=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=dkZUo1i1BFkbeuXUgtkuoskw2bkfcRlZF6KRWkRYznAou54o8eIRsaIHNbAx6IpW9
 IOFDClPHh6QSlwQ4yQQSXfimdcyuWII1T+IOiXkSQW2b0xwJYtUpAk915le2u+FI4B
 HINA7aE9B67Dxk9yZhOoFi8b1/4v6seTWKsc09sg=
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org>
 <m3k1hxvan4.fsf@t19.piap.pl>
 <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
 <CAK8P3a1Y2kLeDYKGMGpuLk8rxUxFwuPvjMRoLj-c2a8Bnwi56w@mail.gmail.com>
 <m3bm39uwvm.fsf@t19.piap.pl>
 <CAK8P3a0iubKdPrTO9ZxM+=0c3H8djpBw11KY-SO0Ai1Zgx3zHg@mail.gmail.com>
 <m37edwuv8m.fsf@t19.piap.pl>
 <CAK8P3a10daNVCMOSKcLTG=0-YkK4sQ0p3Uu-wM3xM5TEimUzkQ@mail.gmail.com>
Date: Wed, 20 Feb 2019 08:35:21 +0100
In-Reply-To: <CAK8P3a10daNVCMOSKcLTG=0-YkK4sQ0p3Uu-wM3xM5TEimUzkQ@mail.gmail.com>
 (Arnd Bergmann's message of "Tue, 19 Feb 2019 10:46:47 +0100")
Message-ID: <m3y36aud3a.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 135928 [Feb 20 2019]
X-KLMS-AntiSpam-Version: 5.8.6.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 234 234
 6084fb9491110ca2901942eb14874f7e6341a62a, {Tracking_DKIM, one},
 {Tracking_marketers, sender}, {Tracking_ sender_matches_from},
 {Tracking_subj_double_letters}, {Tracking_text_let_digits},
 Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2019/02/19 15:08:36
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2019/02/20 02:30:00 #9532575
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_233532_657182_C7973977 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>,
 Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> - the MMIO workarounds don't really work for a VGA card
>   in general since you cannot map the frame buffer into user
>   space, so the application of that is still a bit limited. I suspect
>   you would have had the same problem with the existing
>   ixp4xx code as well, depending on how the driver implements
>   user space graphics.

Right. Now I remember I put the VGA FB in the first 64 MB of PCI address
space (this means it was a 64 MB VGA, and that I could actually do
direct and indirect accesses at the same time). The rest of PCI address
space was used indirectly for (I guess) VGA registers and other hardware
(SATA controller and similar stuff - nothing which would require mapped
PCI memory).

The PCI bus mastering limitation was far worse - there are boards with
128 and 256 MB (maximum possible on IXP42x) of RAM and double SKB
buffering with e.g. dual gigabit Ethernet wasn't nice. I ended up with
a hack which allocated network buffers from the first 64 MB of RAM only.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
