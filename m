Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B4EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939742070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kfawdKr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939742070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tt/j6a131/XRaICQSlL72oqRD8Fq6jgiZ8H5KPh5Bvs=; b=kfawdKr6GiZlWx
	KvyM2wpGcDHcdZRkl3QPhGcuqRyPlSDedzTFopAVtNM0P24oZsIVcNntCArDl7Hp+hfGQnjgIE68+
	rQvgaKi/5PT8hK0cEr5AS1Tdw20jn/IHGU5DHnfK+5gf0gcYLpKEhH6zO08dM7CVl2n/wjXiNojC5
	En9QbbTj4qLV6uQkL31hmq7XovLYvM/srC2Rrdo9zaQsV8swoedhn+Y0oSnoqImXulFBrS7So4+fp
	rXOVVMXcy8CJ0yfLB6h6yHoSZAO6kut/QvqvtDNvBlyG27dDbT17ikFzsDNh9MRHI6lMwGQ9DNg42
	njEtSB5CKmLS+WlY9pwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gh8Dt-0000B6-E5; Wed, 09 Jan 2019 07:24:21 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gh8Dp-00009p-Jo
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 07:24:19 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id D49B21000F2;
 Wed,  9 Jan 2019 08:24:11 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id UNI4V9w367RP; Wed,  9 Jan 2019 08:24:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 6C5001000F3;
 Wed,  9 Jan 2019 08:24:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id t4h50ervkpdZ; Wed,  9 Jan 2019 08:24:07 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 6E43D1000F2;
 Wed,  9 Jan 2019 08:24:06 +0100 (CET)
Message-ID: <916efaa742e0b621f02b385f0ac6f186b960c028.camel@v3.sk>
Subject: Re: [PATCH v4 01/15] ARM: export arm_pm_restart()
From: Lubomir Rintel <lkundrak@v3.sk>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Wed, 09 Jan 2019 08:24:04 +0100
In-Reply-To: <20190108233137.GW11171@n2100.armlinux.org.uk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-2-lkundrak@v3.sk>
 <20190108233137.GW11171@n2100.armlinux.org.uk>
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_232417_805454_0119F4A7 
X-CRM114-Status: GOOD (  12.09  )
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

On Tue, 2019-01-08 at 23:31 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 08, 2019 at 06:58:04PM +0100, Lubomir Rintel wrote:
> > The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
> > Controller. The EC driver should be a module, since most people don't need
> > it to be compiled in.
> 
> Why do you need this - is there a reason why you can't hook onto the
> restart_handler_list using register_restart_handler()?  The registered
> handlers are passed the command.

Actually, yes. The restart handlers are invoked in atomic context, but
the EC communication needs to block. (The 1.75 EC is actually a SPI
master: a command it initiated by poking a GPIO and waiting until EC
tells us it's ready to read a command.)

Sorry for not mentioning that earlier, I forgot that it is the case.

> I would rather this is not exported to modules, it is generally unsafe
> to hook stuff by directly poking function pointers from module code.

Lubo


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
