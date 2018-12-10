Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1236C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:31:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0D120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uB7J5O+W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cPLOobsC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="SyfUTFuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0D120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Eq/2XQ6fbibIQLVYEY2YIH7X2oQoZ/ukikKMqQjWaE=; b=uB7J5O+WoMwpHg
	D8Bv6GyR/P6lZQnj7qy8GT6MspHqxoZHnN6kcVngdpVjZ4T3v2jtEnTq1FTekT8EQF+8imS+LeB88
	r9FugY6iHUftqPcIGcbl0jw+Gli3s74CIi42oC1nt91CAjqW7SD2SbpMhH8+Illi3L82WQUS6HvwW
	9v2SrI2FcEX2tgxDDIwluPxGwhmc2D+xkYBza+esRRGHgBJRWZSEydSUXrrvER5DWuuaSPvwmO+dp
	qJWgqrHH+Jh8X612ZDabm84qfVSMXfQJVQEHr15kK/ky6CGy0d9PfgiNs9BEoBPqjQvDQTJip+uLB
	JZ1QUbJniw813YaJXOHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRH6-00005t-9h; Mon, 10 Dec 2018 19:31:28 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRH3-0008WA-UM
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 19:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R3vckfbKaGOFqre3VzpA++cmfXTh2HrU7ttVPE4Ted4=; b=cPLOobsCp1AWm2s2P6NI3rReAf
 OYXuPOJoUpK86I7QFUxkIbU5brC3XtGzoCiG12/NrV5r/2w8O0THreLXosEBc39Id/63R17EKOcka
 T3qoZ25wuqc1eP0NsaVMroJ2piZWDK6Pn07IpSbZ5W18G0VmSVSeA5lamVy0NhpsRB8MQtWTq87b1
 uhlxb1HuEMDvJtEbb4yBwiHS5vZijdAzqaAEjSaNNAONNjSu6Bbhd9TKh6vVxw01dqvSSRJ5huLzc
 cMu/VBIFVrSV0vm3Lm303GIJKtDj5mMhX/o3rb98si9FxP0qBgVIz6Y94funHu4OuSCxDx5hyt6VQ
 rb6D+DRA==;
Received: from plaes.org ([188.166.43.21])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQWe-0006fe-56
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:43:29 +0000
Received: from localhost (unknown [213.204.46.240])
 by plaes.org (Postfix) with ESMTPSA id 287604195C;
 Mon, 10 Dec 2018 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1544467348; bh=rL1R6deG8R4m86FOSDKOCU7rxrxi6SE5YJnbhqg7w48=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SyfUTFucZNxHfb6zdMH+nBz7AF5svNHDzNRiiTY4Sz9vRSBQlkK6da+gAnMUei6+B
 cllyP3Xlc1/FqQ48+2yGeUTubaVoVdaYtzN5pHc6tj0tBTxfMxpNjCnZ+C7OYihnSE
 1MT30MRD2wWYTG6V2ZItqx89sUyQ09VTCSUub/CneifpKrNKeAfkVs7fRts3UbsmdQ
 Cn1cLj+vKMJVoaJrEh9sKz+68FFZqTnPrg/oq26QqG4p9Q+VNGCrMv/qaugKH0jajz
 aNPGZPw3QAoNsOwCg5z1UR64LBDTgvia75OP4haDR2ryy7fSWN4cQ1kqIO77dnb7Uo
 dM37smIMKCmhw==
From: Priit Laes <plaes@plaes.org>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Olliver Schinagl <oliver@schinagl.nl>,
 linux-sunxi <linux-sunxi@googlegroups.com>
Subject: [PATCH 6/8] regulator: dts: enable soft-start and ramp delay for the
 OLinuXino Lime2
Date: Mon, 10 Dec 2018 20:42:17 +0200
Message-Id: <b76e1964fee095164ed9313e9f57d4d4318c083f.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_134328_305026_A46A1B98 
X-CRM114-Status: UNSURE (   9.97  )
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
Cc: Priit Laes <plaes@plaes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The OLinuXino Lime2 has a big capacitor on its LDO3 output. It is
actually too large, causing the PMIC to shutdown when toggling the LDO3.

By enabling soft-start and ramp delay we increase the time for the
capacitor to charge lowering the current drain on the power regulator.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 55c9086..4e1c590 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -232,6 +232,8 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 	regulator-name = "vddio-csi0";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
 };
 
 &reg_ldo4 {
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
