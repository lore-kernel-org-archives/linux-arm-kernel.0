Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01404C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5F6218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+fvU8Qf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIcGm47b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5F6218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HObUGBPsIvhQrNaxPmaqPoXeevglcHs744CkyDuaLO4=; b=I+fvU8Qfchcfbe
	i3T376rV0tViIIbqIcRaxHeExby+VwQ8d+yd5bEZQuer176E2FwLj7fYAXqHK8KcZWEVrY/w2yT3k
	AK8neOXNv8fYyw0ND7f1Rtk79ZqWOfVyYV+CifsYPTXXMVz6BfXW0EBACxa6EUOG8rnHUSFCFSPNA
	lgQ7pQJ/5N7bD4VNI07kIkfparCl18jun1VgKB21hj4N3zV8dvHzox64RhHGor1Cm/Ew2TxspC09s
	AXsreE7nEn/ZBfsl0Zxl7zFAFWujoT9WwQByL28sZ74LgNd4CbWNg8Q8Tru7QyELhoQoryWE4AZ1y
	NFW1dao29BB/WY2w1ukA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gozTa-0005uD-Ar; Wed, 30 Jan 2019 23:41:02 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gozTX-0005t7-6M
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 23:41:00 +0000
Received: by mail-wr1-x444.google.com with SMTP id 96so1361369wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HoQpmnrQILE9VZn7UG83GWFanQbctVJxciTsFkrKO4c=;
 b=jIcGm47bwiYMa0K0tJp7cB1ARPhvZ6n8KbAZ7R+wIvmbX/x2T4jqp1+CIP4aOw6mm5
 wW5CNXjjvxUO0T9gm/eWtF8PYxkcQq9vPJCwZZIDBqRAhRjXHYUV0ExhTXab4exeU8A6
 awCtpgBE9mN0nfJC82BPx7Zom5n4kBEKBUYmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HoQpmnrQILE9VZn7UG83GWFanQbctVJxciTsFkrKO4c=;
 b=jrdmuia2YKR9nZeCElioy64RG+w5uEyzFJtsWDt+3ricO39QqI7hYFpM09vMHRaMfR
 1mua3Lfs1S8IpCA+jBvnkdV22PpiwwxAJbAio9s71byob5nmDl+1GutSsLL0Me+bW3Ab
 eB/qA5BkDDpFo8HM6E7vNQwUrBei3OQgUEIYgE5SkBfg8EtpsplXjqRfB2hqMwm1RUVh
 6+ziG8+fZyR8K5RcYIjPN9TOOGxo1tRFYbnlPtTdGvXtbGzsa4WxJLHfrYHosu3HBuuW
 KJ5rSAiRd6+YcZXMgVGmBb+yHWOP77zioM9cXsgLi3LSN1FmqrfnPI0dKGA0IWATf4DO
 fgLg==
X-Gm-Message-State: AHQUAuYgsPsoV9wtnNf9iSwDG+7nsCFO2iGvAmQIu1CHpdKW2IeW9Q6E
 u2xLEE1avuaZkrNyflM57nP8AA==
X-Google-Smtp-Source: AHgI3Ia9EW7qeAFQ4Tw73Cze4UYXFce9rWOtis57ZG1OR7zM1HfM+J0RttygLOkr+IZMCKhNrCfSdw==
X-Received: by 2002:adf:f848:: with SMTP id d8mr1285177wrq.178.1548891656790; 
 Wed, 30 Jan 2019 15:40:56 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 15:40:56 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Update AMBA driver for enhanced component ID spec.
Date: Wed, 30 Jan 2019 23:40:48 +0000
Message-Id: <20190130234051.2294-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_154059_257847_064BE60C 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: saiprakash.ranjan@codeaurora.org, arm@kernel.org, linux@armlinux.org.uk,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com
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
will need to correctly bind with A35, and reported new devices that share
PID for multiple components, while overcoming the limitation of binding by
PID alone, which cannot now work.

Patch 0001: Adds new UCI data structure and uses it with existing drivers
that use private data field in amba_id. This fixes issue from prior set.
Patch 0002: Implements the UCI matching code in the AMBA core code.
Patch 0003: Update ETMv4 driver to use UCI as appropriate. 

Thanks
Mike

Tested on DB410, Juno; kernel 5.0-rc4

Changes since v3:
Fix UCI structure to allow CoreSight drivers to set private data. This
fixes bug where none-UCI private data would cause a driver binding
mismatch. (e.g. STM).

Add CS_AMBA macros to simplify building AMBA ID tables, with and without
UCI settings.

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (3):
  drivers: amba: Updates to component identification for driver
    matching.
  drivers: amba: Update component matching to use the CoreSight UCI
    values.
  coresight: etmv4: Update ID register table to add UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++------------
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++----
 drivers/hwtracing/coresight/coresight-priv.h  | 40 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-stm.c   | 14 ++----
 drivers/hwtracing/coresight/coresight-tmc.c   | 30 ++++---------
 include/linux/amba/bus.h                      | 39 ++++++++++++++++
 7 files changed, 153 insertions(+), 80 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
