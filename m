Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:03:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEED02147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tP5qfM8v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="m6swCk36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEED02147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3f0e8PyBL/Fu3XcTA7mn91sgFx3jHJVZp4dGxEIW+ec=; b=tP5qfM8vH2yWaP
	q+cfPM/ds8esQ4msxW191t0BR5Xs9iQzcuQ2ZuLdOCTb/PlNTOgRkrStsd2OD21z2RKUZpRX2DMei
	iwIl1Fn8+Dy8oon4O+swApKJ6JAt8MJMkmsztuwMiAXmWRlPS7N3OGZrAT97pSTt4USKMFNa3IsM4
	z9azxy94x/kePjyN7r9t9dtQAM8pU8xghz0DCmpadPjz5o4Av+edO1rLjZytCjEgkJNzufol1GdC+
	317pbAD163sJvdB2Y3qd3y7LiUe323xGUg7curl3bgUXg5sqscJq0tTDnvBmT4ib1Ozx9U11VD6wV
	srpsfJucVwU7NIupVCrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvheH-0005Ee-H0; Mon, 18 Feb 2019 12:03:49 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhdz-0004y1-Cu
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:03:35 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id 6BC92442413;
 Mon, 18 Feb 2019 13:03:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 6BC92442413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1550491405; bh=NHyAJNNRZzbcFh5jS7gCKYWKSyx3RunQKqMFjAX51uE=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=m6swCk36c3nynSaJfARrF6ABO08hiFmQbMKQuQDl4dFefhjTEbgQpjGvRYywme3Av
 GkOweyR0JQ6Aw4qFAVnEWsjL4j6F+NHB9JWOAAS+P6xohqtJLvfwJd0PTMLHeeerH3
 qU9NZVEq18k7l3FtDmgTaMFb6z8Kf0bg7D62vi5w=
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
Date: Mon, 18 Feb 2019 13:03:25 +0100
In-Reply-To: <CAK8P3a1Y2kLeDYKGMGpuLk8rxUxFwuPvjMRoLj-c2a8Bnwi56w@mail.gmail.com>
 (Arnd Bergmann's message of "Mon, 18 Feb 2019 10:40:47 +0100")
Message-ID: <m3bm39uwvm.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 135835 [Feb 18 2019]
X-KLMS-AntiSpam-Version: 5.8.6.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 234 234
 6084fb9491110ca2901942eb14874f7e6341a62a, {Tracking_DKIM, one},
 {Tracking_marketers, sender}, {Tracking_ sender_matches_from},
 {Tracking_subj_double_letters}, Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2019/02/15 09:48:34
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2019/02/18 05:54:00 #9583832
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_040332_051735_D6BCD846 
X-CRM114-Status: GOOD (  10.54  )
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

> I found a document that explains some of the more obscure details
> of this chip (among a lot of the general concepts), in particular how
> you can configure memory regions as either BE, LE-data-coherent or
> LE-address-coherent, and the byte swap on PCI depending on that:

There is also a problem with certain devices (certain old US Robotics
access servers?) using IXP425 rev. A0. Those first chips don't have the
LE data coherent mode.
We (= the official Linux kernel) don't use LE data coherent mode at all,
though I have had a patch (not very clean) which could do that.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
