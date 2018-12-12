Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24049C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:20:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6EA20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GwRjtIz1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S+IRgSAV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DWOKZ0Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6EA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=oG1LZOgO73lyFzQwpewVmgUbwZ/xN4esd/iZt2fDI+c=; b=GwR
	jtIz11vBxEbX2/7H/sh+qWnGbCFbhRqfUMbPnUjoCyFsFJjbzUAO8fKC4s2ZP47VJdy2yPU6nKCfn
	RzXBKlOP4vPjyZ3jCm5s0wHo/CvaLug+RKzGPgWl51EfUgKaDUu4bgKwTIC5y5qf92FlUmSOpIM2+
	Sh4ZOWw4Xwpm3w4MXEybkQ2yQBnjKi83GhJDhOk1bQp1cHMvdrapXKgbBMJp9stGLOBaOtjzGuxS9
	ewTEpPPXaa+zmQv13AjyuyQTlEjV/0a7JDqo3sQG+9tfskaYcJG3uUW+uuwA49TKgAyW5y6LKmSdF
	SWwm5l7jv1vLHzzOHPFfJYYT8Khhbog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXBvJ-0002fl-Ht; Wed, 12 Dec 2018 21:20:05 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXBuJ-0001jO-S4
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 21:19:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 1DD866030A; Wed, 12 Dec 2018 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544649533;
 bh=GI4w9Dus5kwB9zBJ8Fbyj/63zcezntt6OLzPCV5QUgc=;
 h=From:To:Cc:Subject:Date:From;
 b=S+IRgSAVF0m67cK1KP59HKCcF+AUcxsxbV9YK+I0nMG83nCrlg4FSKCY5EBP0doTz
 tHW0sDSjOe8BiiPp+3YfVakg+bWGrIcPruE+TS4fVnzySOhVB6yHF6TPxCzlyOPk4P
 HI0pw/WzRx2EtVI67a9e/ETEbrG+1MOL++ULoKLs=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 329CF6030A;
 Wed, 12 Dec 2018 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544649532;
 bh=GI4w9Dus5kwB9zBJ8Fbyj/63zcezntt6OLzPCV5QUgc=;
 h=From:To:Cc:Subject:Date:From;
 b=DWOKZ0Bc2jkGO3hZK/B+qc/h02Alpg4UsUpIliui1orbrWMVA9BvLQiY6RFE/j/wC
 sIimrKw3hD6/3qDmQC+54alW5JptadrQyUrBPF9kDV0F74MpTyjwv9F5vYHlrq9/4T
 J5pZVRnf/WVUOMqrgejlGZKrBb8yDL8mBtZFuc6Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 329CF6030A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v6 0/2]  arm64: dts: Add sdm845 GPU/GMU and SMMU 
Date: Wed, 12 Dec 2018 14:18:46 -0700
Message-Id: <20181212211848.26768-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_131904_072356_6848B84F 
X-CRM114-Status: UNSURE (   9.96  )
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
 vireshk@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that more of the sdm845 bindings are headed upstream this a refresh of
of https://patchwork.freedesktop.org/series/39308/ to add bindings and nodes
for the GPU/GMU and GPU SMMU for sdm845.

This is based on :
git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git for-next

with:
https://lore.kernel.org/patchwork/patch/1018365/

This change requires the following dependencies:

include/dt-bindings/power/qcom-rpmpd.h:
https://patchwork.kernel.org/patch/10711119/

qcom,smmu-v2 binding:
https://patchwork.kernel.org/patch/10581911/

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

*** BLURB HERE ***

Jordan Crouse (2):
  dt-bindings: drm/msm/a6xx: Document GMU and update GPU bindings
  arm64: dts: sdm845: Add gpu and gmu device nodes

 .../devicetree/bindings/display/msm/gmu.txt   |  56 ++++++++
 .../devicetree/bindings/display/msm/gpu.txt   |  41 +++++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 123 ++++++++++++++++++
 3 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
