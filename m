Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A50C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B612C214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1Zr/3Im";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOdGPWmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B612C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=H322Jke3zlm/HDyyRlUR86ZD+41i0c5SIznAJ1kQ9qk=; b=A1Zr/3ImMa58I1
	+X+oPf4V94Bx/9Eo9DhlI7eGeeIkarWbN3J7SURYdvZbXrknaT5cnmPbf68i/dTZDxBu9vG58VWzV
	ovk7fi8MUTcY28yFGjTKUOivYYZBUAOz3Kr9CV8HO6wt2UAe06Ss9aePQv+VES07vJ5xD6b1g5GXe
	MX/6L0CZ0ob8l84fWyDWpNMMoTTKECEvfZGeppy+IIxAx5DbPz09RPB6KMOYRyyfogNLoquVOk8Ty
	vp0hpFSlhm4hrdFPJ5OhqKgTnfulEFHAAEgQENHrOo1QK+JOvNgLnFXTvWzvRWz7A9zELs1MIT4rm
	azXDyw46Z7y0Raxtx8og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqa3R-0007qX-Ju; Mon, 04 Feb 2019 08:56:37 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqa3O-0007pn-Nn
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 08:56:36 +0000
Received: by mail-lj1-x231.google.com with SMTP id t18-v6so10896288ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 00:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=hLZSdf+huKW5dk/MnY/yKzWtbwn39zq8nIfDIBeCUto=;
 b=aOdGPWmJHU8ok5sydy5afbjZMQydKSEyxhOR4CyGcp0iVBEkJvuHkKNKviowz8lS6F
 LAZoT3cDdA18tWxt8VcWqv5Ub0V8y5NxcD1jg3RXa9q2PtNCwNBY7AZfJTPXxDui7MU9
 LiC//X1DK+J8ZUwB1PmMw/1II5jI9DlEfYF/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=hLZSdf+huKW5dk/MnY/yKzWtbwn39zq8nIfDIBeCUto=;
 b=bbOFuDCxMT32Xmm4tzBcIdKRmm+pUMWY8LNYRj96qGJ7HgTHHCfdPx7WQDG2r/5uia
 75FLqoeNu7XOWi4E6c8EAvyGgcY4vOUO4JBdBrYz33cXPR4+On1G0ac7jf1ty8qmh3dz
 DISF0NV+M7+4diX6Y+7cYyt+cqYf9R4Axmc0K/pL8xKYTiaYWws2/51akXnsBI2ukcgw
 E9CLFFxaZNMe9UKFTpS1gqeDPGMkDtrbGkgzTp0MkoaLuPEKMYgrU7MXPCHFdGQHMLg2
 mcs/xkMMmNG0KnXTlJJWlcb1AIte07kelLslqwZzspuoTHVkBr128gaDaYkxdE6jT+8T
 NB9g==
X-Gm-Message-State: AJcUukcfKEEbFmHxXA51nej2gSV3wfSd/mGs5TC+nWs9CAg2eNlsklPn
 n96Pue/3S/7MwHRFW2cmC6UHIg==
X-Google-Smtp-Source: ALg8bN4aQBbTsF3jHkNXIQLqygVQGbzHuJKyX2DaL28aKeSCqzWUFbqZO++T+HJ/AUy8h9MNQZ4VLQ==
X-Received: by 2002:a2e:9d8e:: with SMTP id
 c14-v6mr41075705ljj.146.1549270591801; 
 Mon, 04 Feb 2019 00:56:31 -0800 (PST)
Received: from jax.urgonet (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
 by smtp.gmail.com with ESMTPSA id c77sm606778lfe.23.2019.02.04.00.56.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Feb 2019 00:56:30 -0800 (PST)
Date: Mon, 4 Feb 2019 09:56:29 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm-soc <arm@kernel.org>
Subject: [GIT PULL] tee subsys for v5.1
Message-ID: <20190204085629.GA14098@jax.urgonet>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_005634_772664_31ECBFB4 
X-CRM114-Status: GOOD (  15.50  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello arm-soc maintainers,

Please pull this TEE subsystem enhancement. A tee bus driver framework
is introduced in order to support an OP-TEE based RNG driver.

The last commit makes changes under drivers/char/hw_random which
also are acked by that maintainer.

This time I've relied on others to review the bus driver framework.
Please take an extra look at it if you can spare the time.

By the way, I've just renewed my PGP subkey so you may need to refresh
it in order to verify the signature.

Thanks,
Jens

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-bus-for-5.1

for you to fetch changes up to 5fe8b1cc6a03c46b3061e808256d39dcebd0d0f0:

  hwrng: add OP-TEE based rng driver (2019-02-01 15:12:46 +0100)

----------------------------------------------------------------
Introduce TEE bus driver framework

- supp_nowait flag for non-blocking tee requests
- The tee bus driver framework
- OP-TEE TEE bus device enumeration support
- An OP-TEE based rng driver

----------------------------------------------------------------
Sumit Garg (4):
      tee: add supp_nowait flag in tee_context struct
      tee: add bus driver framework for TEE based devices
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

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
