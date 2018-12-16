Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 08:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F71217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 08:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IIbA3nEK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVu94Zj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F71217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=b/jablf5Yccy3p0ggpgaD0+71XAx0mOelkJQboQnbYs=; b=IIbA3nEKeUzpKY
	BR3zGPdQGs2GwnxLG7ASt6T/DrkdRv8nll9uUMxSbnpuwMOfdaXZmihg0wlU1jb3AlYpQL2UI9kkX
	hQKUpcwAfQ9WIMYgBdZa15Oz0lLf6gAujIcmv4tTDru7ef2qLwmCtH0JZRilLiT+YyzqL3y7DOeXf
	kIBbGIf//rBu5fdwDuH3TLEshiMAROYDvhenCV4q0mWSoEjKJMt6P43aMQELeNHotzf0DmqVg9j4n
	7k9KK83OAAh+yN4dTayaWA6T6J+/HdJjQL92omfzROqoPaGG7sw0YTp3UMKGJESxAOECHTkp/Fwe1
	OjSa/X0TqAvgkM8LyhuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYS7q-0006AV-9S; Sun, 16 Dec 2018 08:50:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYS7n-0004ud-41
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 08:50:12 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6851F206C2;
 Sun, 16 Dec 2018 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544950200;
 bh=D9rVwO0nvyY/qXifeYgpHAodzV1O8H4G0vQp4/wN03c=;
 h=Date:From:To:Cc:Subject:From;
 b=VVu94Zj/l9EXCrkZi1DSJB626ucPzjeRCJr5m/qB0jaKhCPknHLAlMKTHMiK2+Y+P
 O2eOn83G1OxT169Fcd+biKj6O6xHwDNdf2x+FfTT8vaTK7VcANahfV4AqR4B4uKOh1
 gY39FE3ghlHMaL0Gtq/I9JBLnYqo8NkJqjKJwuIQ=
Date: Sun, 16 Dec 2018 16:48:56 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] FSL QSPI device tree cleanup for 4.21
Message-ID: <20181216084854.GJ13243@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_005011_183108_8BAF8C53 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, Schrempf Frieder <frieder.schrempf@kontron.de>,
 linux-imx@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

As the series cleans up both i.MX/Freescale arm32 and arm64 device
trees, the pull request is based on a merge of tag imx-dt-4.21 and
imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
This comes a bit late, and we appreciate it if you can pull it for 4.21,
as it paves the way for new QSPI driver under SPI framework to land in
the next release cycle.  Thanks.

Shawn


The following changes since commit 744284fa15a1acc8601ddc0a349678e033100925:

  Merge tag 'imx-dt64-4.21' into imx/qspi-dt (2018-12-16 16:20:47 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-qspi-dt-clean

for you to fetch changes up to 30648e9f864774388d261f42e79955362f4739e7:

  arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller (2018-12-16 16:24:01 +0800)

----------------------------------------------------------------
Freescale QSPI device tree cleanup for 4.21:
 - It contains a series from Schrempf Frieder that cleans up FSL QSPI
   device tree nodes.  The current device trees are broken because they
   use an inconsistent scheme for assigning the reg properties.  It
   becomes a problem with ongoing QSPI driver under SPI framework.  So
   the cleanup is a preparation for new driver landing in the next
   cycle.

----------------------------------------------------------------
Frieder Schrempf (5):
      ARM: dts: Remove unused properties from FSL QSPI driver nodes
      ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
      ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
      arm64: dts: Remove unused properties from FSL QSPI driver nodes
      arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller

 arch/arm/boot/dts/imx6sx-sdb-reva.dts              | 8 ++++++--
 arch/arm/boot/dts/imx6sx-sdb.dts                   | 8 ++++++--
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 2 ++
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 5 ++---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 6 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 4 ++++
 8 files changed, 28 insertions(+), 12 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
