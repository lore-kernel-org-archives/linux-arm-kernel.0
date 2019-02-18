Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:35:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBC42184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C3oVxJTl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="OESjD6uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBC42184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qm5GgE5NwwsUPuvBkHKntBnsUh7gbzNSIpy1ChvQpeA=; b=C3oVxJTl7S8cYC
	wmwDRYVWmpT8ypurFJlRFZfeR2+9QFH53VC7WkYz23IQ/RhCxudKZwUq5ZnUmi4+lzQgyD5y/z7R6
	U8EAsnQU9oBseZoBBm+KxtmCiPlAO3pG1l2jg0PxvKEbluQ3inpP6LSJmWnooeBMtauZsfg1mu/hv
	BntffdLXDBtJOfmwIBpeeDgVvN+lXmsgc4RkqU1rVoYf5D88rIyUBuq+J6An7tP5Vb+Oj44Qi7KXY
	1YaA60dtf7NHQvkIt5/OAzHehJO5miUhKG42vRBVn1g4B9Kdb+4mS+fuCctZmlRvcHzSw1VZO3v5i
	MFBnLHqpsBQ0UcDEmQHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvdST-0005Xh-3c; Mon, 18 Feb 2019 07:35:21 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvdSO-0005MN-Nt
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 07:35:18 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id B132B44044D;
 Mon, 18 Feb 2019 08:35:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl B132B44044D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1550475313; bh=zuQc4GLVdEaW9AJnvm+XBIEAbT1R7ZWiVT6GZ6KrY4Y=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=OESjD6uH88Gui6RYgT+ssEYLAnJQrb/eQ5OCpXeHXO880HaE4qyxKz8xomU3DYmFh
 smMGfGBWrF+OwE+OVkqaX8gjL4IZMwhxdJEK6qx36zpjoWull1Rb9XwCALWt9ENbBu
 DraMcARHirSRIZxi3SzHi/T0+J/99swWU/L1EzI0=
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org>
 <m3k1hxvan4.fsf@t19.piap.pl>
 <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
Date: Mon, 18 Feb 2019 08:35:13 +0100
In-Reply-To: <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
 (Linus Walleij's message of "Mon, 18 Feb 2019 08:16:39 +0100")
Message-ID: <m3ftslv9am.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 135814 [Feb 18 2019]
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
X-KLMS-AntiPhishing: Clean, 2019/02/15 09:48:34
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2019/02/18 02:09:00 #9581995
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_233517_116536_37CDA39E 
X-CRM114-Status: UNSURE (   8.78  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> IIUC PCI should always be LE and readl() writel() always read/write
> in LE. But I see PCI on the IXP4xx is a special history so I am going to
> experience it in all its glory now that I start looking at it.

Oh yeah. BTW obviously readl() and writel() do the right thing on IXP4xx
(otherwise the drivers wouldn't work) and the byte operations work as
well. That's why the internal stuff uses __raw_{readl,writel}() and
the PCI uses readl/writel() and so on (which corrects for endianness
on BE).
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
