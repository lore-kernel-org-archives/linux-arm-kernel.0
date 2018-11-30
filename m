Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD725C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:26:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F13020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/6ZYcvU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtRVKonJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F13020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5rtd4vm97r9ebEHEAW3lAEs9J3jKfQJ9w4X9hAK9TEo=; b=M/6ZYcvU5KYkO1
	wmzOJ2AWMLQi8ImVdLpAReeOgkcdFrTcWQ5qeFyvKK44OUVDJ7gKM/PMDZIQ36CVMHdiBbLFvfZC5
	+UTNGr/2i2h3p3DBaTHTVOaK5pcTwBTS+8z+IMGOkL301+7S/g0mwBPaZyFaXJoA3wLSDrKcsFbzj
	ma+CvLSjbJUDplEDAj/udtK38kcBVsiL2RbNe11IW6ev3EPaJ+SAlzDBl+mnbZdq0aYP7+6qUMrpA
	a2dKnViY81Nf4LPIdl7oyXXIDU3DVia/R3penVMrihAZFcZ2KxdGKxqEnV5fyb8JICOeGNWi3cvju
	4ZET80ExA+VXMFjsJxgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSf4E-0005BV-Lg; Fri, 30 Nov 2018 09:26:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSf4B-0005Am-AI
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:26:33 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E61A020863;
 Fri, 30 Nov 2018 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543569981;
 bh=wMvXu0Zt5EsV5KTkoYdcXeI3wIa9DPhJCb1R+p4sVY4=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=CtRVKonJw/sfkGo8tZMWHp/DdNUWXK8uYnW2SVewv/woSr/pQ8iEZZYcqQw+4M1uR
 wgj8cTXh/jlmF05QKHhiShS0x19q+LZUIdW8vSI9vmOW8132SRRFgW99i8TLEEKhDn
 q5REh32Ts5SdFC435ZznFVRZtZnEvn4WXX3FzXCc=
MIME-Version: 1.0
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 kbuild test robot <lkp@intel.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181123101132.6be3829c@xps13>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
Message-ID: <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Date: Fri, 30 Nov 2018 01:26:20 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_012631_500153_ACBFB3DC 
X-CRM114-Status: UNSURE (   8.47  )
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
Cc: Gregory Clement <gregory.clement@bootlin.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Nadav Haklai <nadavh@marvell.com>,
 kbuild-all@01.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Miquel Raynal (2018-11-23 01:11:32)
> Would you agree with me adding dummy functions in the #else section
> like:
> 
> static inline void __clk_device_link(struct device *consumer, struct clk *clk)
> {
>        return;
> }
> 
> static inline void __clk_device_unlink(struct clk *clk)
> {
>        return;
> }
> 
> Do you want me to also declare these functions in the #if section
> (with the external keyword) to balance the above declarations?

Why can't we do the linking in __clk_get() and __clk_put()?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
