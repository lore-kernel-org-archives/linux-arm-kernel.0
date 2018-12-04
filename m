Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB44C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:55:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34BD2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ML2luR7h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sfucxQrI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E3eOWFJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34BD2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zU2kG6Ql+q6gQIYB82EUKpxwQtb+Q8sJRN+hmH8ETKY=; b=ML2luR7hX+O5Ao
	pykFk2j7t2bMctryoW1p7b/qnE2v2vBT/MAyXLXkUSmtgIWpKOibjogiU9J7Am8qGWZ7yF2x+G2HH
	M86Yu3WTfjwNp+yzBfbc9G1lqbsNt0ELGmWIvGXIZqWoBQuPzwhF2L2TUyBHFphO5slfVsfnN1HR0
	0znyIi9S0tTwN7/+uROm5DkRAOwPhkx/nIzxlMkQDwu7DHCFAYH75MBPqs7W3zxBglI8Ye2xmH9Ok
	Ep/3R7j4BBtXDnCLwXK/cuU0OW/5udzKog6jtRRbzaErYMzhUrYPEesEQzRiClKjf7ekn4/klLgAE
	dRBp6Gf1AKMx6y+8A4KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7QT-0000cv-EY; Tue, 04 Dec 2018 09:55:33 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7QJ-0000Sp-Th
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 09:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KepNCfBPnU5ZiDktGsOR/RVGKY4GGdZXvAy6lpDbQD8=; b=sfucxQrIPqccE06xMExvp2PgB9
 1pIurEfCFWx/03aoXooL3xYFvg7c2KoqnKo9JJmByTHnq3kevBCgmwPaJYQ0uy9YkO3rHW39cqvZs
 7/cid5CDURb/7P7yrfJEAcg/cNsbcT3Gkj1I5mMtVBEgWYeqXaXfiCem9gLDweu2oIDL9jAKu60Y6
 HQxrmXiyzTe6M8RFfORDmNnt11pmmNGFgRXdLqO+C2hZgkHB1ArIKke+TUzMgeBiKfnYrPnWQhQf/
 OQ0PpeBCyN4QaSxdm36KJj1oeAr56hee+Ag47GvgL/wFgnIR6sSWPpcXomJ+/tL1Vcs4M7F19e7VW
 0x0D4rvg==;
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6zF-0008RV-CD
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:25 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648700000>; Tue, 04 Dec 2018 01:27:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:10 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 04 Dec 2018 01:27:10 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:10 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:09 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:27:09 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c06486c0006>; Tue, 04 Dec 2018 01:27:09 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 15/19] arm64: dts: tegra210-p2597: add pinmux for PWM-based
 DFLL support
Date: Tue, 4 Dec 2018 17:25:44 +0800
Message-ID: <20181204092548.3038-16-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915632; bh=KepNCfBPnU5ZiDktGsOR/RVGKY4GGdZXvAy6lpDbQD8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=E3eOWFJZmHZdp7ey5fZUjE1Nan/iEBxbslX8eJOjM0ApjRc9BbGNSwSfeRUMaNH1q
 NAzlAWiOq7zlGVxhq2QeZ2p3Wo3+ngASL5B0kxmws53LgHUfhu4c7NKxucRJyddcS7
 cYOOZl2L3/iDle5fCbTfxPSod/aAeZxvIACHp8K3arMecnl5v6JrxU8/ltBe0+8Lhw
 339iAnTnc9vconf4G3AxHLNpvEzasR4pLfZDqz/UDdkBQwzI3GPZ9fTrxM/VytSCr6
 Oyu16fnvdn7uIX6U/fxdF/5VEeDTichieLudBXWVlVHOfKpKwBywTQu7h7W0kTsy0L
 u9Beqk4dMzP2g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_042725_497678_2353D0C0 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add pinmux for PWM-based DFLL support.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 365726ddd418..db5dc0ad466d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1278,6 +1278,20 @@
 				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 		};
+
+		dvfs_pwm_active_state: dvfs_pwm_active {
+			dvfs_pwm_pbb1 {
+				nvidia,pins = "dvfs_pwm_pbb1";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+
+		dvfs_pwm_inactive_state: dvfs_pwm_inactive {
+			dvfs_pwm_pbb1 {
+				nvidia,pins = "dvfs_pwm_pbb1";
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			};
+		};
 	};
 
 	pwm@7000a000 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
