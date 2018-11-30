Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EAFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5EC206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XPTLyLLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5EC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L5nma+NVaH99U75yB0JYWk0ASGI2TvsAJruVi7wzl5k=; b=XPTLyLLs0FdZg2
	f5HW4f6IO0hEU9L6QrGfIQo0z1BFQfUMBOpo805KbJ4FdrUwwoquRYS8oo021TjhQAbWLrkVsNhQl
	YirKpCawVj60zsCiP1LmoMfpZBBl/zitQQ39+VSN6xo7/CDHGM92pLgAt3GSqABsg6MPMwPukQsMe
	eIcaEAQaEw3KjVhMiBuvVVAhmPEgC82C/AOgOAEkvPasyPNR5oASldd2XXpgYEhY5YX0tasM8CpY9
	MdIhuzcXeSq8bmlCsMgHAcAfmp1c3FeLSFmWuqa9fJOtbKBW0zpWVojIc0iBgItnZh9ng/gQX/94+
	RBuSdoFuSbUyid6jLwKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSmSt-0002hk-EW; Fri, 30 Nov 2018 17:20:31 +0000
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSmRK-0008Ce-Km
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:19:01 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d60 with ME
 id 6HJf1z00N0nnJME03HJg6z; Fri, 30 Nov 2018 18:18:41 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 30 Nov 2018 18:18:41 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 6/8] ARM: pxa/lubbock: switch PCMCIA to MAX1600 library
References: <E1gRxlD-0001vC-E0@rmk-PC.armlinux.org.uk>
X-URL: http://belgarath.falguerolles.org/
Date: Fri, 30 Nov 2018 18:18:39 +0100
In-Reply-To: <E1gRxlD-0001vC-E0@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Wed, 28 Nov 2018 11:12:03 +0000")
Message-ID: <87y39axz4g.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_091855_926224_8D329032 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Russell King <rmk+kernel@armlinux.org.uk> writes:

> As Lubbock now provides GPIOs via gpiolib for controlling the socket
> power, we can use the MAX1600 driver.  Switch Lubbock to use this
> driver, which simplifies the code.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

The test is only a read of the CIS of a PCCard in the PCMCIA slot, not actual
access to the storage.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
