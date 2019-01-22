Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED0C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:22:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D668E20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWydWp0r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnjMxboO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D668E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Cmeu+jKK+grF0kOcsadzpP9LlitwObygRSeU9Y8g0bM=; b=HWydWp0rgyetH/
	nNhVGSZoALpPVlEp/Aiwb0uVnNZOKKCE+0VsaJRSkE1g++p/R1bjSv+ogopq3imUScrNtvbOKvFTW
	oWkpSIaSPke6StvzmV6umAOJzf8d46Z9sy5H2/TkLCIYMULqHzi7yOT/wuUbV4f4695LKoOwrBhxL
	o5PdXGjakkWXhjhnlu7KJNP3Ok/C/hygjSQwQRQLpy6Ft6h+uG4UCZEXhgZ/gyUKynksmU6Y0zuzL
	D/Xzazwf+luSpfB+n/C2cYHdnTTx5pmiOFt0do/qSlgtyM841do+aya5W/c6MZs58Kjz4GzF+SNta
	pkJxA3lGfH2D0Ruzok0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glqOD-0007nV-EN; Tue, 22 Jan 2019 07:22:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glqO9-0007n8-SS
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 07:22:27 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0DA6120663;
 Tue, 22 Jan 2019 07:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548141745;
 bh=Rw2Fy3DP1VZj5xMZRQLI4aE2/cxUy5Gr7pQpXwQAHsc=;
 h=Date:From:To:Cc:Subject:From;
 b=qnjMxboOl2M2FVLzaFD5ssjOtx0wyCh1SRrWmEUeK+HVzgIHX4zW/VfdUZJiCRTD1
 ROpSeg6dkE/uQyqJ3TIveR8mPt6VQKRkF5P2guk+dT5X2ojSFM0MCKGjDGXOtNnyUD
 4IxqQva1y/uo3fbhjWf2Ee6+Z7iMRIYIyb1YXa0U=
Date: Tue, 22 Jan 2019 15:21:46 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] i.MX fixes for 5.0, 2nd round
Message-ID: <20190122072145.GF19929@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_232225_939225_11407E79 
X-CRM114-Status: UNSURE (   7.33  )
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
Cc: linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit ba0f4560526ba19300c07ed5a3c1df7592815dc6:

  ARM: dts: imx6sx: correct backward compatible of gpt (2019-01-13 10:40:22=
 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx=
-fixes-5.0-2

for you to fetch changes up to c5b11ee9f1c22a8d6b5cab2099904f7adbe79a7f:

  dt-bindings: imx8mq: Number clocks consecutively (2019-01-16 21:27:02 +08=
00)

----------------------------------------------------------------
i.MX fixes for 5.0, 2nd round:

It contains a single fix for i.MX8MQ clock numbers, removing the
duplicate use of 232 and numbering the clocks consecutively.

----------------------------------------------------------------
Guido G=FCnther (1):
      dt-bindings: imx8mq: Number clocks consecutively

 include/dt-bindings/clock/imx8mq-clock.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
