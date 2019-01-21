Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF6EC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:30:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12B821738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="muyOOBAk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bm2OnHA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12B821738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=eOli/mv0Ax9syPtYUWTLXEpuffQ7WXw53izoUozIrHE=; b=muy
	OOBAkVTxmA2QsgUub76fS/r+/p6T9YirSNh1GH7yolHnWz7XXJHSgNQoAsyD0CrHmT82KAjMPM+gE
	YrXysCk2ZNSKOfoLl/XovNENgfYg7Ko+Ot2IR1yiTG3YZFFD7Q/F9x4fJ2Jzsc0d58wEc10M+guSg
	Nf8Q8CgR6ymAGq1AFm0Y3J41ugpnggvqfEZhBGwIixevYZAm7VzGDhyeZATcvpjYNqaLtZGIje84n
	5PJrrXNgxaXYxLFSG1ZXvOfYea9GsRNhE6SemhdQwRmlvNCOxFK8/pNFOf9vtZLogjTFRxJi5/m5y
	IJov+BwQpMcxw60Te9Qh4mzrL0z+Z7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVu3-0003iJ-3N; Mon, 21 Jan 2019 09:29:59 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVtz-0003hj-Nk
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 09:29:57 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so9866627pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 01:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ezNTvp94HxKfIHnuTDGydgVtNdYFJn6q8Xf3NcPa2u4=;
 b=bm2OnHA3iMTFUED27Q3idWBXeh8Qos+EktXabpmpTUs33p0wICYqztSSpUPVGyn0ni
 fDlRIj+cxLoUVBl4ZguBFkQEaPWF0mHhmsGdi06pcOpCffcMKdcTcYwJQVohdak7YV47
 yqbCYv0KazcwxOlJYINw0M6QPfJTT/Fd5Yveg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ezNTvp94HxKfIHnuTDGydgVtNdYFJn6q8Xf3NcPa2u4=;
 b=TK+iGR0qd7YA3t/2NQuMl4+ieyn5LxscOUQbxYAHp6LDE61C+gepVXIzPofjlbETQt
 Wx6x3SPGj8HggkU36maBKkwqMxXe4f5qQ0nc7g53m0GwQKkH0r9fgxMhijfse7vbaMzq
 xnVKTTdPwCstLZuaQTemrb0L5QKxX5Q1QuZ9CIsW+UJsksVtOmAohGBgtAYw7DQ096cx
 r/qBHOoeuiA0LyAw7bK9R95NEiKJ2famXiEBodGRtprHOt2QR6LCroQIPDltNDFdtZwf
 3NfPszctfNz9kq/K05OI1OOAgS6kkn36ZOLNVcSgfVdd94FZC1wW5fvkOvOp0p8tGFTd
 KXgg==
X-Gm-Message-State: AJcUukfbS3AKli2zWR3xtEGnzLSwemFoXg93quL3nQtqvUgLlbD5jfw/
 Px90IShRLt64OQk7X/DHNtgLKg==
X-Google-Smtp-Source: ALg8bN5F+t/mRV0Mf1/foRV3v0b5kBnK/KF97jtxYUW6VhpyWS2UD2SuHvsQdpJXPIgAQ/y4pBi8CQ==
X-Received: by 2002:a63:5026:: with SMTP id e38mr27560627pgb.123.1548062993927; 
 Mon, 21 Jan 2019 01:29:53 -0800 (PST)
Received: from localhost.localdomain ([117.252.65.115])
 by smtp.gmail.com with ESMTPSA id h9sm16182777pgd.53.2019.01.21.01.29.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Jan 2019 01:29:53 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: jens.wiklander@linaro.org,
	herbert@gondor.apana.org.au
Subject: [PATCH v4 0/4] Introduce TEE bus driver framework
Date: Mon, 21 Jan 2019 14:59:15 +0530
Message-Id: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_012955_783285_078745CE 
X-CRM114-Status: GOOD (  13.65  )
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
 daniel.thompson@linaro.org, arnd@arndb.de, ard.biesheuvel@linaro.org,
 gregkh@linuxfoundation.org, bhsharma@redhat.com, linux-kernel@vger.kernel.org,
 tee-dev@lists.linaro.org, robh+dt@kernel.org, linux-crypto@vger.kernel.org,
 mpm@selenic.com, linux-arm-kernel@lists.infradead.org
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

Changes in v4:

1. Use typedef instead of single member tee_client_device_id struct.
2. Incorporate TEE bus nitpicks.

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
 drivers/tee/tee_core.c             |  58 +++++++-
 include/linux/tee_drv.h            |  43 +++++-
 11 files changed, 559 insertions(+), 6 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
