Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC64C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D04020868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n9Gfl43R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MsmAHzAZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMmkxNXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D04020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PRJaHCbi2a8n1QS/2sl9HjG2T3SkTHJF5uffRnCDy+M=; b=n9Gfl43RT6kaoI
	lNfgOXOhPgYTLXhSauhOYRC27W3Ae+fftglyeHQhhYwYQMDtEgN5v4yUYRd90TA9Qk0bsCU+hc1e5
	XS8T3Q3SJfaaWxUCgAvI2ciKJrj1RnB6dP+nh4N/bRpGnR4UV01bHhYJF3SFQs1AbMcD5/oM5n9NO
	3Ks7aAkIvA1/un3dFjPfN98lK2rZD/Mfd90lfN4aVb1lVDSBw7dp45bdIKYA+QVIwFd5lWPicdLS5
	j16MKUhrn4FkhCzB2oCc3rrRwTsiZtOsgh2H7P1NYTc28cmnUyYEu65kAhsrlj82WQ5XbBdxoAr9J
	ARy3re3jR6eZ9Lfg1G/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwsz-0005gQ-Bu; Thu, 06 Dec 2018 16:52:25 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrO-0003yT-LM
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 16:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z0w/nTaNM7eHzot/N+pmH0qwLzo05YoaQmQUu+orb7k=; b=MsmAHzAZydBJRogZ0OMNo/+dUm
 TpBccywqEDxkrjk6LcfMhWsVQkhA7ZWR77Mjy0EhODqzk3KI85yT2eTGoyb5aETtXNU9+C/kI8Rfz
 wQvHLnQLrFUmw4gW3TxscKPM48GumcdYJPRWvnfzNmuhxCXaATfU8jXOC9tnOZwGf5vDPKp53h88a
 +fleWA7SoukGaTBnHVeXpglXwb7OtTySnPvejWXVCe0P8TGxNUvxIq0ODZM7G/ictrw5h7jc/X7q6
 jcgVYoUiYDgNhVoyfsMtFz8zuYxOvUnmxjGs4lUm6tBU73qX1cdgrPjAZYgHVereAtQrMzhKM3fVy
 irMEThuQ==;
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwrF-0000MS-PH
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:50:44 +0000
Received: by mail-ed1-x542.google.com with SMTP id b3so1353763ede.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z0w/nTaNM7eHzot/N+pmH0qwLzo05YoaQmQUu+orb7k=;
 b=FMmkxNXaYfHrryEVhO0Ys4pyVUebrjzHpWmL4xnZMyv4gpYSjmbNTeiNhdNnJXA5ak
 QoJhxHNRkDRZ1qCmN1vpsMxVk2zkdmHJNmXyD8TBaRQCNMt/nnhCQGx339ecOuW6QZqs
 jpVHtw1ohgEebP23m2B7fFZyeEF103ajCy8GJqXnkV6Tg9PPwljCq/BPIWllD804jMLY
 jna5c/10/WFOPYhFZsB360L1EClIvZeLDvYYIaK4gTRI7ThUHqNhEoQSOY7dDwWRKobS
 UceB6Dkw2OxooUASEg3A8EQqovjEq/9rr2wyM+/1GtDS5Ebxk+YvTtfbZ1TdR69bmOmH
 biWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z0w/nTaNM7eHzot/N+pmH0qwLzo05YoaQmQUu+orb7k=;
 b=pN/G5GAwO4Y4+con9kH/EVNkbGXRnRMF6XkgnNQDIXwbdn2RH5GNjWORjIN/dGaFgM
 Qe2xftU53fPIc03RNIPtaLr7U5P4eTxecEQexEd+Qp15AmVMthQ5DPgD3OMWW14pp3lx
 OIgI3sh14mEbWR7NofDp51VmkTTM5Or/FOJSjNdBAR9iFCBDiKwr8GEm14Zb2tYkOEC1
 h0wqJ0dn5buOi/XDyrFOxSbRPqIIixwmfsHuptvFDuWv82zLW4MG4w9L9GKjckiuQJ0z
 VDPDJSeTaOQ+mYgOEJZhDI/caeXCxy2GyxOwzDY6mZd8T0F4SM9EKwjPRGpJcLxr/x51
 dneA==
X-Gm-Message-State: AA+aEWYXi1g1W+q7PMWfC6sG3HHB89L9SLSiOaggep4oZJqMFArqXxJz
 F8vFJAOeeBe0xpTqXkQKN0c=
X-Google-Smtp-Source: AFSGD/WMb6MQuMa8eMy3u6JgCldeQ0CiebDJO/e9jJViiJINu+ugZTBAJ1fp+1BSM8Y5Hs+Ez3xqAA==
X-Received: by 2002:a50:ea8d:: with SMTP id d13mr25205638edo.126.1544115023941; 
 Thu, 06 Dec 2018 08:50:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id gk8-v6sm169817ejb.42.2018.12.06.08.50.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 08:50:23 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/7] arm64: tegra: Add HDA controller on Tegra186
Date: Thu,  6 Dec 2018 17:50:16 +0100
Message-Id: <20181206165022.23845-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_115037_879450_936FECAE 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The HDA controller found on Tegra186 can be used for audio playback over
HDMI.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 4c79778d80db..6cea54dc9d35 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -318,6 +318,22 @@
 		status = "disabled";
 	};
 
+	hda@3510000 {
+		compatible = "nvidia,tegra186-hda", "nvidia,tegra30-hda";
+		reg = <0x0 0x03510000 0x0 0x10000>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_HDA>,
+			 <&bpmp TEGRA186_CLK_HDA2HDMICODEC>,
+			 <&bpmp TEGRA186_CLK_HDA2CODEC_2X>;
+		clock-names = "hda", "hda2hdmi", "hda2codec_2x";
+		resets = <&bpmp TEGRA186_RESET_HDA>,
+			 <&bpmp TEGRA186_RESET_HDA2HDMICODEC>,
+			 <&bpmp TEGRA186_RESET_HDA2CODEC_2X>;
+		reset-names = "hda", "hda2hdmi", "hda2codec_2x";
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_DISP>;
+		status = "disabled";
+	};
+
 	fuse@3820000 {
 		compatible = "nvidia,tegra186-efuse";
 		reg = <0x0 0x03820000 0x0 0x10000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
