Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B8C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:14:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD852081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z3cEFwo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD852081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AIaMm/ZBoGX2+HJJ9jIa52rdL1FOwr4z8r3n6AEIAyY=; b=Z3cEFwo35DGCeT
	y2IB31JyOTCySJE1cW13dlXbsyS3sXA2nV9K78LpA8H8OqrzCFxjPlHQ5cEQsV0SqL1cmC7a0pF01
	YtrB2Ys1f395zm5yv3OXcep9F0Mkktne0cqjyDt206rMvDBau0hTVnROJedZbfPqVJMNZFEAsjnp7
	qEub4lfl379al4VtP1u7MY2LvCfoD6t6XDboWHdIpqBRPaG8YyA1Q6g1aIJU1xKKi4vHdO8JBFZ5D
	v1+KrTN4TQyJnjA2M03dqngMNyb4n6E0pR6cNueCdbaMYjjjbm77qvZYhHbtb0AKXOzpuQdNzC6Ma
	2HNZOrBmG0xPyPzZjviw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTOly-0001vM-1N; Sun, 02 Dec 2018 10:14:46 +0000
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTOlu-0001um-Mq
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 10:14:44 +0000
Received: from belgarion ([90.89.234.36]) by mwinf5d28 with ME
 id 6yEW1z00C0nnJME03yEWKB; Sun, 02 Dec 2018 11:14:31 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 02 Dec 2018 11:14:31 +0100
X-ME-IP: 90.89.234.36
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ARM: dts: pxa: clean up USB controller nodes
References: <20181201135451.3505-1-daniel@zonque.org>
X-URL: http://belgarath.falguerolles.org/
Date: Sun, 02 Dec 2018 11:14:30 +0100
In-Reply-To: <20181201135451.3505-1-daniel@zonque.org> (Daniel Mack's message
 of "Sat, 1 Dec 2018 14:54:51 +0100")
Message-ID: <87va4cw7zt.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_021443_028811_1D2DE841 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, haojian.zhuang@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Daniel Mack <daniel@zonque.org> writes:

> PXA25xx SoCs don't have a USB controller, so drop the node from the
> common pxa2xx.dtsi base file. Both pxa27x and pxa3xx have a dedicated
> node already anyway.
>
> While at it, unify the names for the nodes across all pxa platforms.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> Reported-by: Sergey Yanovich <ynvich@gmail.com>
> Link: https://patchwork.kernel.org/patch/8375421/
Applied to pxa/dt, thanks.

Cheers.

--
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
