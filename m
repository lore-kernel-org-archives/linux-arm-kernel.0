Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D4CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334042064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jLNatGaJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMP3kchM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334042064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eiBvEn41OGiQAzivEfVbFPCGwPZbZ7+feM6AndLiR/w=; b=jLN
	atGaJ8uiPRX+fdA3LKG8D2OCvFqlvQFsJqMqeHtn650X0hLGUNPkDlt0gjxuBoEG2eNVjCBnGP9/x
	kFcsptOjaIaZDMFpXo8W7QpImzl8hBa4AzhHsWmaMeVuFivkoQup6dxgSYVZfeInhHKu/W6yzCggN
	Ox2+DOW0nPer18oXkk9th7czPE0N1a2Er2gSKZYCghuMSncu8ESwrwW7Fq1WXrR3apZMCbRQAeGRN
	hF36ikHB52c9QBVJEOlnEjMOT/gDXF1DHGviIQCi7rbsz3+lt9RGFWOgWIZe+9r8BIXOkY2o9PLwN
	LuT1eNX4FMuHSjeGzlxj1AFQPaTE9dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvK9-00018E-GN; Fri, 11 Jan 2019 11:50:05 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvK4-0000j7-8f
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 11:50:03 +0000
Received: by mail-pg1-x542.google.com with SMTP id t13so6213414pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fq7MtF2ScfFMWpdvczijzx7e8y4b1AHJmZlcX4q9K6E=;
 b=MMP3kchMB/DsEDH6qKdnq4FW7h9C13s8fWAZrNzFO0A7fxdeLbdZNF8uE0IffLs8CA
 lyvM77ueEBR986Phanff3BbH9CXq5jsskuaPLrjnLUcIVqtPCup+3CfSk2IE5/vXM8lG
 Vgo5G2OojyHYYHxnG2Cta220tf0tN5US0+Ssg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fq7MtF2ScfFMWpdvczijzx7e8y4b1AHJmZlcX4q9K6E=;
 b=EKb8pk/qPU5bU2BvpNR+sA5SQ2Hn9nocmG1Qp5w0oD25FOQRQ5UYu3wSrvs+jOkN/w
 6SyOLyLVxJhy0ifc6xykI+Si8KxlRLB3cXEyjP7s48510Z/F4AptVsEvH/vdCRNu7G6N
 0VvVx4XfFYRIpjEgVV2S9bV/WGJ1hYw2BIl5e970+ynUlfPeRox10FxlvXDidGnBbLkD
 l6UJAtayEYdmlyRf3WkaU/lT/UmY001UQ4PamHd+bwSBF7/NQ5zonXTn57VZKBqOHhnQ
 GsxUgSNhOKicPrSuK75+AixgXnr8JTqX81QvHcR0lMAyMno1HG3cj2j6VGH/h+w8OQPr
 lsZw==
X-Gm-Message-State: AJcUukcEyjnjb+P8XVRAfI095xbLcgnWuuHzlcJjvrkgHi2RsbC6+DL1
 a+cSZ6aqBeB/6rqLBkqFhVTfI6jPhHM=
X-Google-Smtp-Source: ALg8bN4L4Q4YuEIyK/IxKjebItlbdc/puOKAnbLfwMhu7SK2SJW3WCIykfjif0Mkxoa4i93mfgFwRQ==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr13132854pgq.189.1547207398922; 
 Fri, 11 Jan 2019 03:49:58 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
 by smtp.gmail.com with ESMTPSA id b2sm143199988pfm.3.2019.01.11.03.49.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Jan 2019 03:49:58 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v3 0/4] Introduce TEE bus driver framework
Date: Fri, 11 Jan 2019 17:17:27 +0530
Message-Id: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_035000_310522_45396D25 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: mark.rutland@arm.com, Sumit Garg <sumit.garg@linaro.org>,
 daniel.thompson@linaro.org, herbert@gondor.apana.org.au, arnd@arndb.de,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, bhsharma@redhat.com,
 linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org, robh+dt@kernel.org,
 mpm@selenic.com, jens.wiklander@linaro.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series introduces a generic TEE bus driver concept for TEE based
kernel drivers which would like to communicate with TEE based devices/
services.

Patch #1 adds TEE bus concept where devices/services are identified via
Universally Unique Identifier (UUID) and drivers register a table of
device UUIDs which they can support. This concept also allows for device
enumeration to be specific to corresponding TEE implementation like
OP-TEE etc.

Patch #2 adds supp_nowait flag for non-blocking requests arising via
TEE internal client interface.

Patch #3 adds TEE bus device enumeration support for OP-TEE. OP-TEE
provides a pseudo TA to enumerate TAs which can act as devices/services
for TEE bus.

Patch #4 adds OP-TEE based hwrng driver which act as TEE bus driver.
On ARM SoC's with TrustZone enabled, peripherals like entropy sources
might not be accessible to normal world (linux in this case) and rather
accessible to secure world (OP-TEE in this case) only. So this driver
aims to provides a generic interface to OP-TEE based random number
generator service.

Example case is Developerbox based on Socionext's Synquacer SoC [1]
which provides 7 thermal sensors accessible from secure world only which
could be used as entropy sources (thermal/measurement noise).

[1] https://www.96boards.org/product/developerbox/

Changes in v3:

1. Fixed bus error path in Patch #1.
2. Reversed order of Patch #2 and #3.
3. Fixed miscellaneous syntax comments and memory leak.
4. Added comments in Patch #2 for supp_nowait flag.

Changes in v2:

Based on review comments, the scope of this series has increased as
follows:

1. Added TEE bus driver framework.
2. Added OP-TEE based device enumeration.
3. Register optee-rng driver as TEE bus driver.
4. Removed DT dependency for optee-rng device UUID.
5. Added supp_nowait flag.

Sumit Garg (4):
  tee: add bus driver framework for TEE based devices
  tee: add supp_nowait flag in tee_context struct
  tee: optee: add TEE bus device enumeration support
  hwrng: add OP-TEE based rng driver

 MAINTAINERS                        |   5 +
 drivers/char/hw_random/Kconfig     |  15 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/optee-rng.c | 272 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/core.c           |   4 +
 drivers/tee/optee/device.c         | 153 +++++++++++++++++++++
 drivers/tee/optee/optee_private.h  |   3 +
 drivers/tee/optee/supp.c           |  10 +-
 drivers/tee/tee_core.c             |  56 +++++++-
 include/linux/tee_drv.h            |  42 ++++++
 11 files changed, 558 insertions(+), 4 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
