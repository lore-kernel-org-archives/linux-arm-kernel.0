Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393ACC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B4120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oyTgWR4U";
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="WTzLQ4c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B4120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=7RUCNDQP3OrdByFulBEEhCBoOhZ2U2WK5i5flSeovEM=; b=oyT
	gWR4UebpNOqxG01cHlf3ucFoMQEiYWL9SDkWT6aRE1lsQ+7m6CMiwB3tJElxJITQo3hCKoke3IZjm
	ciLH+sl9NEQa/bF22MOW/BhTNMxy2xyYcwkmBd1zAx28NsGYEFXz+BvyYM6quO4mUfg2vRQLn1qwC
	exTLMC9RCYZ2BOj2D/4dq4/jDosPIbcUDMBnpXC6QsNP76PROp7ly4hKTNy7fv4ZIvDQYGMzWJyn0
	Lxfu6i7HO7h3D50Qf7vAw/0JqB6WV8NMfMgLwzp8AMzn/4MXvCvSCr6HeFl7rwN7mmR01YF+gQbCD
	JbCPEOhxU3lztmgVeoIoeAIJtUDxMBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT2DM-0004Ml-7y; Sat, 01 Dec 2018 10:09:32 +0000
Received: from mail1.kuutio.org ([2001:41d0:401:3100::431a])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT2DB-0004Br-0X; Sat, 01 Dec 2018 10:09:22 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail1.kuutio.org (Postfix) with ESMTP id 0ABDD1F965;
 Sat,  1 Dec 2018 11:09:05 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
 x-mailer:message-id:date:date:subject:subject:from:from:received
 :received; s=dkim; t=1543658944; x=1546250945; bh=1XCyHO7eZqZeNr
 IAkd/lbqZxbzZiJPinEBVkYo+Qnkk=; b=WTzLQ4c4GxwvhrLpmN88hFvDAuf3Lp
 94CDrcBxzA+5T22PSwLGlY8rGHIqja+oVgG2LlOXkID136tQ4PDpXuQullzdyZo6
 84k6oR3QsNdeuu/0Xpoyyjy3NFUpGVwlV32RAWWmHKM/XVfDcPOUbmh3UuUL0/8J
 eWX1y5YiLG0T3y65W1k1vGfuGAeYSeXP+TBlR4/HhPq2N/L6f8fc7JxLe3oTtIOw
 WHP2YD2TmE0Pbs7rOgPaz5f5d/jeNjXaYTLpsxR26AzlcRvUYiAemCetFLQOVSE+
 cTYF9f4IDIFd/BCZB4ZWyWG6KmlwuYYNj0/bIAdGnf6tGd5R3M7ascARLr6ZsoHW
 cPxcLw7xNFiw9IqZqixBCg/G30xYM6R/sal5t8t4bxFMz+oyJS3ylB3yCvgeWPBt
 6lkImTqlfpwHmmBAhqk81it8DQBFIO8Vz/8ObVKqsG/o5qJ/kzaHz1Co2y1wZZiz
 uII3zHixoZlvWA65mB9hytUp4vgnjF3UBlB8N/+YEUXgTulT9JA/V0Xd9L8ekpxg
 SohBhdp8g8J342S17XtwUfCd0PUj9O2Jyqzn5Ie4/T+Q0wkMBtwNvHBxDADRGf/u
 0ZYHc7OoR6ZERWK8/ADcDMSudiBhl/8njxjJuIL645EXUae1BPkgjKdBxTKspP8n
 x6DWm3MfubrwA=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id OTrghL19Nc97; Sat,  1 Dec 2018 11:09:04 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
 by mail1.kuutio.org (Postfix) with ESMTPSA id AA6701F978;
 Sat,  1 Dec 2018 11:09:03 +0100 (CET)
From: Oskari Lemmela <oskari@lemmela.net>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 0/2] arm64: dts: rockchip: rockpro64 dts issues
Date: Sat,  1 Dec 2018 12:08:15 +0200
Message-Id: <20181201100817.20688-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_020921_197704_9AF0F2FD 
X-CRM114-Status: UNSURE (   8.21  )
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
Cc: devicetree@vger.kernel.org, Akash Gajjar <Akash_Gajjar@mentor.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Oskari Lemmela <oskari@lemmela.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

I found two issues from new rk3399-rockpro64.dts file.

First one is incorrect regulator mapping. Rockpro64 has bit different
GPIO ports used than firefly board. Board is not able boot if GPIO
pins are not inited by bootloader.

Second issue is that dts have video output enabled but no outputs
enabled. Kernel will freeze if CONFIG_DRM_ROCKCHIP is compiled in.

Oskari Lemmela (2):
  arm64: dts: rockchip: rockpro64 fix regulator gpios
  arm64: dts: rockchip: rockpro64 fix video output chain

 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
