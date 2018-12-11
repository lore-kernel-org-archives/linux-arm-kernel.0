Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7994C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10742082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aCSyjlL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10742082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bvoySzmJt4MNS8cEfJRlPi7qSpVlpzFWYPOZDXRiRYc=; b=aCS
	yjlL/1TdLKT42mt8BHKvtfYemCNISGZ6oSwKhtpMWnuYJ18bQPsXQySVwPTreaBQGQE3DCx/n7ZUH
	18UXORyeZeR2kV1/BDV1KRZaQP5GGBpHDS9sXzvTapaBOKfY51+vrJ1CrcaObiQWm7L8An0+HROZ9
	GPFcX7E0sc/kkLXA8k3DXN0jroFMvSQUOx/V9QMYTCXG/FwAcjCYX6FLndb3/Z5eS5ktUI4Esrl2y
	NYBScsQzVKqsr6bs3GSG1GwoSzhG2PAzLBQHQabxjjifnNDTWUw3bJQQUXhiptLx9CTysC+mSA1Rv
	j7g5NJKboa6FfI5qXnUs+OH7jhJc6CQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiSG-0003w0-9i; Tue, 11 Dec 2018 13:52:08 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiSC-0003uc-Pr
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:52:06 +0000
Received: from stefan-Vostro-260.fritz.box ([109.104.44.229]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvbJw-1hLf6r3LZG-00sfkW; Tue, 11 Dec 2018 14:51:47 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 0/3] nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
Date: Tue, 11 Dec 2018 14:51:10 +0100
Message-Id: <1544536273-17909-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:1EnOG46VPVvOlXl+UxpFq6Jl7VqE25pBJiOpMB/h/kGS0PkXq1b
 KerbtNl2dZx4Fu/IBtS5a2d5FVNo1PovJZF2v23jr5ldBQe/sdwomIRN661MFehQROloCtl
 C5znFYIi2TV0w6cNVL5vkDQB4Q9/w+U2c+VJ+LotZxpRR4l94+g1x/YYdkHeC8WpM9F1HfJ
 G/OxVLUn+sxTdkaMwBP5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bR6zNVxaI5Q=:b5CR5ArNvPbYurWOd/bcEu
 epjoDI+sT3MROEOPnysMKqtIw35To8PXtW6wn7fafNYhw0HuwQJxzpmUuhlwaPGE0dQPum62O
 WfZOe6yzRLoVk2NbOFQBwy+XSyA/0SN9IBXg4Qso2lR0szaHGHf+z3pQhlqQj/68FkR66AjJm
 EbRcd4x7TRwZ2uk5C1TWc4mJtKOZK9EzD6vj7AnShnayI2AFMV/+1H/gykaTn6uz6HgCabV5R
 2FgMZDiWHqiQZlpBgYD3Y+SYKwvqgsXPpnqr4CRvSeORBSER04e6aqo+8VJ4pKxzBcl2rjzBQ
 eb8JKrVQ09olu6mDqsD+1yhONdiFf3/5TXC7X9iD9d0lfQ6vye2B9vqakpFgtAXN5ZQ3UUIB3
 kO/6oLmEFbb3V6u+NQckcyaGvRXDvQ36CDXc20gJL/t7SCPRyK2Gq6U/VNRosMWNARqFs9bzD
 yQoBNKSHZylvbsfd5OMvQRuPjU0j1r4jGP5tBbiBust3ZMt61/GHmveLUX/Kz172SS5WudOIe
 Hd6eIbCUFMElVyv4nYX2/iQzuy1XzYvXhEX+HubPN/CyzgLcOyfrJUL5H6uojIHcXYuxO3h+p
 GGwaKF2Ehkjir4/SOltzENLqkq6eXhQi2rCqvCt6UdSRhBhGEb0sjXyEylD5Jvel++8F5i2IQ
 0pMrDXB0U1fz7eoEf2/5RzMVl+xKCzNlKhpFJW4enIL5RqCeFwK1LnZSe6kGbACUV7gx/Aqz9
 XjvYFA7gZHMmLA1FebcQzxnr55yal8mwGZ80N+qdptJHqzFanpSdCdndrN0=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055205_139316_83FA1D96 
X-CRM114-Status: GOOD (  10.51  )
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
 Sascha Hauer <s.hauer@pengutronix.de>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to the reference manuals for i.MX6ULL and i.MX6ULZ both SoCs
only support 8 OTP banks instead of 16. So we can't use the compatible
string of i.MX6UL.

Stefan Wahren (3):
  dt-bindings: imx-ocotp: Add i.MX6ULL/ULZ support
  nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
  ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible

 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 arch/arm/boot/dts/imx6ull.dtsi                        | 4 ++++
 drivers/nvmem/imx-ocotp.c                             | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
