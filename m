Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2637BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E42214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iBwlmlnA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YSCC/Iuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E42214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KCxgT5jG2/8E9QsKko6oszOlhcwT7HBra/aHXtfavls=; b=iBwlmlnACGGwXH
	5ML5qOpS7hs5nC5csgrtS3Y9gPec4h8WbIXT+ZoCzjhzj/qURAcyuTsDLHOzBdFhMOrSOpYeBABm3
	LEQGpIrACgBt/f/vfnsW2fYJ0AIrTU/RQnk37KY4UbgykQJE2iOOiet481Almi66aeGfvMb1GlS9S
	uQnZfDk/Yw7MhbdM3yNI3KGyANlRihv8DNuCrk7Gn9ZVIIvRyDS0PZeHi+qqRGveRqTfiglDxF0Cq
	FtE2Am9nKZpAU8NphnoYfv82vT1T4EjAMxsPKOwnu9CZRkXmxrN3orsDC0a+Wp7tx6hOsVe9RHu2n
	6Ob6Z1za8pZ2t2nLdPeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh0qs-00074E-G6; Tue, 08 Jan 2019 23:32:06 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh0qp-00073I-0q
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 23:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZDpqMIOfSr80qqy4WqGmoqDm1tA8iRjzyqUWs77v9hw=; b=YSCC/Iuu4hcibcnt+3fd/pdu4
 VI6WQA0g6fGBNHBuaPXlISIs3/naf9d0hwkDuj9jYXCNGwGR1oCV7+zP+JbKCbnaRG7NhiDwiQaON
 FYQ5RVYeo7wVcxELm7psFb/PrELdekvRzbEbZ0k1x56ujZtBRn7fAtpeLacAhvyXENQrU=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38817)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gh0qT-0004wk-Dp; Tue, 08 Jan 2019 23:31:41 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gh0qQ-0007a6-QT; Tue, 08 Jan 2019 23:31:39 +0000
Date: Tue, 8 Jan 2019 23:31:37 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v4 01/15] ARM: export arm_pm_restart()
Message-ID: <20190108233137.GW11171@n2100.armlinux.org.uk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190108175818.705110-2-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_153203_070367_35235507 
X-CRM114-Status: GOOD (  11.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>, Darren Hart <dvhart@infradead.org>,
 Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 06:58:04PM +0100, Lubomir Rintel wrote:
> The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
> Controller. The EC driver should be a module, since most people don't need
> it to be compiled in.

Why do you need this - is there a reason why you can't hook onto the
restart_handler_list using register_restart_handler()?  The registered
handlers are passed the command.

I would rather this is not exported to modules, it is generally unsafe
to hook stuff by directly poking function pointers from module code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
