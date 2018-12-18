Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4ABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B07D218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XLKkn890";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeibXxXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B07D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1L4ALGrHwAo8gX/0/5w3387XigQgs1ZPsmD0JSiXtvw=; b=XLKkn890xGt87J
	5YfifTqhhq8be+Rq06vi9no9UgGCw2mDXkmJMcVCTBIpnFYom5fixpK/CXQyOh0MCAQscXi4fOrGc
	OdbnABZqUO/oWnQLEUVTyrMO8SYU0J5Uk7zQyw2R6W37YXaIx26j2B5IwjnAXDamPRyfD0ybRXrNm
	4+B7kEnrzruUlHPxMzkqtlQaaSLQI5ehYQGb/9OtkIFHUM1oiuC3OvKAu0zdij5BYCPOiQVm9657b
	laXYN9jcGstGpUe4/jJgFamm7gK3hptLtHG+lg2KafnZnvIPI0xD8DuREL/4UVOV4Sx8Bbw0HMTD7
	3iJZHK6xFsvdUGAsaGHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZNPg-0007aw-E4; Tue, 18 Dec 2018 22:00:28 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZNPc-0007Yd-2B
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 22:00:25 +0000
Received: by mail-wr1-x443.google.com with SMTP id j2so17515203wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 14:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NgNGzAIjC+h/YGa02m+8VUza7KfaHGEKOk/Q/RGkFyg=;
 b=SeibXxXRwP1rn7Y8dWILe0s04iu43wZy+/Ur6VThosHdeXBCXVWLNCTUiKJ4XN5ENk
 T913xZjN/lpvB4eBRRSbEngpCj4t2INWa7YnihA05C1CQ0yRtZiMPABS9LCHEVkncjw8
 XuOwP41hFmbcghVvW0SNVT/yK2eqShAEy1vXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NgNGzAIjC+h/YGa02m+8VUza7KfaHGEKOk/Q/RGkFyg=;
 b=tH9bC4GjRjgsbjYIMVA08EGPJwr6e9nuXgvt3dqqWDy3CoZPpkaiE88dWmydVYGHWa
 vgowEDIwEiKb1bnU/GLTw08rFv8NqZK9wBkQPvrDnc3jFhnWUcdllpuO4jz7XNnOInzv
 xAonXJ0KHDcfOSR0sXcsD/5IphTjVZIr8ByKJyrU91K0QDOt128ogM3ZrtnneV5fTG5Y
 iPIohttDAVkqoSf/1XayRv5VAMhfDdG2evlT7h/5vo3vGbV3wHEYnB73fYBydnv2TsfW
 zh5ZGaH/UCIP7Cq3zl1Fkv/kPaaxK5v4zn29sEUOdbGGdP4RBlq7BfcgqFxJ4TaoZmAK
 HhRg==
X-Gm-Message-State: AA+aEWYLGg4CHkcIiKZNJOZylXncScMFmwxlXuFVnGEIo2tazGOy3dO4
 W66WJ+30hJZbEwdnwn7G8NtVUA==
X-Google-Smtp-Source: AFSGD/VytNXtAxnX/T6GZAheVpg3PEwPewqOCV2CbG63DuIZDP6+4cZaomdBi6CmvMM5vCRBKsjnXg==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr16597120wrv.88.1545170411633; 
 Tue, 18 Dec 2018 14:00:11 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id x76sm7449158wmd.27.2018.12.18.14.00.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 14:00:10 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org,
	linux@armlinux.org.uk
Subject: [RESEND PATCH v3 0/2] Update AMBA driver for enhanced component ID
 spec.
Date: Tue, 18 Dec 2018 21:59:42 +0000
Message-Id: <20181218215944.2444-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_140024_106763_1341C21B 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The latest ARM CoreSight specification updates the component identification
requirements for all components attached to an AMBA bus. (ARM IHI 0029E)

This specification defines bits 15:12 in the ComponentID (CID) value as the
device class. Identification requirements now depend on this class.
Class 0xF: Traditional components identified by Peripheral ID (PID) only.
Class 0x9: CoreSight components may be identified by a Universal Component
Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
values.

Current and future ARM CoreSight IP will now use the same PID for
components on the same function - e.g. the ETM, CTI, PMU and Debug elements
associated with a core. The first core to use this UCI method is the A35,
which currently has binding entries in the ETMv4 driver.

This patchset prepares for the addition of the upcoming CTI driver, which
will need to correctly bind with A35 and future hardware, while overcoming
the limitation of binding by PID alone, which cannot now work.

The patchset updates the current AMBA Identification mechanism, which was
already differentiating between 0xF and 0x9 CIDs, to add
additional UCI compliant tests for the for the 0x9 device class.

Additional UCI structures are provided and added to the ETMv4 driver as
appropriate.

Russell: Do you want me to add these 2 patches to your patch tracking system?
Thanks
Mike

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (2):
  drivers: amba: Updates to component identification for driver
    matching.
  coresight: etmv4: Update ID register table to add  UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++-
 include/linux/amba/bus.h                      | 32 +++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
