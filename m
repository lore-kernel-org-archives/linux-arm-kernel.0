Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8902EC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:32:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEC020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L21fL0DD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SlkKG/Ab";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BIpjZ29i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEC020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=km7MyzU2Hzkad/fzYbza8ZMEKF1qwTTt+Fmuv5BG5m4=; b=L21
	fL0DDqc2H4v3qZrHs/kKf5aNF0zXcaP21fHokA/IbSUrvDP60F3gVNVbHOIZtppPze+UpChyjwc31
	Q2xGI34fxZ1FlnVwS1J3+sfKWNaofAFRKRFiuT0Na6ODbVCzpx8ZwzDrj0+Dv+zHCexZAye7lf6Bj
	udZBh6+dqlUDMVfzvuvHa5YJBnW6uRDpjmq5PI3mfuAvQYlQvNCixZEAVDThs5zggtG1oQVSh8n5L
	Ry5DA3efZzUr8ShHoP9gLtmWbJnall0eGjcG87oUQWAZflTfn7gCmoc37dwgXTwYyU/RDkFSexSnJ
	O62pHAiILTEvx6rvh5FlFOwVS2NGO6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUqW-000449-U2; Thu, 13 Dec 2018 17:32:24 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUqF-0003lD-Gx
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:32:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 5F01A60854; Thu, 13 Dec 2018 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544722316;
 bh=Rhtd2hY+2tKNoKDW97bTQqwsVcIlnRQrXmITftSGElc=;
 h=From:To:Cc:Subject:Date:From;
 b=SlkKG/Ab3maYgzYWv/0And2QZEwugCSz6ILjNc/Qkhu8Y0BDPf/L1rIuP6vdsEUZJ
 eqFf6a7KOsxQJGR9VW4YzJVh29sZfxkhtNk51ZitI+lqno40S/aj3NL1n0/lovXJEq
 qpl8m63zD1W9nRL3qqU6cSiiVUwPFCwcpCM/mDjM=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 06D1960132;
 Thu, 13 Dec 2018 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544722313;
 bh=Rhtd2hY+2tKNoKDW97bTQqwsVcIlnRQrXmITftSGElc=;
 h=From:To:Cc:Subject:Date:From;
 b=BIpjZ29iaHI7E4zhNUus9ZMmDK0AuA2VRbXGiJSNzbf6sSqlhk5ER4gKnpg55EN3w
 oPr1LJNSOLlKxOLXoxNm/fxxnWxzdmHSWlnJHXc0+v0H+jP/IG+bGFyxs5K34oq7bf
 RH+CxqJ0ErtrB2yvo+7Noxcmh1cZc2jk/izmHsvE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06D1960132
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] arm64: dts: sdm845: Add sdm845 GPU interconnect
Date: Thu, 13 Dec 2018 10:31:47 -0700
Message-Id: <20181213173149.6975-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_093207_600671_8234D79E 
X-CRM114-Status: UNSURE (   8.71  )
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

Two quick patches to document and add an interconnect port definition
for the sdm845 GPU.

This is based on the base GPU DT changes:
https://patchwork.freedesktop.org/series/39308/

As well as the DT nodes from Georgi:
https://patchwork.kernel.org/patch/10719483/

Jordan Crouse (2):
  dt-bindings: drm/msm/a6xx: Document interconnect properties for GPU
  arm64: dts: sdm845: Add interconnect for GPU

 Documentation/devicetree/bindings/display/msm/gpu.txt | 6 ++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi                  | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
