Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30667C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FD920675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uiW4aJ49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FD920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9XAS4TJZcb0+NO85ThsOpJtrOTW7NckK5BXqc7oAy2Y=; b=uiW
	4aJ49X1DoBkMk+8UJoCHzRLmjxkwluxHFqERNtlePn+K0f+gnCcpoSp3+13yXu20ory7cgAvwnK9p
	IKV72oEbHk3Y4I0SkB9ewXCdTp52Z7M7U31tgrLpG0imy2iipERmVqIJg0ck3Xmp9+zTsANf17XrI
	prxh8nhCqCJGaus0xe0XPRfUbo77CoXnTSxhlLSpWPlYAo2Hg3VuYEwB3HvoCdfSWERgJpOzU3YsG
	U75ZixQBAXkziqVZODb/nnV/9k7vRu4+ZpQBE8P5LaVjcXOkldU+ktAZiT4+ziA4q8z4y+3EPOK4a
	hmEEfP2iyTmzeSGAdWMJJ+Q6iUSCFBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYm0H-00030d-FG; Mon, 17 Dec 2018 06:03:45 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYm0E-0002zs-PE
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 06:03:44 +0000
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lk81O-1h9ki60LTm-00c5Kv; Mon, 17 Dec 2018 07:03:16 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
 id 4B7CF6E85603; Sun, 16 Dec 2018 22:03:05 -0800 (PST)
From: Stefan Schaeckeler <schaecsn@gmx.net>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-edac@vger.kernel.org
Subject: [PATCH 0/2] Add support for the Aspeed AST2500 SoC EDAC driver.
Date: Sun, 16 Dec 2018 22:01:55 -0800
Message-Id: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
X-Provags-ID: V03:K1:uDXuDiMiyMIaJb5D4w/ejLEwugGfffC2YXJ1XpfPw3ILrI7Cdmv
 J+Yd067wWeoIS1V/WQN83RUtzaHphLfcL5K2y2UDe8cxylb+Dri080jmFrOT5vg0V80BxJX
 IRLhxIuR5566i63xn7B737Rrpvkt5caLugmdwAJqii4igkxiES2ET5NZt5O62V0/fyhtCV1
 bfNeyTRqTJP9rZ0+A4oQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EgDxcVkVaLM=:vdQygj7Mzb4EfuPktUJu6R
 ydQYsBcrGRrYESR6HfMOr0bvYvmjRKAod8qGnL7NHrFa88KxAoBzA7htyQmTTeMcMhRkW9syO
 7vF91YEIcxPy3PLfWlfJFTQQq3TX0qQSVLMRPXnKAWm4dKMrEpyP8729SlZ60oDpmrFCmGRbt
 yyryT9XxgkD17wX0W09m5PkkcN4ZfVruykmcedlSWjEuB4o2J3iE/wrwhKxdq3r0lyV0DnpO/
 6s5artl5NdZmfZiBr6BYfzcSd00ZWNOuGxdpS8+2XmclAJg4p5pF2qowO+om7wug++WWQmQKy
 yy+MkbAHbGpImyzWkinrfG7Bb+z+QZc24iDRaDBAiFJ2gqyAZ6ZkHMrcyqOB0n1oWr3n7QCUo
 viT2s693YPL5fX1hzsulwS6/V7rozoeY4m1z6NV2FVJ43X+jPmuanzREMgeaiuNqhRav/B2Wx
 N2RAoK9mCKu5Wh7xDRFH0IzWtLns0zWA+dUvW0z+q6e9X7TYuPxr1g1G+ubjwqM3XduPsg6QU
 TiIYm8EAOWr9TWPF+xIPP7OsGzacLCAeA9qF8dERyLizSuc/nnzFMVvxjfVdzzNsNZqLO4Ape
 E+CAX7/hSWslEkNkYUx001PFKBefeDZH1nDbUwM3lhXIvk9Etxni0wQ2HVael6WjJu4lagMUG
 mrKx7fBo3YpjIs98TEO1/4Lfgbzm8GwyvIeO6zq7sjCD+8Gsy4rseYVgIaizqZOXjXtSL42W2
 iz/uJgxDp5WzzkWq9EN65+dChW9ua8pX0ai+7bxtsH9pBNK6eFFtXhmoXfIAnVLk7K9BKYUxv
 6m5lCxlzjZi8oQ9KZwU00I8kyGRSrMm+TTbCTq/YrBV22k7B5ZhSHQRAVyldGUXzSMhSw5Bey
 JuxNznbnLHlyDbmF99gSocT9r218vQSrBPKgjb4Og=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_220343_122841_2B520FC9 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: Stefan M Schaeckeler <schaecsn@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stefan M Schaeckeler <schaecsn@gmx.net>

Add support for the Aspeed AST2500 SoC EDAC driver.

Note, I only have access to AST2500 hardware and documentation. The AST2500
documentation explicitly states that the sdram controller is not backward
compatible with AST2400 and hence this driver is not supporting it.

Best, Stefan


Stefan M Schaeckeler (2):
  EDAC: Add Aspeed AST2500 EDAC driver
  dt-bindings: edac: Aspeed AST2500

 .../bindings/edac/aspeed-sdram-edac.txt       |  34 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/aspeed_edac.c                    | 457 ++++++++++++++++++
 6 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 drivers/edac/aspeed_edac.c

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
