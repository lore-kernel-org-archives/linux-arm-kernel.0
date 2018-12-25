Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A90C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BF0218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aB7VhSkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BF0218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=06i37KpPjbNHAfsf09mMKsafvUfKgS7SlR/f22JgIis=; b=aB7
	VhSkbQp0uKBxI/w/2/czteO9r8AKh/QzvLKsPFBXnn87KhZAwHE7kgQiafN2ZxpomKJ7bI6UwHJCK
	hhwOdmNGNKXhLIbsIJXuPIymSuhkSXhz7xFCq9KlsEp3ycfAWOYc0MkPxQ2UIJawGiNZ1UGOyzrkx
	h1GAdPaIdUFWSmptrbPoSVhXe4s9hMneDs7pEi6R70zyAe20qn8pcG/3i63gpXJjxILbbWHDuRByw
	9PvVpvlCftaAh/RG6vn5kfVaUOhBwBgWRfQITUCrONNUyt7nOWlpXOeKq3UDX6r21vVzRf9FxXVlm
	dJTt7fdZkmA7Cd7nDSuF6DbpAN+OllA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbw0s-0007hi-9U; Tue, 25 Dec 2018 23:21:26 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbw0n-0007ab-VO; Tue, 25 Dec 2018 23:21:23 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mj8eB-1hGkvu2zB7-00fE60; Wed, 26 Dec 2018 00:20:59 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V4 0/3] ARM: dts: add Raspberry Pi 3 A+
Date: Wed, 26 Dec 2018 00:20:05 +0100
Message-Id: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:Wtvy/+F+S8dqXP5LozDt+5APLevhYFTLHT11Eh+Ak9nmU6sWs1T
 MMaU+nO3D5teBBmex/iXTL/YRuFAbsfXqonTKT3ggM57n/dqFX4DscnbBiFrzoisNoEqons
 XM63vdpU2kI4Py2Io6X7lgH6K5mjCgv82s6Gr1+FmTJucg+s36KCOvWUv2tCwtvUKxh5Rmi
 pqgNLPy+316OgohTflixQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bh5g22rmupk=:TDBsdaRNp1gxXSjilIIJVM
 bqbLJjvN28KrbhrUQX2g5gFf9jazD9sJHD87vK5nHvvRvikAHjbvPAE2IyUtOVgeU2DbJgx9b
 BcMZrUOl8WKlt8Xe+h+OxptJGrCFtwSUlOKoORRbhXrnN7NN07dRMQOwaIYfGPERvRx/tuOnV
 Nf3T23BphlWvEM4xk7Ioqt9+3AoreheKxWbbHTU0yNIf1S1ThBA85heCQuJevRtHOUaAfheO0
 JR62ezHD/nX8gGjiYnNnIntlQ3bfMMdPZdjLSLpx3wFXexjDvjEhHgyhAu+4E6rpCknMBWvYS
 CB3MOdW1mrkZ3D0jDnMYRZXtk3rMlpruU4eEgSDzncp5nPz3vDTGd7DGbKz6TXKb8cvmKTN6g
 Vb78W1sz89dO79e9BbIe9e8CKxWjd36Dum+UyIw8ubRTKXpPw+Gg4DutclzpM9uQil/n2VA7i
 YhJnZiANlOYIL5Dxt4aURYBIXOQSp9FOGTXfoT0K1rp/MWWt22bv8odHPlDtdzx4JcyRX5KSP
 Et792StgW8vcp+JosfQRixzbVrSyk43s9TJQ9leuGQjO6lTZClnv8w9nrXHgXzyOAvY3mdane
 UadEz1c7sBKbBFB3yK+ExEwae1WqPDLw1nNhJflcjS2Olv/XXY2aieG1b3vIUwZZZ1u+yYyPF
 F1LJF2OgN2aXYzlfayOiLoh+77zlz0r9ejCWwuInC/Fs2NH9Q2AqHPmq3Jv0h48gfJj2aqTk8
 aGxJ4TWS1zYUeL7eEflzdNYY7hTzm5+yJYJpTRLsxcwAlD8RKWkCZEd01dQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_152122_325584_414E1894 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for the brand new Raspberry Pi 3 A+ .
Since there is no official DTS file yet, this one bases on a procfs dump and
the dt-blob of the firmware [1].

[1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts

Changes in V4:
- address Phil's comment by dropping BT_ON and rename WL_ON to BT_WL_ON
- drop Wifi and BT reset control and add explaining comment
- add missing gpio line names
- add Rob's Reviewed-by 

Changes in V3:
- add Eric's Reviewed-by
- fix wifi reset GPIO polarity

Changes in V2:
- add missing Makefile change for arm64

Stefan Wahren (3):
  dt-bindings: bcm: Add Raspberry Pi 3 A+
  ARM: dts: add Raspberry Pi 3 A+
  arm64: dts: broadcom: Add reference to RPi 3 A+

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 175 +++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts     |   2 +
 5 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
