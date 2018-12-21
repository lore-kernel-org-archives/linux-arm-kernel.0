Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B790D218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lnMKqFFk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxlhUgBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B790D218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=U87T9t219ZLMOsY2fizKd928ttchm5EhjYIYsSvsKu0=; b=lnM
	KqFFkQ9py+9kNZJNb6QldNC/503dlNYTy84QlzW1UvqCLdEoCWJGyhiXvE6i32owQ27kcoxE1SPma
	MC7KdR1rdOT0NXgFKz6Jv4L0eEXAxAK6gBKA/doNk7eNt8N7RhvZtSefRrZ7WgPfEaaUUVqgKLg3s
	f6nytNCdd/0j5cqbQC74D3+Ju+/VABPrGOaNReuuw1TOF7aYp2z3ZwJH1x/BtMF5QEy8Wc4l/qNBa
	irBm0KIdNpW5mR0qiBSo2gQ1GiXt7lIHS+MLxdWgLyqrj8NhMYu2JM3v5Wedz770iFYEbxtWz/ALL
	wgMUXlnue4wia1O+Up1W3ML2VE8ZoBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga9id-0000WN-AY; Fri, 21 Dec 2018 01:35:15 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga9iZ-0007gr-RW
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 01:35:13 +0000
Received: by mail-pf1-x442.google.com with SMTP id q1so1770903pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 17:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Ig6ZK3uKf2YzNjOJ1fzCFypF2C758BsmRflTMinMBtU=;
 b=nxlhUgBMY4pkaaBTIW6iJeUFgTjbQ6+bs5mNH1Q+oIUS5s/Lc6KobW78o+YrjyLQhp
 9PokePKY2uTySmQCY2BRxhFhtO/Et9RQahDYVASxJP0DdPnWZSS1d44sbd/juDwb48ft
 yIri7T3H9CuOqG0YspXYmNPyA0SKJhL+qPEX9qosvIZ4Rx6CSirVeods0/sppyrCm+z5
 EmaKO+C5VCTGDuaIr51FAVVZHOHJQ8NcgWkT8QZ3hbeYTM4IgEdZhEA1cfGAr07bOc+Q
 Vj8A8UqHFIVhxadVp90y7LuioE/qGRZ641zNMOgkFMukPf30LFCa44qRtWt1gy6QvAiU
 w92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ig6ZK3uKf2YzNjOJ1fzCFypF2C758BsmRflTMinMBtU=;
 b=m0s1DcqY7o2g2MywQTdC3rEDrz0DYjJn9W4FJcT0YTSxieP4/S6Bto5Xbr0y/Vv3cN
 g/BDhRHpf8w37mM0AJ18SAHa0GKQKSzy4mx3fJQMNR8/OtvlfZd8jM0j6OLouzp/jfxg
 Ypcef1t8V5eNaPRzB3jN/UQ0B9FOxdtklFZDrv54iAky8pPhlmHYX3b3duxEMKJ3xD79
 1fW+ETxcsQPupkLGsyQiVGQtNusnsxsk6GoWGnEpfZa9SYeibmB6UguDI6rVlVYYm0HE
 ZPDQzuFHyQ79hjNljwwLAJWMpzlmy+tmHak5/QBH1pkZIDVYoTSjUGIdE3wLNxi0oAJp
 DAbA==
X-Gm-Message-State: AJcUukeET1yCo+NuT6HZ6C/CSS0CCo62pZrmAi/NCKofCIzzC8RdCxOS
 vxKzYyg4esvwwQ07n4h0fpU=
X-Google-Smtp-Source: ALg8bN5sXpkmygbHir8fDT9ICsydwZu3WENdV1yIFqJ2MN00pemcBOdGzxWnypDIqB6FZa+Luywi6A==
X-Received: by 2002:a63:235f:: with SMTP id u31mr514009pgm.122.1545356100477; 
 Thu, 20 Dec 2018 17:35:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id g70sm36590854pfg.98.2018.12.20.17.34.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 17:34:59 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] reset: Add Broadcom STB SW_INIT reset controller driver
Date: Thu, 20 Dec 2018 17:34:07 -0800
Message-Id: <20181221013409.14324-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_173511_892728_E369D402 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Philipp,

This patch series adds support for the Broadcom STB reset controller
using SW_INIT-style registers which have one or more banks of 32
reset lines and separate CLEAR/SET/STATUS registers.

Thanks!

Florian Fainelli (2):
  dt-bindings: reset: Add document for Broadcom STB reset controller
  reset: Add Broadcom STB SW_INIT reset controller driver

 .../devicetree/bindings/reset/brcm,reset.txt  |  27 ++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb.c                 | 121 ++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
 create mode 100644 drivers/reset/reset-brcmstb.c

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
