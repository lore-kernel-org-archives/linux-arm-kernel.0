Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C21C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:20:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DC920892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WaXSJulM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eetkbKNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DC920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nmmuX3xPbFWw5FcyGCf+dTxxv5pcHflgTK7Tbfk+UgA=; b=WaXSJulMJM47kO
	CM37OE7oWr+M5iOvwyoBWhjVjiN87atiY+uRXVq8Xy9YcxKwMYm2/gjsdtc131Xr/cyEinlAzQtBH
	qDpQ2PBdQ3jHpiNpVdsASuzF6OYvRaJ8q7EWlvXH9vj4Rq08bxf9Ve9jjaey2yWw3e6tfYQLxo7mp
	0dkdNnDytq+uLounBOFYm8eifMymAfPgYQmgp/+fW3H0XD3nbnY7nkZ4Bd52Q5coJj2LWQ4Kemi6w
	pANUN0KW7P9VWbvw9cx11y9O+6zFlJO0QmzhU15q0GJPHhQm0k14DZNKQIQYAZ3voY0hE0E4Vb7aL
	MJB8WLtOutXFeolvz9JA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGzB-0003OT-NC; Fri, 07 Dec 2018 14:20:09 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGz3-0002jf-72
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:20:06 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB7EJlQc103698;
 Fri, 7 Dec 2018 08:19:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1544192387;
 bh=N+a7vrR+/V7dKTm5rwKuERkuYGm86zl2e5mCpbm5IMk=;
 h=To:CC:From:Subject:Date;
 b=eetkbKNgwgOnwpXJHfKzTuS6NC6o1qwLQP+F3m9wI/kAEJHtiaaFk52YGBL/e2u8y
 qeTDQX3ZpC68+O8BLkO+egLWfcjZ3LeeuVgPELWPr+CMVM2HzcpFhAdp2k00lQC4Xy
 p1CzF5qPjS3Z3vYFascIJNoaBaDRZckq/AWmOaiM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB7EJlqR017767
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Dec 2018 08:19:47 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 08:19:46 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 08:19:46 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7EJiZ0022829;
 Fri, 7 Dec 2018 08:19:45 -0600
To: ARM-SoC Maintainers <arm@kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Subject: [GIT PULL] DaVinci SoC updates for v4.21
Message-ID: <127f9656-0cb5-36a9-f3fe-226730986ad7@ti.com>
Date: Fri, 7 Dec 2018 19:49:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_062001_644557_DC1E8ADB 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.21/soc

for you to fetch changes up to a2ce9a67051bbbcc961aca2e06dcadd9b72d72fa:

  ARM: davinci: da850-evm: remove unnecessary include (2018-12-06 16:19:50 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v4.21
-----------------------------

This set of patches moves DaVinci one step closer to
not relying on at24 platform data by relying on nvmem
cell lookups instead.

Once other dependencies are merged, for v4.22, plan is
to merge another series of patches removing at24
platform data.

----------------------------------------------------------------
Bartosz Golaszewski (7):
      ARM: davinci: dm365-evm: use cell nvmem lookup for mac address
      ARM: davinci: dm644x-evm: use cell nvmem lookup for mac address
      ARM: davinci: dm646x-evm: use cell nvmem lookup for mac address
      ARM: davinci: da830-evm: use cell nvmem lookup for mac address
      ARM: davinci: mityomapl138: use cell nvmem lookup for mac address
      ARM: davinci: dm850-evm: use cell nvmem lookup for mac address
      ARM: davinci: da850-evm: remove unnecessary include

 arch/arm/mach-davinci/board-da830-evm.c    | 26 ++++++++++++++++++++++++++
 arch/arm/mach-davinci/board-da850-evm.c    | 30 +++++++++++++++++++++++++++++-
 arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++++++++++++++++++++++
 arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++++++++++++++++++++++
 arch/arm/mach-davinci/board-dm646x-evm.c   | 24 ++++++++++++++++++++++++
 arch/arm/mach-davinci/board-mityomapl138.c | 29 +++++++++++++++++++++++++++++
 6 files changed, 157 insertions(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
