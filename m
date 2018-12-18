Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF454C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17D5218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AE79wxzL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GOrCGUIt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GOrCGUIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17D5218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=uGYVIt6Z2rhhlsy9naKxy4WG2IjV5TwBmNUDJZo0XZk=; b=AE7
	9wxzLic5crzkmuHDOH/50RSwIFT3y+SJGDNbR5nhKE63DkVRLPlAuN7q6ptJwFc8wagBm4WnVyqUl
	Bohk5kQki1KSpLsdFePGskTib28ILe4M8SwoDA6nzA5oe3Xt+5l3GsLMvpcXFekkWfpIDYOiFI3vM
	l0enCf/cUuewh0VkTK+c7bTqnGpkx863pP0Yq3GCOwEROMis2pJfL9jQPRah21AgdvCoAB3rty4dS
	G+p9eYPh2B/mH+n8r0EGXI+K4bcFruOjCIbOe0j/ugNRr0ftPrdz1QzgmTUBpK3XHqkLugpY9jE7a
	cA6g2/8TnjwZbQrFQmbqDnKNCtVci1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKBj-0000Iw-Fi; Tue, 18 Dec 2018 18:33:51 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKAr-0007yu-9r
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:33:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 9A51A6058E; Tue, 18 Dec 2018 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157966;
 bh=mfrC/dck5Y3m6dfG9iC4qNDfYJvVj8GYunV7aIowih4=;
 h=From:To:Cc:Subject:Date:From;
 b=GOrCGUItYZegNip5X9CzaAe2zdoOG7Zh9wnk17x2LV1jY0BmgTldwVtV1LKAL0Lvh
 UZipqLjKpmuMfTXY2vmPhgmI6UY/QfH0A1qts8j03COV8GkKBgGc6rXsDwVx9auzCb
 pCwnSkZxfObSYds9EOz6ikb/orouKmDVS26Oy/gg=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D24D606CF;
 Tue, 18 Dec 2018 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157966;
 bh=mfrC/dck5Y3m6dfG9iC4qNDfYJvVj8GYunV7aIowih4=;
 h=From:To:Cc:Subject:Date:From;
 b=GOrCGUItYZegNip5X9CzaAe2zdoOG7Zh9wnk17x2LV1jY0BmgTldwVtV1LKAL0Lvh
 UZipqLjKpmuMfTXY2vmPhgmI6UY/QfH0A1qts8j03COV8GkKBgGc6rXsDwVx9auzCb
 pCwnSkZxfObSYds9EOz6ikb/orouKmDVS26Oy/gg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D24D606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 0/6] arm64: dts: Add sdm845 GPU/GMU and SMMU
Date: Tue, 18 Dec 2018 11:32:35 -0700
Message-Id: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103257_395818_07707466 
X-CRM114-Status: GOOD (  11.82  )
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

Now that more of the sdm845 bindings are headed upstream this a refresh of
of https://patchwork.freedesktop.org/series/39308/ to add bindings and nodes
for the GPU/GMU and GPU SMMU for sdm845. v7 of this patchset also removes
interrupt-names from the driver and the existing DT changes per feedback from
Rob Herring.

This is based on :
git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next

with:
https://lore.kernel.org/patchwork/patch/1018365/

This change requires the following dependencies:

include/dt-bindings/power/qcom-rpmpd.h:
https://patchwork.kernel.org/patch/10711119/

qcom,smmu-v2 binding:
https://patchwork.kernel.org/patch/10581911/

v7: Add patches to remove interrupt-names, add version specific compatible
    string for gmu
v6: Update GPU bindings for a6xx and make the examples match the nodes and vice
 versa.  Clean up types and rebase on
 https://lore.kernel.org/patchwork/patch/1018365/ to help facilitate merging.
v5: Use symbolic names for the RPMH power levels defined in OPP table,
 move the opp tables as children of their respective nodes and rename
 the iommu device.
v4: Rebase
v3: Split GMU PDC region into two GPU specific sections, fix indentation,
  really use qcom,gmu for the phandle name
v2: changed qcom,arc-level to qcom,level following discussion with Viresh;
  change gmu phandle to qcom,gmu per Rob

Jordan Crouse (6):
  drm/msm/gpu: Remove hardcoded interrupt name
  drm/msm: drop interrupt-names
  ARM: dts: qcom: Removed unused interrupt-names from GPU node
  arm64: dts: qcom: msm8916: Remove unused interrupt-names from GPU
  dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings
  arm64: dts: sdm845: Add gpu and gmu device nodes

 .../devicetree/bindings/display/msm/gmu.txt   |  59 +++++++++
 .../devicetree/bindings/display/msm/gpu.txt   |  43 +++++-
 arch/arm/boot/dts/qcom-apq8064.dtsi           |   1 -
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |   1 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 122 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   1 -
 drivers/gpu/drm/msm/msm_gpu.c                 |   2 +-
 drivers/gpu/drm/msm/msm_gpu.h                 |   1 -
 8 files changed, 221 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
