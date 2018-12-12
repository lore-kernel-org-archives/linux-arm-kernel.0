Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FAC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:31:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99A920839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OE3rocYU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a5CnPq36";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y8ggNLFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99A920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9kmGLXBbYNPxjdKPxOje60OF+gdgcBh6ZxvoD1fFfRc=; b=OE3
	rocYUJuyIx71T4lRVlPQLMoePabUpeRW6UqOWcb2FOJNcx4GkxwQAzHMT+eQUeY1/5qpk72CEfd9W
	p7qmSN1WtTCVOXzRSnIjkTokIFjAaQDjb3B1p25sA3+GNaYW4MVJvCQQ+O6xf0MfRm2/r4pQqShjR
	eK1vEcD9wcEVECl8bCt2UoADl9bhk9qHJywSEtgq/Ak3EVd6Xt/tG3J+dW3Ywps80hUuE3Z9jP/kS
	qskrXdO3nOfPkq8KvKduUqgcJHeK6xKP1KTgAQzf5BJ6RVrSQyxzf1zdrDPB2AD209TNevPhiRnGA
	REdYQXZvMwz1hw9Oj2cVdI73B49Bd1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8MA-0001GP-7H; Wed, 12 Dec 2018 17:31:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8Lx-00011B-IR
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:31:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 9D643602FD; Wed, 12 Dec 2018 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544635870;
 bh=qVmjs9ZuGuSiA1vjJ58HNvFcKUW+3XiOoTkjFW5yIe4=;
 h=From:To:Cc:Subject:Date:From;
 b=a5CnPq36Fx4ZaOSxsba+Jg3cSn9qd12QIeV3PWZWMVl16YCbkjwGnuxukVkOlBwJx
 weO2g3ZLdM5raU4BSgw2k+7/AO1f6EuPY3qCcgqV6QlON8Q24NGhKc/dw/Nlz/o4yw
 vm1CJC3soe32VB5p2n39Sn4C7iS6aQvJqAp40hRM=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BE96600E2;
 Wed, 12 Dec 2018 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1544635869;
 bh=qVmjs9ZuGuSiA1vjJ58HNvFcKUW+3XiOoTkjFW5yIe4=;
 h=From:To:Cc:Subject:Date:From;
 b=Y8ggNLFkvx4+OOMpgP2YzCLh+HI34zCJnmyW32hcVMzFVbVdUyZ6PNqsV95rIH/Qm
 nelNkvscgKQljtt44HOVXFgNk3ehyqgG4aSU0cHY83hi9Wa/9V0UejGpeGZkh7gNWf
 7xXZaTMYVzITSvjnD0ELq9yTPqmWy2DebdAKV2Is=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BE96600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/2] arm64: dts: Add sdm845 GPU/GMU and SMMU
Date: Wed, 12 Dec 2018 10:31:04 -0700
Message-Id: <20181212173106.29618-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_093121_632420_4ADD15DC 
X-CRM114-Status: UNSURE (   9.05  )
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

Now that more of the dependent bindings are headed upstream this a refresh of 
of https://patchwork.freedesktop.org/series/39308/ to add bindings and nodes
for the GPU/GMU and GPU SMMU for sdm845.

This change requires the following dependencies:

gpucc:
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git e431c92188a9

include/dt-bindings/power/qcom-rpmpd.h:
https://patchwork.kernel.org/patch/10711119/

qcom,smmu-v2 binding:
https://patchwork.kernel.org/patch/10581911/

v5: Use symbolic names for the RPMH power levels defined in OPP table,
 move the opp tables as children of their respective nodes and rename
 the iommu device.
v4: Rebase
v3: Split GMU PDC region into two GPU specific sections, fix indentation,
  really use qcom,gmu for the phandle name
v2: changed qcom,arc-level to qcom,level following discussion with Viresh;
  change gmu phandle to qcom,gmu per Rob

Jordan Crouse (2):
  dt-bindings: Document,qcom,adreno-gmu
  arm64: dts: sdm845: Add gpu and gmu device nodes

 .../devicetree/bindings/display/msm/gmu.txt   |  54 ++++++++
 .../devicetree/bindings/display/msm/gpu.txt   |   2 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 123 ++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
