Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E626EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:00:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2912147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tt8ENMYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2912147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=YDbIWR5d4h8JdyKWO2msw4Vfevlbu95nX0UNutY+hiE=; b=Tt8
	ENMYjdFogpdp2dxKWljcTCyC99Cju1dFeqA3I/DsTqZosO3Fc2kYMItAioKZsnqcBM+cJo9xM6JQ6
	zKHEOKDgiN+0ItlucSm3CJqmDK1G7z/CSN8yJQq8BadBBCxMtkVTQRwWpoz90kgy284bA14m5dmFz
	hOUARt+QV2GeRwOAgcWHb3HGJKDaaNLqrjarrzuyq8WAfYCMo1iY4b7FA5hE8EvemhW+cvl56guzK
	4SZp4QeO0jNo52d455gbPAhJLepnK34IJG4DBASqqlM8+yLrHiNeKL+LTqFYDEBQ2y9l7/dOlRvkQ
	cMNtJkvrkfdxByaMIzLmvU5Q+4vh9QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwAcY-0003dS-A8; Tue, 19 Feb 2019 18:59:58 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwAcV-0002tu-Qj
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 18:59:57 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Feb 2019 10:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; d="scan'208";a="117434277"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by orsmga006.jf.intel.com with ESMTP; 19 Feb 2019 10:57:53 -0800
From: thor.thayer@linux.intel.com
To: bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
 mchehab@kernel.org, james.morse@arm.com
Subject: [PATCH 0/2] Distinct SOCFPGA SDRAM EDAC config
Date: Tue, 19 Feb 2019 12:59:57 -0600
Message-Id: <1550602799-22737-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_105955_874172_E0283ABA 
X-CRM114-Status: UNSURE (   7.45  )
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
Cc: thor.thayer@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Most users want EDAC support so make it the default.

SOCFPGA SDRAM EDAC reporting was enabled by the parent EDAC
config (CONFIG_ALTERA_EDAC) since initial customers always
wanted SDRAM EDAC enabled.
There are cases where the SDRAM needs to be disabled while
the other block EDACs remain enabled.
This patch set 1) splits out the SDRAM EDAC into a separate
config and 2) enables all the EDAC blocks by default for
32 bit SOCFPGA.

Thor Thayer (2):
  EDAC, altera: Add separate SDRAM EDAC config
  ARM: socfpga_defconfig: enable EDAC by default

 arch/arm/configs/socfpga_defconfig | 36 ++++++++++++--------
 drivers/edac/Kconfig               | 14 ++++++--
 drivers/edac/altera_edac.c         | 67 ++++++++++++++++++++------------------
 3 files changed, 69 insertions(+), 48 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
