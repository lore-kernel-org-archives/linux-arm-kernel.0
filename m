Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C966FC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:02:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5C520C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oX/Tuyxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5C520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=aJLsiDfCaIwVagakKpY968wpg9YUfnM0JifRBD2RBuA=; b=oX/
	Tuyxw6QTimnbxYaTqh2e8Uv2ByOZ2R2HdZIqa1Tvv82QIKNxce6986P5pjX1rhf7+9Ez3H7zLUrsN
	iivlddzaFHpSbe9ygVu4rHlwYnmACDTSkmwbGZ0+AMutmAM9qEriTI9kGxpqW6zyZ7EeS9tcXlsA4
	/DWIVy+FZP762r0Y0VhHwO9Z9wsx/0F0m4deabdMVFAba5O8D9oJTG40/KDx/THOUJm8GbgC+Ls0Y
	B4xGLnHBP168/n8BTeXWzX2NqvIIfhG16+otgKMpybEg0rI0GRFhBOUN1K0mgebQOiEqIfST2/UCM
	d8ZAkvSVw65u/VO2BEG4UdXiOPpk6jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyLWR-00039M-Md; Mon, 25 Feb 2019 19:02:39 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyLWO-000384-1J
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 19:02:37 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2019 11:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; d="scan'208";a="127150058"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
 by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2019 11:02:33 -0800
From: thor.thayer@linux.intel.com
To: bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
 mchehab@kernel.org, james.morse@arm.com
Subject: [PATCHv2 0/2] Independent SOCFPGA SDRAM EDAC config
Date: Mon, 25 Feb 2019 12:56:44 -0600
Message-Id: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_110236_130323_FA94BAC6 
X-CRM114-Status: UNSURE (   7.27  )
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

V2 Changes
  Rebase socfpga_defconfig against arm-soc/arm/defconfig

Thor Thayer (2):
  EDAC, altera: Add separate SDRAM EDAC config
  ARM: socfpga_defconfig: enable EDAC by default

 arch/arm/configs/socfpga_defconfig | 12 +++++++
 drivers/edac/Kconfig               | 14 ++++++--
 drivers/edac/altera_edac.c         | 67 ++++++++++++++++++++------------------
 3 files changed, 59 insertions(+), 34 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
