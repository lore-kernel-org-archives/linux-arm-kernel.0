Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B9EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787FE21726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E+SLTXHS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EJRxPq4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787FE21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gH0r2A1n8TC9QgDoPRkOT6rxP7/SfhxswhnmbErg9/g=; b=E+SLTXHSB5rjD/
	Le1cc4LLX2v+5/9B1fT6/aIFiS4PcintV6yCWEIgsoM5LFEpAoatsmYmqx4dg7nvWYDGKZ6cHisqf
	yes86mVYqSwUGXSnZ/9bMsbABUabzkAKBHGoZcWaBNgNjJEEBvubdMVgyJKkazDFag87RHum1MgT/
	FvB51CL12Br1equK9QPoPZI1bdg49aeSbfdwjtNaUclfa+RoUBU2eLkkywuiVpNNxvBVSM+lCzPzQ
	dGln3WWjWR30Huqhgw1E1hghZXI3zUTD0FPErQYUpa5KmhQYPZPVYXvzV4R5gNGyVIv1sJuBXfpUf
	etEd5/oY0qjCkjbXnfxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUSR-0000fG-Oi; Fri, 01 Feb 2019 08:45:55 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUSE-0000TU-GX
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:45:44 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x118jaWZ041291;
 Fri, 1 Feb 2019 02:45:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549010736;
 bh=/kGIvOm98FIBbyeVvvsOQ2sVhsWrTXGL/05GjdT0NvQ=;
 h=From:To:CC:Subject:Date;
 b=EJRxPq4XBZnQvqtgyJCzzqNwmUFi73YtUhU9kG2FIco0jQpZIDfYeez7GKLUbrwJo
 rmwoLFJBhgt99WXsYxDumPFMEj4N4ea6CTWDuQDL3cksYfiyC54oOj2hsISwuLL/t5
 TGE0UiOa8Rs1fi4Cf2yp6BpIt7t+tlV1bGyddpXk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x118jaWj092452
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Feb 2019 02:45:36 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Feb 2019 02:45:35 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Feb 2019 02:45:35 -0600
Received: from psplinux063.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x118jX5u005565;
 Fri, 1 Feb 2019 02:45:34 -0600
From: Sekhar Nori <nsekhar@ti.com>
To: ARM-SoC Maintainers <arm@kernel.org>
Subject: [GIT PULL 1/2] DaVinci SoC updates for v5.1
Date: Fri, 1 Feb 2019 14:15:32 +0530
Message-ID: <20190201084533.12881-1-nsekhar@ti.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004542_632342_909FFE0B 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v5.1/soc

for you to fetch changes up to e430685f496928240a328708b976c17929541011:

  ARM: davinci: mityomapl138: use device properties for at24 eeprom (2019-01-10 13:58:00 +0530)

----------------------------------------------------------------
DaVinci SoC support updates for v5.1

This pull request contains changes needed to modernize the at24
EEPROM driver and remove the legacy platform data structure in
favor of device properties. DaVinci was the only user of at24
platform data.

The branch is shared with at24 maintainer as immutable commit
to build upon.

----------------------------------------------------------------
Bartosz Golaszewski (11):
      ARM: davinci: da850-evm: remove dead MTD code
      ARM: davinci: mityomapl138: don't read the MAC address from machine code
      ARM: davinci: dm365-evm: use device properties for at24 eeprom
      ARM: davinci: da830-evm: use device properties for at24 eeprom
      ARM: davinci: dm644x-evm: use device properties for at24 eeprom
      ARM: davinci: dm646x-evm: use device properties for at24 eeprom
      ARM: davinci: sffsdr: fix the at24 eeprom device name
      ARM: davinci: sffsdr: use device properties for at24 eeprom
      ARM: davinci: remove dead code related to MAC address reading
      ARM: davinci: mityomapl138: use nvmem notifiers
      ARM: davinci: mityomapl138: use device properties for at24 eeprom

 arch/arm/mach-davinci/board-da830-evm.c    | 13 ++++------
 arch/arm/mach-davinci/board-da850-evm.c    | 28 ----------------------
 arch/arm/mach-davinci/board-dm365-evm.c    | 13 ++++------
 arch/arm/mach-davinci/board-dm644x-evm.c   | 13 ++++------
 arch/arm/mach-davinci/board-dm646x-evm.c   | 13 ++++------
 arch/arm/mach-davinci/board-mityomapl138.c | 38 +++++++++++++++++-------------
 arch/arm/mach-davinci/board-sffsdr.c       | 13 +++++-----
 arch/arm/mach-davinci/common.c             | 15 ------------
 include/linux/davinci_emac.h               |  1 -
 9 files changed, 47 insertions(+), 100 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
