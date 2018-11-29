Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36448C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071E720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UffGesFe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E3GuDkpm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jRzFjoaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071E720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xOQ8SG468ggYBJhkvzy/6g0nzQdLKt7Bw7SGwwoC084=; b=Uff
	GesFejBeu5hruUxFggpRJFG47HMVPrflblKJKgTdZ27Erqrmbhajr6SIteZulKpA59yrUrgbd19dz
	2fwInbv0maQJ9eejANvqcZjQuxr73MeivB2EDBtiIvDq9MS4auPWPSHBB/4p3GkOaBLOgqVmcVD6H
	Y8rgHv0VSiJGqetQNnodrZ1UDvfckKlZxU75hDoHrJZAw2P7IJHkx59ieKMS7ohhy3MhfNmlQp0V1
	HqV40rCHY+NvQVGrnGWLo4fdrFNJogdyMfz8GoomBXBda86/8seFmyFVkr1qvE4qNUvOwxpTIUPX0
	IRRAG/rS2/VOio5qIoeQVskeTYRCCWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQ5W-0001G8-0n; Thu, 29 Nov 2018 17:26:54 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQ5S-0001FY-SX
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:26:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 84EE36079C; Thu, 29 Nov 2018 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543512400;
 bh=/rXvkS8sf9L44rAhHmEAfHNG8RE5BNgzc8IcNYNTxzU=;
 h=From:To:Cc:Subject:Date:From;
 b=E3GuDkpmgvfYKjRgch1SdpERg4zLXGaJRlS7eIO5Un9s1YR5pLzKA0OlSyZC7MNbK
 jC9m4pGsYp/FofJ0DEy8zmCpSNrpaiEsIs7uE3ot1c9C52fn0tMqW+qKKrqhgjh/Iz
 NkOZDjiEEXuw0ibEKPs3HTPUTN2rhfD+Y12TZfHc=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 19A1060251;
 Thu, 29 Nov 2018 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1543512399;
 bh=/rXvkS8sf9L44rAhHmEAfHNG8RE5BNgzc8IcNYNTxzU=;
 h=From:To:Cc:Subject:Date:From;
 b=jRzFjoaY4V1S4VsGLJAMRKj0v8Js+sNNn4DsEjiPeTzn3mv3gsa9J0IxA8jBiYPwN
 LCM58u4Zd5DpiV2Z0z8wrdB9EMqDlfzEQzhdCI5uponQLHmXlk18FH9rohxucq6fiF
 Miw1PzmBSOVU0jdXxYXaPBGIkQyDNp0C44oUcWe4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19A1060251
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: georgi.djakov@linaro.org
Subject: [PATCH v3 0/1] drm/msm/a6xx: Add interconnect support
Date: Thu, 29 Nov 2018 10:26:35 -0700
Message-Id: <20181129172636.12839-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_092650_941345_98FAC7E8 
X-CRM114-Status: UNSURE (   8.77  )
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
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

(grr - resending because I didn't actually send the correct patch.
My fingers were going faster than my brain).

This is an updated version of [1] adding interconnect support
without OPP bindings to get maximum performance from the GPU.
Big delta here is that I stupidly confused Bps and KBps and
passed a value that overflowed the API. Correct bandwidth
values are now passed.

[1] https://lists.freedesktop.org/archives/freedreno/2018-November/004347.html

v3: Actually send correct patch with correct units
v2: Make sure to pass values in correct units

Jordan Crouse (1):
  drm/msm/a6xx: Add support for an interconnect path

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
