Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133FC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:32:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C963920879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxqPjWvf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TQk9Srqk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lksa3bfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C963920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=walHTUts4k4OXWq9EDG02e35IhSA2JYRX9iwmLeAlYY=; b=kxqPjWvfppR/go1wys7f8RnFnt
	NwOgoYIy/DQEAJx8xIC9Ty+5Kz18xsKqwPDBT4Qjhzgh+1EqCrPEeC1JoIJt8llPmbROsGGzTlGqB
	NkuxpRhxfwg2OKoDy0te/uXFOQSgT/Nq3g+tQnpjpdJ8ibuOtA2xl/fg8/CvH2psA8xA13lcap5pl
	DPcBzWPoJBPKepfaOg1ULtO/EoPzUvix7uLr8rJ7aPLfD47zDqJeCeDsybI06E++9CLe/hvLBOVzF
	tiFs+eNfwcqtpi3AwCPnsWyVvK97YBQr3h4ib6ge6ZCq13qT9YBRvgCpltICzw5IYoHwRp6j8CYgI
	P9UR4oqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUqx-0004Wq-6B; Thu, 13 Dec 2018 17:32:51 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUqF-0003lE-HR
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:32:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id DAFCF6084F; Thu, 13 Dec 2018 17:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544722316;
 bh=h9MsjaQKHnhWHN7oNFvU8lPg2Baa8bbKoYkA26js5+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TQk9Srqkt45/R1aKk4ZAVAgqSyOWPkXuOT3kQgQIb0jz0dYgSL519GogHgy/AVdGB
 ytlg+jhcdNs0+5VuXdifAbvgwKo6x2CuncqoYLfuveTlhYaUookyxatc0Pyd5775BW
 bRh2batRfWK2sYZG7ge6FK2xRxemwJYVAohCTZfI=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 39498601C3;
 Thu, 13 Dec 2018 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544722314;
 bh=h9MsjaQKHnhWHN7oNFvU8lPg2Baa8bbKoYkA26js5+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lksa3bfZXQ8xZ7pJQOUVKabwuD21H1FpQrPvNouiKzWQvi3sk9ZdYhPm3K+/6XfnW
 9vQcnKuM4OHAxn2IlwGXXenhL/wab42QIIkUrtt2Hp2+a9Mt04fa1IRwyJXKc13cRe
 5zTrX6ARTzIddIlYN1zC1PQ+2yoPhl4kBUq9tRPw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39498601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
Date: Thu, 13 Dec 2018 10:31:48 -0700
Message-Id: <20181213173149.6975-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181213173149.6975-1-jcrouse@codeaurora.org>
References: <20181213173149.6975-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_093207_609679_A8ECE083 
X-CRM114-Status: UNSURE (   9.37  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add documentation for the interconnect and interconnect-names bindings
for the GPU node as detailed by bindings/interconnect/interconnect.txt.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
index 8d9415180c22..be6b5628e052 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.txt
+++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
@@ -19,6 +19,9 @@ Required properties:
   * "mem_iface"
 - iommus: optional phandle to an adreno iommu instance
 - operating-points-v2: optional phandle to the OPP operating points
+- interconnect: optional phandle to a interconnect provider.  See
+  ../interconnect/interconnect.txt for details.
+- interconnect-names: Name string for the interconnects.
 - qcom,gmu: For a6xx and newer targets a phandle to the GMU device that will
   control the power for the GPU
 
@@ -68,6 +71,9 @@ Example a6xx (with GMU):
 
 		operating-points-v2 = <&gpu_opp_table>;
 
+		interconnects = <&qnoc MASTER_GFX3D &qnoc SLAVE_EBI1>;
+		interconnect-names = "gfx-mem";
+
 		qcom,gmu = <&gmu>;
 	};
 };
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
