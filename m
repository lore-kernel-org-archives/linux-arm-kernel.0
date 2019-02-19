Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AC1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D734921902
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L47INCwa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="fdZErFL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D734921902
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQ94WX5UV36IksQEI3dltbXa+qaNSCuqt8W4b1lEqY0=; b=L47INCwadr/WE8
	ryUKNQwhdsvDxozBTpPAu+UhEMhLLp3oY4nE7I4CAgVJslfdWqoyGqyazuIJHAE47lQKKwix4x8L9
	rxi8K4Te7I7yz+Ru0bRXA/w2IKmyIwbEIvwriyPEwhPN29Xf7qYKXTyixqrkwWX/o0XJJ+Z9dOuSk
	DwAZ5HdHENzcGx8R4mtPd/yuwcBe9F/Tpa26xToI05QP80Eba5553XvWRjVpqbT8/2BO7Py6esnps
	Mt6VJXOlNQ2ZynWNl8UP26Jbjd3d1ikLMGoQfZ17j7wGtN6+2/2iXLMEbt83LhK2z80BB+gnymzdS
	4qvAXowBr3MuqMNYaV6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzFN-0008LV-5P; Tue, 19 Feb 2019 06:51:17 +0000
Received: from ni.piap.pl ([195.187.100.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzFJ-0008Kj-2f
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 06:51:15 +0000
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ni.piap.pl (Postfix) with ESMTPSA id EC85C440446;
 Tue, 19 Feb 2019 07:51:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl EC85C440446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
 t=1550559067; bh=vrCBjwobIdl3ZcLtS4XMgk4qNLUXLgi4vqQQiqpjo44=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=fdZErFL1kEGT6vF8DyPYKat9FwRbHpf8oUOGEEaqd/36BE+b+b72zZTQSAFfsJqE6
 WdDqhjVmWTGzaxIDJThcnCZvAnMSeP5yDXWoAiCuYfJtceRr7E5h8zVZ/hmyZyxv3I
 vMp8kN1XBatmRqr2HjGEjEZ5IM4OoD82TLExaKtk=
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
Date: Tue, 19 Feb 2019 07:51:05 +0100
In-Reply-To: <CAK8P3a0iubKdPrTO9ZxM+=0c3H8djpBw11KY-SO0Ai1Zgx3zHg@mail.gmail.com>
 (Arnd Bergmann's message of "Mon, 18 Feb 2019 13:44:19 +0100")
Message-ID: <m37edwuv8m.fsf@t19.piap.pl>
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 135866 [Feb 19 2019]
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
X-KLMS-AntiPhishing: Clean, 2019/02/18 15:22:35
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server,
 version 8.0.1.721, bases: 2019/02/19 00:01:00 #9558000
X-KLMS-AntiVirus-Status: Clean, skipped
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_225113_623420_2C0560B1 
X-CRM114-Status: GOOD (  12.76  )
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

> - I have a vague memory that only specific revisions actually require
>   the PCI indirect mode. Is it the same chip revision A0 of IXP425
>   that requires both pci-indirect and address-coherent mode, or are
>   there other combinations?

IIRC, all chips support indirect PCI. Perhaps there are some changes
about LE mode on the PCI, but that's it.

Most boards don't need indirect PCI. It's only needed when there is more
than 64 MB of PCI address space to be used - IIRC IXP4xx have 4 direct
PCI memory access windows, and each is 16 MB in size.
I remember I needed indirect PCI for use with a (SiS?) VGA card, it had
(I guess) 128 MB of RAM. I think indirect PCI means the memory can't be
really mapped, it can only be accessed using readl() and friends (which
are then converted into register accesses resulting in the actual MMIO).
Even with indirect PCI, 64 MB can be accessed directly (though I think
we don't support it).

This is different from the bus mastering access to the main RAM - I
think only the first 64 MB can be used for PCI BM DMA. This limitation,
IIRC, doesn't apply to internal devices (Ethernet etc).

> - How much would it hurt actual users to drop support for both
>   features? I.e. do we know of anyone using the affected chips
>   (and still doing updates), or are the remaining ixp4xx systems
>   generally using the later chip revision?

Most chips are B0+, though there are (were) certain A0 platforms.
I don't have any idea about their current use.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
