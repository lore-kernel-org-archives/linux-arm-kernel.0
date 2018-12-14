Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17F6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:23:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB4A2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gig0Z3/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB4A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JkCFD8G6kZ00r07vU59w3sQYghWEwqHkgPUMuRzddks=; b=Gig0Z3/TFY3sah
	l2G7LFdmB2zkVnFvOeNzhaMfG4k/y1jyiFRhojCZayiuFsJFiXqoxbHp5H6eA3QujJZ9AS8r6RhBU
	cLIaIa0wWnSDAeyCBJSSV1zqd/RaEKw6gX64TUcbRn+ADZhCUAFGnlVIYF9qHQpsjoPR5pNJZTLzh
	TKkZxqKgC8yyRVRWd2ZzjqviCX43zq5IZ/A2YWFkleBDOwqYSv/CcXfTlJnh64XLrKA6+OHI6h3mF
	nsiRw7Nkq53gWQUIWsuOhnKFjsPpl0LFi2BXu3eSsnzvcSXlrWIpEte+Nrx+vYcIZT+cMKG8F4ptB
	tNIlzhEf8Xo0GGoWsKfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXuvX-0000VG-7P; Fri, 14 Dec 2018 21:23:19 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXuvT-0000Ux-UF
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 21:23:17 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id F075614E088C5;
 Fri, 14 Dec 2018 13:23:00 -0800 (PST)
Date: Fri, 14 Dec 2018 13:23:00 -0800 (PST)
Message-Id: <20181214.132300.832860946069084294.davem@davemloft.net>
To: arnd@arndb.de
Subject: Re: [PATCH] w90p910_ether: remove incorrect __init annotation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181210204514.2362328-1-arnd@arndb.de>
References: <20181210204514.2362328-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Fri, 14 Dec 2018 13:23:01 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_132315_968801_9E14BF22 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 mcuos.com@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 21:45:07 +0100

> The get_mac_address() function is normally inline, but when it is
> not, we get a warning that this configuration is broken:
> 
> WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
> The function w90p910_ether_setup() references
> the function __init get_mac_address().
> This is often because w90p910_ether_setup lacks a __init
> 
> Remove the __init to make it always do the right thing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually I think we can validly mark w90p910_ether_setup() and
w90p910_probe() with appropriate init tagging.  None of these
functions are invoked outside of the probing paths.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
