Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E71C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:50:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EC42177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rvq/3cBK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhrYi0zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EC42177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9JG0xzx+EQ+CFXhJlNPVl+l1GAU8xOHwGQudE/EvobU=; b=rvq
	/3cBKkOxwGLN/hWpwFfXUdpyke10SXZcDnErCRI+Vntkcs6SJ61aUg2lDKz181zuVOq9NdMNbuLxx
	kohDckbErs7Jf5AU9C3vhqx2fsNdweEfbDeB9z2xrlcukYORY56DiwbU1aEidf6t/MkpSKqgv77pY
	mfGhSC0/D53yTeTkJUZkhMXiL6UT5dn1Prj9jNy+GWtja4GNbvjAdbMylj5t+GoHYyoH7vJ1aB2AH
	rwteAWbxljVDVnrcP4qYMbktP3+da7D17GULQwJwPvwnZ72QkZe4XYgI2e9TCrs8LMIHC4koCZu0k
	vP4Z5QdkMgpD/t3CG51I5oDUJNco+Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goMHi-0005CM-9O; Tue, 29 Jan 2019 05:50:10 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goMHe-0004Zd-Vf
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 05:50:08 +0000
Received: by mail-pf1-x442.google.com with SMTP id 64so9155937pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 21:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=25+EHUW/QviVkEKkPntqDGS9uSaHWPwEdP3cMqn+uH0=;
 b=HhrYi0zkE1/W1dskxLTKFXudDjf1IrbxwRmZ1Dbox2C4stm/elFzLNyP9whCYtq+1w
 rWW9V+gSWoyagoaf4ITBQ+H1Ix7zqRvaimyBKm8RSBkxgcIKqYR82Q7bo09XNEoV5CSI
 K4vbY6+lhKzJg9ts7FySJ0ONgYDuC1HmkGCYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=25+EHUW/QviVkEKkPntqDGS9uSaHWPwEdP3cMqn+uH0=;
 b=YC/k69hF+9zUuVz0lwOQ95XYw0vLrchmixPA2c8xvZrcHeaZLJtpooClOmkFxwcFAr
 L+i9/LKSoQQEBckgNbqdAAFGYVAgwe13CFcxCWvp/dKilmQYdmLsNicusLbs9Z/CXoCQ
 d04A+oD8mCmCxkIVAdclEWkayr9FwkfI22iyPL/nkGIo3IueeZb0G2Kr5KlKY8+Vh0jd
 dwS9xS4njIkHvC7A3A0rM0j9QOuNOCiWCh5Bntlf5BTzhbjbLNe6OAaCqi/i+4So0sCN
 1C9NRcc9y/ByQiq6WVArLR0cxHBFqeYV6g0rH8Lf95rTDrukHbW9UbRqRh8Ud8mQMwBL
 ojxQ==
X-Gm-Message-State: AJcUukd2liNlMgLIbsP50i5FwKS680MFc2MSVS1vYk9BL5A1zhN7rG7o
 QjALpuEc1IZ7UVwBjJB/FSTudQ==
X-Google-Smtp-Source: ALg8bN5uf7lhKRp8F1xGSW2J9DBg7/knYKJdQQ+eIf6pqzX4vPltxwUfAWN1tnqNG5JMVZYGbHu1PA==
X-Received: by 2002:a63:c141:: with SMTP id p1mr22499168pgi.424.1548741005087; 
 Mon, 28 Jan 2019 21:50:05 -0800 (PST)
Received: from localhost.localdomain ([117.252.69.38])
 by smtp.gmail.com with ESMTPSA id y12sm57379437pfk.70.2019.01.28.21.49.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 21:50:04 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: jens.wiklander@linaro.org,
	herbert@gondor.apana.org.au
Subject: [PATCH v6 0/4] Introduce TEE bus driver framework
Date: Tue, 29 Jan 2019 11:19:34 +0530
Message-Id: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_215007_036985_2186E107 
X-CRM114-Status: GOOD (  15.06  )
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
 daniel.thompson@linaro.org, michal.lkml@markovi.net, arnd@arndb.de,
 ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, bhsharma@redhat.com,
 linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
 yamada.masahiro@socionext.com, robh+dt@kernel.org,
 linux-crypto@vger.kernel.org, mpm@selenic.com,
 linux-arm-kernel@lists.infradead.org
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

Changes in v6:

1. Incorporate some nitpicks in patch #1 and #3.
2. Bundle all statics in a data structure in patch #4 and use dev_*
   instead of pr_*.
3. Add reviewed-by tags for patch #1, #2 and #3.

Changes in v5:

1. Add support in module device table for TEE bus devices.
2. Correct license for optee-rng module.

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
 drivers/char/hw_random/optee-rng.c | 298 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/core.c           |   4 +
 drivers/tee/optee/device.c         | 155 +++++++++++++++++++
 drivers/tee/optee/optee_private.h  |   3 +
 drivers/tee/optee/supp.c           |  10 +-
 drivers/tee/tee_core.c             |  67 ++++++++-
 include/linux/mod_devicetable.h    |   9 ++
 include/linux/tee_drv.h            |  38 ++++-
 scripts/mod/devicetable-offsets.c  |   3 +
 scripts/mod/file2alias.c           |  19 +++
 14 files changed, 622 insertions(+), 6 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
