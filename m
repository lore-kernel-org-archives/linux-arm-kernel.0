Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B21C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:53:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4739F217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NQghzZMB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-ipv6.be header.i=@linux-ipv6.be header.b="bfouYvkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4739F217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-ipv6.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=78tb1AKTXTFkxVEXhbmSNPPKYjWgxW6gx+SWeUfQx8M=; b=NQghzZMBaLq5bo
	lSyuS0LhQtx7mjy04Dr4/qLlizEgzYuQGZ6QGktpKGQ5x2Pn9fDtRTPgzFlTrCXBhjhkXP2XNFXIU
	UaooJWQQh52Lu8yhmHZn1IgEgQJMe2CGoSJeSqbcs5/LU3rxSREtV3H/zTySzGAFfbCg3BRPG+32O
	ktqql1fjLAHAGNOXjq8ueu45NCIv75C6zMQOkvjaHWecIm57cU/uUTAplhvD59bhvK3h8CR1POIN7
	5FiwULk2KIlbC1udsbLqayaLdAJcHgoFilhBOXhNOKf15lL3uz2SGa5FW3Esq4fjKzoTU/A4Y1RSq
	+HtiEmsoiU3GVfKPENlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsUwW-0005mY-Pc; Sat, 09 Feb 2019 15:53:24 +0000
Received: from mail.tintel.eu ([2001:41d0:8:1644:0:ff:fe5c:6a54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsUwR-0005lK-SP; Sat, 09 Feb 2019 15:53:21 +0000
Received: from localhost (localhost [IPv6:::1])
 by mail.tintel.eu (Postfix) with ESMTP id 2FCFA424DC03;
 Sat,  9 Feb 2019 16:53:11 +0100 (CET)
Received: from mail.tintel.eu ([IPv6:::1])
 by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id nhXsaBVFDLvC; Sat,  9 Feb 2019 16:53:10 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by mail.tintel.eu (Postfix) with ESMTP id B5DD2424DBFC;
 Sat,  9 Feb 2019 16:53:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.tintel.eu B5DD2424DBFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux-ipv6.be;
 s=502B7754-045F-11E5-BBC5-64595FD46BE8; t=1549727590;
 bh=OgugLh0YvI/wkG93AJWR1X2iSQ6uRFdoVFbvmNFEWzQ=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=bfouYvkgiT84cafkoPNucUO0NoVyBPiEWL0cmRagbw+IHM5Ys3SgckWNRurkCQJFv
 lVAzKQBpzx69QLkLAwcJqjFuMGo7DUsw0/Rso0f7IruwnL3U5P+JNbvgYYiQiYnlvM
 6O8r8mfHQ/xoRJQ2vK6NmrLMn0OHZAeQbCIdKBks=
X-Virus-Scanned: amavisd-new at mail.tintel.eu
Received: from mail.tintel.eu ([IPv6:::1])
 by localhost (mail.tintel.eu [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id UcrKXnOPeicR; Sat,  9 Feb 2019 16:53:10 +0100 (CET)
Received: from taz.sof.bg.adlevio.net (taz.sof.bg.adlevio.net
 [IPv6:2001:67c:21bc:24::adb])
 by mail.tintel.eu (Postfix) with SMTP id E97E6424DC03;
 Sat,  9 Feb 2019 16:53:09 +0100 (CET)
Received: (nullmailer pid 18505 invoked by uid 1000);
 Sat, 09 Feb 2019 15:50:05 -0000
From: Stijn Tintel <stijn@linux-ipv6.be>
To: khilman@baylibre.com
Subject: [PATCH] arm64: dts: meson-gxbb-odroidc2: enable I2C bus B
Date: Sat,  9 Feb 2019 17:50:05 +0200
Message-Id: <20190209155005.18458-1-stijn@linux-ipv6.be>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: E97E6424DC03
X-Spamd-Result: default: False [7.10 / 15.00]; ARC_NA(0.00)[];
 R_SPF_FAIL(1.00)[-all]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 DMARC_NA(0.00)[linux-ipv6.be];
 NEURAL_SPAM_SHORT(0.78)[0.389,0]; MID_CONTAINS_FROM(1.00)[];
 IP_SCORE(0.32)[ip: (0.58), ipnet: 2001:67c:21bc::/48(0.56), asn: 200533(0.39),
 country: BG(0.07)]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:200533, ipnet:2001:67c:21bc::/48, country:BG];
 RCVD_COUNT_TWO(0.00)[2]; GREYLIST(0.00)[pass,body]
X-Rspamd-Server: musltoo
X-Spam: Yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_075320_204273_3BB2F5D0 
X-CRM114-Status: UNSURE (   5.39  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The ODROID C2 has 2 I2C buses, so enable both of them.

Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1cc9dc68ef00..ee666471a580 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -180,6 +180,12 @@
 	pinctrl-names = "default";
 };
 
+&i2c_B {
+	status = "okay";
+	pinctrl-0 = <&i2c_b_pins>;
+	pinctrl-names = "default";
+};
+
 &ir {
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
