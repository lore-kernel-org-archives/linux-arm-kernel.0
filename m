Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9397CC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:18:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC8220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Alz4t58r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RHXTpNdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BvGj+AIiilYxadF8QzIcku8F2BTIGHtkkaFrp2Tetf4=; b=Alz4t58rr5QqFK
	xTH9SVihdlNMZBghz0QRnXuUy24P8pawc6fyanEIYC/6kOeBXVW8rqHkWAecgGQy2HCJVtJguSAfb
	z7aN2nwhSz+lm3beZeQuRV9sMmLf3PtO4fjH3T6+qaPH7dpjgKGhLSI/u457HR5AIHUR7MP1jrdYb
	F87/86jfMmzvLupNOp4LwpsjYssQvI1iib3p47rLJfL3o5VsnrKXMnY8PhAJpwTfiabj0CpXMBRRw
	HODU3AGqY/6N/QfLf5FpwRCxhiV8b9P5zIT67hP+Zn90oz2/uaDOhSFav9Wp5OMqbgcj68tSEzvmV
	LlSW9CWt3aWrxuLEKWzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grmO5-0000Bx-8v; Thu, 07 Feb 2019 16:18:53 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grmO1-0000BM-8n
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 16:18:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:Content-Type:MIME-Version:
 Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BD5pXxcqZXBSRGEDMyg0/sbCznTi4usgrz6g7xp0wdE=; b=RHXTpNdvpiGCGsrXFkfIfYcSJ
 nuLTywQEbzhR+8baoDmVhky6g4Mhx9GwqnH8MrGl7rvbEgEvSlR22sQcJ931mSAjUkC0x4f5owaTT
 yzssij+H0Xil5neNh0XGqH19GyqbWUGTkYLwXnYFJSFSGsjDgMlKcZcCww4uBJ2FxDTLE=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36602)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1grmNi-0002Rq-64; Thu, 07 Feb 2019 16:18:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1grmNd-0006JB-RP; Thu, 07 Feb 2019 16:18:25 +0000
Date: Thu, 7 Feb 2019 16:18:25 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next v2 0/6] Add comphy support for Armada 38x
Message-ID: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_081849_314222_2941915D 
X-CRM114-Status: GOOD (  12.14  )
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
 netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This series adds support for the comphy for Armada 38x, which allows
these SoCs to use 2500BASE-X mode with appropriate SFP modules.

Tested on SolidRun Clearfog after updating for the 5.0 merge window
changes.

 .../bindings/net/marvell-armada-370-neta.txt       |   2 +-
 .../bindings/phy/phy-armada38x-comphy.txt          |  40 ++++
 arch/arm/boot/dts/armada-388-clearfog.dtsi         |   2 +
 arch/arm/boot/dts/armada-38x.dtsi                  |  37 ++++
 drivers/net/ethernet/marvell/mvneta.c              |  45 +++-
 drivers/phy/marvell/Kconfig                        |  10 +
 drivers/phy/marvell/Makefile                       |   1 +
 drivers/phy/marvell/phy-armada38x-comphy.c         | 237 +++++++++++++++++++++
 8 files changed, 369 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-armada38x-comphy.txt
 create mode 100644 drivers/phy/marvell/phy-armada38x-comphy.c

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
