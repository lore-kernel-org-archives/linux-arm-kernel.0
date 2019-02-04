Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DFAC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:02:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD7E2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="exq0Azmn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xmmI3FGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD7E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CrSpVWnIoNw0017cZ8xkUiJE4w1IK5SiD6KILWDox/s=; b=exq0Azmn1nOzEj
	E6SCzHVY2Spubz7+KaaLlupfSmB2x68mtQAZnNodtjcAsf8faoHnG/5nmfZQiodTEByu6IpRj91gP
	bgGSKYGu7/s7ql5HDWoSdrJLRccGF/Xt9H5vzP8UQ5ujt/ZLSVjOdx9G0uT+5w61Z6ug34lkCaI7F
	RgqcL6xq63gMqG3jF9PYYbfr04QG5HhNKvvYRVI/LcIxoSZvKjLr20E2SQ/gl/DE7q90Kh7l51fVW
	YrXu1P3MbafzK+nXp4v4a7tC4rrEo2Qvgm0/CW1c5YLcyJshkWLJpSN3GVrUE7Go72mlqS62TSGdT
	YbJriCWTxMCmyX2m0aGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqghM-0007ZF-T5; Mon, 04 Feb 2019 16:02:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqghJ-0007Yk-Jv
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:02:14 +0000
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com
 [70.114.128.244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B5C582175B;
 Mon,  4 Feb 2019 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549296133;
 bh=1qDgcDVfU0jIttXiwMM3WKuU9P4YShjHvQCGPXAszos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xmmI3FGrc8s5Ga9e2evNBV8JRe946cJlXsOF0+a5uuZ1rxBPutGeXdwcoq2uVeTYi
 vfqVBv/HQt4oTCVMo3/NunFQM0BaPGR8gy48JrIptfxZ3wR7k3vDnDi58VlyZWfoi6
 DT+FmPu/39yxKnb+rnJFA2J+6JNy9TFarFPRRA+w=
From: Dinh Nguyen <dinguyen@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 2/2] ARM: dts: socfpga: updates for v5.1
Date: Mon,  4 Feb 2019 10:02:10 -0600
Message-Id: <20190204160210.18046-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190204160210.18046-1-dinguyen@kernel.org>
References: <20190204160210.18046-1-dinguyen@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_080213_651140_A8011724 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these DTS updates for v5.1.

Thanks,
Dinh

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v5.1

for you to fetch changes up to 1c909b2dfe6a21de2c24dc1c1405593e40e3a88c:

  ARM: dts: socfpga: update more missing reset properties (2019-01-29 17:12:52 -0600)

----------------------------------------------------------------
SoCFPGA DTS updates for v5.1
- Add SMMU node for Stratix10
- Add vendor prefix fo Novtech
- Add a new 96Boards Chameleon96 board that uses a Cyclone5 SoCFPGA
- Add missing reset properties for all IP on Cyclone5 and Arria10

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: socfpga: update missing reset property peripherals

Manivannan Sadhasivam (2):
      dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
      ARM: dts: Add support for 96Boards Chameleon96 board

Simon Goldschmidt (1):
      ARM: dts: socfpga: update more missing reset properties

Thor Thayer (1):
      arm64: dts: stratix10: Add Stratix10 SMMU support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/socfpga.dtsi                     |  16 +++
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  18 +++
 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts | 130 +++++++++++++++++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  29 +++++
 6 files changed, 195 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
