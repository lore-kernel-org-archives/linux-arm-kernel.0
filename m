Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D5CC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:23:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320B521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HLpS8nx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320B521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pschenker.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6v9vNxga2ZwWzg4pT+HKgJSF+N2hTYhtP22l3uyZ7l0=; b=HLpS8nx7mOY/Jy
	ljEl2hqsJAM7tMXjRnXIdPc1oCCzidWrOXE5SVAfe2WfarBob2NRMWPe/x4iz+DuFehTp8Sx/sgSr
	ePJcfpVHcr47kt9KcZtydP9mx3Tusf+ey6TOklOlW/nWPj4j5UuIz83FFmLI2gqveZwQmlYBw9PNi
	/5IHECKO2Vicx2ggRgilf9ZN9uPjm7aBLuAgdVwhE/qhW3Ew+sV4GM/0JqtYgpqu9Lm3RriydY7D3
	9RwO9bh31qNKTyLnVf67wWSuxJZHfL8DedV2f0oECRtPOpEu5KF0XJ924biGfJAQAHXsUmQ6idewZ
	P7VJ/q/8AEvZM+5cEVag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glw0y-0004Lz-BI; Tue, 22 Jan 2019 13:22:52 +0000
Received: from mxout017.mail.hostpoint.ch ([2a00:d70:0:e::317])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glw05-0003Uo-SG
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:22:00 +0000
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
 by mxout017.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glvzx-000IW3-1a; Tue, 22 Jan 2019 14:21:49 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
 by asmtp012.mail.hostpoint.ch with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91 (FreeBSD))
 (envelope-from <dev@pschenker.ch>)
 id 1glvzw-0001Dy-TG; Tue, 22 Jan 2019 14:21:48 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
From: Philippe Schenker <dev@pschenker.ch>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Date: Tue, 22 Jan 2019 14:21:33 +0100
Message-Id: <20190122132135.5012-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_052158_275613_D4F731D2 
X-CRM114-Status: UNSURE (   6.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 max.krummenacher@toradex.com, Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Hello,

Recently the STMPE811 driver got pulled by MFD (for 5.1).
This patches I'm sending are now adding support for STMPE811 ADC in
devicetree. These patches have been in the STMPE811 ADC driver patchset
but were not pulled by Lee, as they had no reviews and I also corrected
some minor comment errors.


Philippe Schenker (2):
  ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules
  ARM: dts: Add stmpe-adc DT node to Toradex T30 modules

 arch/arm/boot/dts/imx6qdl-apalis.dtsi      | 22 ++++++++++++++--------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi     | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis.dtsi      | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-colibri.dtsi     | 22 ++++++++++++++--------
 5 files changed, 70 insertions(+), 40 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
