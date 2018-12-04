Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05916C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9AD2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SA+4E2qs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="har1xhng";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Uc/V1bHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9AD2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XkDY9uaOt2FPOtZ7wqV+mUuc0afmLvEknXgZjREnT2w=; b=SA+4E2qs6NsRm0
	+6SFRBxezhrePTjMWYon8BHElWA5SEgF1C6Pfm1y3PZSkjZj7PUDWjaZX8Nm1MLyenCslirTIs1qy
	rCVFwjlImLgfwwzGTMZGNKufwjzczhuEsHlTh1fKmaJpSJrkiJ2QhlZ9ULZrm6aFrGAVhdJgVRA2K
	rmZdU/hjF7SiT2hf6vPodUHVpGCB2qi5qTqlMIORDNYCo6c1pnn4eIhoAQAhCmZh9JGiuG9YMWaXg
	qakIUJP0NkUXRwzRasVwFXt/nJ8xK57+/6PTEEmjf2LehYq8EWhvYkn13pKXEyz0bYVoqtlxg/i8C
	WzQBJVWRq+ivdHDQnMfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7EQ-0001FQ-Ar; Tue, 04 Dec 2018 09:43:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7EO-0001AV-6u
 for linux-arm-kernel@bombadil.infradead.org; Tue, 04 Dec 2018 09:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rJyx7zXRuTxfbnU7n2PuC6aW6kvPz9uE39dkSEuq+7Y=; b=har1xhngR9JfPIwMkhsqG0tOq6
 8OJA61ojtulEM3lMMwb1ruw3mkxDOs7LjbzDxrFWDQ8BMldyCBJArlw1X5kiJutvNGUvqmQVXg+NQ
 tVDHnNwInZlUTexB6BwW8s5QleMbYJmpXAASfHoibbXSwsErVZTntcncB2MiYMb+vEe9aSemtLGuv
 hBOZ0+6DIBYRKfU8TFDCarJI15FlGuX63OylaFaKNmPa407/JSIkd26Wuzu5mTMiOmhXqFdk1Th4f
 glSLS1PnU8WLbDfik6DvugfGOW5PH/wnlxVixEYpnSE9M2rzRWLs2ZueunKSn+6ZnQKuBrP8lB3M/
 r4Sa/zlw==;
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU6zR-00088W-HR
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:27:39 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c0648760000>; Tue, 04 Dec 2018 01:27:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 04 Dec 2018 01:27:16 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 04 Dec 2018 01:27:16 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 09:27:15 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via
 Frontend Transport; Tue, 4 Dec 2018 09:27:15 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c0648720001>; Tue, 04 Dec 2018 01:27:15 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver
 <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 18/19] arm64: dts: tegra210-smaug: enable DFLL clock
Date: Tue, 4 Dec 2018 17:25:47 +0800
Message-ID: <20181204092548.3038-19-josephl@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204092548.3038-1-josephl@nvidia.com>
References: <20181204092548.3038-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1543915638; bh=rJyx7zXRuTxfbnU7n2PuC6aW6kvPz9uE39dkSEuq+7Y=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=Uc/V1bHXazMNlld1T8Iasz+oXxBWIQO/tf8Mvzc5no5GZhUviu9D6y5GaiEfjHfjF
 Qtx2+poKe2KR+52zaCljgavwlECJJSAVi6GJCRK6ESzvADGmfVL0JpXYJdnYwbsUQY
 rJzikITvJYC55UwsWs8oj13peNJOsKuYFJMkozq0wSi6qg/njvKLCV5az3a1mTXuq7
 GH0VKslbIFE6iUoz9EZiO1cvXiP8krwLpm/rI+9hfxZIan21+ZVLask+HYJKr2bind
 jdRPbKniz7aXzNHTDaCCYBGt3F0V+/6FKHJqNdcLoLy5TB0+Nrz1g7lybLWXK2v1mj
 ZjxYTlJzWwMcQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092737_711769_2D895B5E 
X-CRM114-Status: UNSURE (   8.49  )
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
Cc: linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable DFLL clock for Smaug board.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index b3930a9dd139..beac7b0bf436 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1698,6 +1698,18 @@
 		status = "okay";
 	};
 
+	clock@70110000 {
+		status = "okay";
+		nvidia,sample-rate = <12500>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <6>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		nvidia,i2c-fs-rate = <400000>;
+		vdd-cpu-supply = <&max77621_cpu>;
+	};
+
 	aconnect@702c0000 {
 		status = "okay";
 
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
