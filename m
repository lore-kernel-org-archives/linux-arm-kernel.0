Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA7C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4952184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UiCKW4su";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zZoQn6Sk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HzTf23ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4952184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3FEfB5iB7XW2gDi6g90mXEwI/ZJnqnqqbmC5yCBpwpo=; b=UiCKW4su7R92nY
	oriDIvr9HyzaGI7t+hCmd032s3qcKwaSikiIM9eLV3Rv7Q9n6JeScZmndA6EDWEIYN5JnVAppPcYQ
	DgFxemoG6YQ9vDvgFyiJ6D72PjqSkjFKTPXpwpUvVoiluO+wBVmfGXyPmdgEL1LNatteaWS/uqi2J
	OBWDCAG4wX6DUEetbO4Ce6GKjP1EBZPes8PHcIBk6fSPpzxkOPRB4zbaLyC7Xlez6aSlUH6OJFeH0
	j19mmeVA59Yn05tial/NdZUm8nGgXmu5XFNJgMVuRTao7KweiSnQx/wMG0JMp/UR+KMFPcDoNT/jr
	ISgqxltzdQpKiELk24fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVxj-0003Fd-74; Tue, 12 Feb 2019 11:10:51 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVxd-00037j-GQ
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 11:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:CC:To:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w4PVnQwxduN+UnUe55MZMEKkhvCQ8aTHUtyy+A1Rp9g=; b=zZoQn6Sku+AbvGrrwn+DpuGT/r
 QIlPfFlcbagaWzDhib11E6dBfR7vI3YX46zMFW39PxD5qOmzaeRxlGzFz+NUJea+jxukUsgmONvfu
 Gx+xYdvvIMvXU3vyA6a8bbyJ+EypKMafUlq2OlzpEog5TyDVt2X2+nRMkMuXhdcxeORvaIiC2C05k
 xEXwkQhqeOwGbur38xcTzmIxLLw2QxnDjanjPPU/umkBRHpuSmeBZRshV+iKOtGAFU3orK+ep2FFt
 w6+a1lXtPDsFGwrygwXpB1Bfeu66legFZUA6JDlUQq1T7KtbvrvfVD5xZG4bZcm5Qd60LPT8gBXDv
 LcAgEL2Q==;
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVUn-0002JW-1O
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:40:57 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1CAegvs072535;
 Tue, 12 Feb 2019 04:40:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549968042;
 bh=w4PVnQwxduN+UnUe55MZMEKkhvCQ8aTHUtyy+A1Rp9g=;
 h=To:CC:From:Subject:Date;
 b=HzTf23ysc/tuQYjM41F76bolyy9qTPcLwpwcWZVd0vRXNBpYQelVsq9YfLcrszFsC
 mmR8V+Ury4Obj2FROwUY8ukeCmikupNLIUp1Qe+tBCBeP05wb4ZGrVH/QnI4pGcZK8
 iMhLTXFkaPSg+DbFh++ebv9frqbB0jj5z+7jAtk4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1CAegek103866
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 04:40:42 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 04:40:42 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 04:40:42 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1CAedgf001966;
 Tue, 12 Feb 2019 04:40:40 -0600
To: ARM-SoC Maintainers <arm@kernel.org>
From: Sekhar Nori <nsekhar@ti.com>
Subject: [GIT PULL] DaVinci SoC updates for v5.1 (part 2)
Message-ID: <53340003-0b43-7b5c-9a24-5f2e4d8f8a3a@ti.com>
Date: Tue, 12 Feb 2019 16:10:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_054057_213455_FF966A47 
X-CRM114-Status: GOOD (  10.84  )
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
 Alan Stern <stern@rowland.harvard.edu>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit e430685f496928240a328708b976c17929541011:

  ARM: davinci: mityomapl138: use device properties for at24 eeprom (2019-01-10 13:58:00 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v5.1/soc-part2

for you to fetch changes up to 23fa70e40a42e8dfeac654b8cc0e5b463e54af25:

  usb: ohci-da8xx: remove unused callbacks from platform data (2019-02-12 13:48:59 +0530)

----------------------------------------------------------------
DaVinci SoC updates for v5.1 (part 2)

This pull request contains changes needed to help get rid of
hard-coded GPIO base value passed from DaVinci platform data.

The OHCI related changes also help by moving over-current support
from board-files to OHCI driver making future DT-coversion easy.

The OHCI parts are acked by its maintainer.

----------------------------------------------------------------
Bartosz Golaszewski (9):
      ARM: davinci: da850-evm: use GPIO hogs instead of the legacy API
      usb: ohci-da8xx: add a new line after local variables
      usb: ohci-da8xx: add a helper pointer to &pdev->dev
      ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
      ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
      usb: ohci-da8xx: add vbus and overcurrent gpios
      ARM: davinci: omapl138-hawk: remove legacy usb helpers
      ARM: davinci: da830-evm: remove legacy usb helpers
      usb: ohci-da8xx: remove unused callbacks from platform data

 arch/arm/mach-davinci/board-da830-evm.c     |  73 ++---------------
 arch/arm/mach-davinci/board-da850-evm.c     |  22 ++++--
 arch/arm/mach-davinci/board-omapl138-hawk.c |  81 +++----------------
 drivers/usb/host/ohci-da8xx.c               | 118 ++++++++++++++--------------
 include/linux/platform_data/usb-davinci.h   |  14 ----
 5 files changed, 91 insertions(+), 217 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
