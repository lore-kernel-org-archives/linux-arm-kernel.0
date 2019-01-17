Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22CCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDD620856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sw6+3ve5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDD620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vQV3RPrtTKZZ31JwpL+Li5QTietY3oNS4igKFJuoriI=; b=Sw6
	+3ve5Dnar7cxh3lMFaPjyO3f9K4ZXpHsgaPZLJZiJjykY47esa1ci+EwJ3euR/pX22OImEJsaDpXl
	187Dzr48V4iOsC4/CFt8fXHgn5FAxBcvPgrTihY3MyuAz9TF7ct+6LIR194ztjz1RIbAM3limZWtO
	bFZfjp5uu/52cWYYe4hwlqBYwZS9lzJjXmYkyFon9I2TELEG+8epbRAcmNq9aoubj3Ch6nTxqBeLG
	MQzZekyUHREcIy0Zd7FB0Ru2Mm0fRgymgN/c1Mu3k+c8tcCWyNwYeYyvhNt/MwJzQbKLu9yQ1DKWT
	bWLckqOyCDUBcF8k/5BNqMdxcmlEmYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAiB-0005gJ-Hi; Thu, 17 Jan 2019 16:40:11 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAi7-0004n9-RD
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:40:09 +0000
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M1n4s-1h4RLh0Q1a-00to4X; Thu, 17 Jan 2019 17:39:51 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
 id 31DA16E85603; Thu, 17 Jan 2019 08:39:43 -0800 (PST)
From: Stefan Schaeckeler <schaecsn@gmx.net>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-edac@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for the Aspeed AST2500 SoC EDAC driver
Date: Thu, 17 Jan 2019 08:38:15 -0800
Message-Id: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
X-Provags-ID: V03:K1:GKo1VKn9KyeZV/UCPikGLJBxMv/BIpGyn9BpU807KE2eSsNdoQu
 xg8U5TgIwPoGsZkxB6r7aBgjNNUH/moY42AYjlJ2Zp7VaBbMxbAsgINBqjA1to9qmPs8hco
 TD57GxlxlDkKuEpn5eQuz/lJMlLB2edaNZNzBTFMX2w4grJEmU58SwBrAg/4Caa7EJjwTrE
 26RyJjqj/xDxcxqxd6JMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U8wHh0ywuwI=:x/3zO11iYv/ECKfdIlri+c
 0Okjn/KGgE+Zui6N80ea7ScUFvPx+b0kLHVBu+OxDhy/wgsdHcQ0P1cqyT2J/7R3S7evcwplC
 9GT0tzRTFVn2k3CGnQMpjg1ohWhLCRgR5vwLYUIk2mNVa6WNDjG2wIyN71gNLvFnNNzefLLGR
 0GO3026Mq9ddJngzCLBYtdG70/wir6xOhcIRV/vCTDMrrvldXyVmGGS/Mg0CYNCdK+OlD0ZjM
 PxvgKdb96IMBw+LTYMczAJcJPuJx/xgJLH9dL8PxWPPns+7Cz9c4BqqQHQQx5LFx9C7Nx4vN9
 o6+vLuWBItFnhLpxgVJmRLLRfp+iBK8vu2diKrjbBNJsVq25EacFd3XOHG6a9lc6kXpaY6vdF
 LS2CZf6YcCpTkndIx4fKXVyv7pT1BW0is3akd8rTsr39mwGseNwPBdmiVkPmjP2KX04Y1bC0U
 Q1Gkz3g7/Ml3C+b146dlNaeJAPqu0VBxharbdFLiPYjgE33dKrTbY9TA7lU8ewx72bS33VpY5
 m8yq+WmZCUiVghF75ghaZZCQ7owxxagxlbnzg8WSyDq/M7gIh2PE0CjQ6kQ1eeHcEFgYpPh6I
 C70QZbkfDD35XcGE8NX5SgvOtxK/u/8i9J+aT4yeCYPVNbsx3bBMsmuAPHTm21l1LqXk4uenH
 siCCzhss+USPjkhWuPHbZvuA3yaGfwQHfiSQZxSWEwidyvK6rjypb5ma1TuRfitfjd5Kl8VFC
 rBulFMYHuQwk7jqfEOE4CBu5CEI1QuKQ7hICHdWy5rUrM6R0WC06ELXpUu+Ikoai2+qkY0EOh
 hzx2/KhpHDD6FwU54UJQkuUX33lKbyd42h6HqS31xs54ck/vxY6O45ju3vdlu1I3PSbWA8c5g
 CgF7nGeH+3atthGkqsvzszFnz1I8ec1fqxY21y36pCy5UU2y1yc2qXjemrbcw/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_084008_191716_BEC65106 
X-CRM114-Status: UNSURE (   9.11  )
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
Cc: Stefan M Schaeckeler <sschaeck@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for the Aspeed AST2500 SoC EDAC driver.

Changes since v1:
- Addressed all cosmetic issues
- Fixed (un-)recoverable address calculation in reg58 and reg5c
- Removed status field from the example device tree binding
- Added little more text to Kconfig


Stefan M Schaeckeler (2):
  EDAC: Add Aspeed AST2500 EDAC driver
  dt-bindings: edac: Aspeed AST2500

 .../bindings/edac/aspeed-sdram-edac.txt       |  25 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/aspeed_edac.c                    | 421 ++++++++++++++++++
 6 files changed, 468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 drivers/edac/aspeed_edac.c

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
