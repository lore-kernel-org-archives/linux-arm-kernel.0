Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF44C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:26:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC4220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jlYuLG5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC4220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=by0DXWAz+6tlnLIUaLrQ1aT0rx77mFxKuvTAGtelhEM=; b=jlY
	uLG5PeI5PdfVIT3V19rm6F8cu7VKL3ipGZaa1dFhw94OPUhn0WRzLm9nDbm6YY0Ii8zflAeZ8hol7
	YMOlOD6Nt3sc4xqrO8dkNFLY6ee9tCjrrF+/4pu7vhG1Yr7mrr0wFqwqK/aZrPw4uWGQ17cshLmhs
	CcPtUkoGROg0giFtR4816lCyH++iXPJb7Ko2p/i5jkufL2A8khPwKJzKVb+JFNQ7WHWQf+vmQfHrV
	b/ejrwqeSOHbJiHyviDmjI3Yk3SuL/iYig0N4HM1TjA81Vm6IL7vylyogl1vBUGVxFf0fCS+9XsCp
	U+LFsP33WC6AUlVCOiDx0F1AYQAYYJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gloaB-0001nn-L8; Tue, 22 Jan 2019 05:26:43 +0000
Received: from mail-out.m-online.net ([212.18.0.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gloa7-0001nI-GB
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 05:26:42 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43kH2x4GG8z1qvNf;
 Tue, 22 Jan 2019 06:26:33 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43kH2x3yJyz1qsn1;
 Tue, 22 Jan 2019 06:26:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id LQtFMCJdfIqf; Tue, 22 Jan 2019 06:26:33 +0100 (CET)
X-Auth-Info: m7WgfxMwe0RP2YdFmr36mZBHsjO3OpAfBpXEDwAzmgQ=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Tue, 22 Jan 2019 06:26:33 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
 by mail-internal.denx.de (Postfix) with ESMTP id 420F6180759;
 Tue, 22 Jan 2019 06:26:25 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
 id 11A6A37A6; Tue, 22 Jan 2019 06:26:24 +0100 (CET)
From: Heiko Schocher <hs@denx.de>
To: devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] ARM: dts: am335x-shc.dts: small updates for shc board
Date: Tue, 22 Jan 2019 06:26:21 +0100
Message-Id: <20190122052623.1779840-1-hs@denx.de>
X-Mailer: git-send-email 2.17.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_212639_694289_1249B6A7 
X-CRM114-Status: UNSURE (   8.81  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
 Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

small updates for am335x based shc board:
- switch DTS to SPDX identifier
- fix wrong gpio level for mmc1 cd pin


Heiko Schocher (2):
  ARM: dts: am335x-shc.dts: Switch to SPDX identifier
  ARM: dts: am335x-shc.dts: fix wrong cd pin level

 arch/arm/boot/dts/am335x-shc.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
