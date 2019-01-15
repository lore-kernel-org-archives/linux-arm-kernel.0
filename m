Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62593C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:06:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3323F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LSxglyR5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKzhg/o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3323F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Ka+c5l6eCvNWC6gwYLWN3s3UPHIpTGf4TEOqwuz/H1k=; b=LSx
	glyR5mDgGHkmKHSFzm1Lrt27hAJdPSvgCq4JocN+0t1X8dv8099UdxbtC7kczkOCyE5H2iXPS3crd
	Ngw2BVX1Gjg/pZ+Qk46YPh8piS4w2yBCfXbF9V8sU+RlloIBRpYZJWg1yG/TrghmulWsBzd0gtpyn
	1t4QiwQ8Ti3Of1fwuNwMn6tQtN/X4LnIvwic0W4LVJb5liuLAzhSm0oAe5D8wotvULoea4tR5Y0VE
	9jTwVTj9FymMM1ids8SgWn7kmOrZRf8cj2axw813mGHcYAQKQeWmsw3Nqb2cVGVDSP2uNgg3HAuEs
	zIQj13wCy7PecomWMAG+TvXiw+tjQKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXnO-00047G-DQ; Tue, 15 Jan 2019 23:06:58 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXnL-00046p-7d
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 23:06:56 +0000
Received: by mail-ed1-x542.google.com with SMTP id b3so3992369ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 15:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=BOCUmPup8Edk6qGTKEBM7IsNV16PwGHPAS/vuqQPaQk=;
 b=eKzhg/o+gbO9X7EAEvjpumJg2mTz9Q+Es4uHrxG2vtMbmstWg0RpfobT71nluNN2pu
 KOu1PfyM8WxKrInbRn2Dao9FlFD8RULgOTO11vURMRx8Zrd10M+IfYHfDGprybpxT585
 Ba08BHpyg2Rld7uW+fKsKWfcI1fZRppsnYFSzgVeetgIIqUIR9Fn+kE/hjPTAoLBf5rd
 0Eo97W6YQtN7LhCDaYe0Db40+20fA2nZreFWNBrlTc5nlHdfhV7axBOtirumOBDdyNvy
 KCmASW5WUCo+3lx9ITHV0yGfx/mTCknMdU9ySlaSrMrrjW3+fSGdxq/dVxgbt5MX1bEc
 8meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BOCUmPup8Edk6qGTKEBM7IsNV16PwGHPAS/vuqQPaQk=;
 b=dn+GA7151VZdu5JBgAylBckDiGADECpR6hTLp5yoyWQflrUtJf/I7oJ04cwkRS49K/
 YlRFqF14/QQZhCXdlcfCboq3v0JfmgxWvEXfveMmw5m37hiMwsWOTNVj8WLP4x0PdSJL
 Ekt+kLVwEZsB+484NmDiZCV9ey2c4cK57ISXc665wMXaSASmRFsCFpzT/4kw+5QxCi5I
 LkvlT78tSxCxd2eK3pNS+1VW9WonlfL2CNX076YOCcnZUbc6hDY45togAgJ6t5Q3Ffc3
 zsW5cD1sQ/yKp512uvA5mtmGow8EMuSkQLCdyEW5YbhH6cdjVhm5yx+mWptDwUHRvaIk
 mPoA==
X-Gm-Message-State: AJcUuke8sYS2GYfCLonpj3m6tzW8TYeZjI6OXUE0qEyZB1ISmXps3G83
 TqbrSZd28azFEdcr7qKayks=
X-Google-Smtp-Source: ALg8bN723zZfoMqBq1PgEDmpdR/+YuYgXg21r/W1RytKhp2DCaKtQv0KmoAR8uz1pVheU759yNdpWw==
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr5096887edc.293.1547593612749; 
 Tue, 15 Jan 2019 15:06:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.06.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 15:06:52 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] net: dsa: Split platform data to header file
Date: Tue, 15 Jan 2019 15:06:10 -0800
Message-Id: <20190115230613.28334-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_150655_321305_CA6DC08C 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 "moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support"
 <linux-arm-kernel@lists.infradead.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

This patch series decouples the DSA platform data structures from
net/dsa.h which was getting used for all sorts of DSA related
structures.

It would probably make sense for this series to go via David's net-next
tree to avoid conflicts on the ARM part, since we cannot obviously
include a header that does not yet exist.

No functional changes intended.

Florian Fainelli (3):
  net: dsa: Split platform data to header file
  ARM: orion5x: Include platform_data/dsa.h
  net: dsa: Include platform_data header file

 MAINTAINERS                                  |  1 +
 arch/arm/mach-orion5x/common.c               |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  |  2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c |  2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        |  2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     |  2 +-
 arch/arm/plat-orion/common.c                 |  2 +-
 include/linux/platform_data/b53.h            |  2 +-
 include/linux/platform_data/dsa.h            | 68 ++++++++++++++++++++
 include/linux/platform_data/mv88e6xxx.h      |  2 +-
 include/net/dsa.h                            | 61 +-----------------
 12 files changed, 79 insertions(+), 69 deletions(-)
 create mode 100644 include/linux/platform_data/dsa.h

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
