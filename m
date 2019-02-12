Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B00C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:06:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7451221773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="atV2XHb1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agX03Kic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7451221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R7S+zZ/LDlWeFHjjrkq/2ws1btZtLTw4X4xxa6BMXco=; b=atV2XHb1ffQ/mW
	7ZrJckYydxWHdU2ibbm4KCa+jdZqoj5H+ScSrTH8PGWJvPmOaGrESzigsVlTSpKXXliCpntDamEEp
	vIGLfQTHJPcxTG1skzEAGXaQksllQqU3ql5k27+2XZHBaWqg07fecaE4BCRrp7kfm86G6Af1Y8vUY
	7IY87OnaKoLuwL3Yus3Ix3dqfqWdt+DvbsdpKHCHBdO1Qo88NV32OiRwc19ifvhOj8M/wQkG6D+CO
	Ar9tYmMTV3UWhGpvk/XQfjnugWpapY6WkgItoG8bVQww3xfdwq2nAMP7N07nooBEDLsw8JyxmXWBf
	N8k4QdyUk9UxswDnv8xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVt2-0000Ah-De; Tue, 12 Feb 2019 11:06:00 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVsz-0000A4-5B
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:05:58 +0000
Received: by mail-it1-x141.google.com with SMTP id z20so6499741itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G4yDU+hUL+cuj6DpJEHrWPGvDff9Qw8iKrwsFRXi1zw=;
 b=agX03KiczM8PHh7y8RSNeld9k+XhbKRPGLE4eJ7PupCINkl5PDYYTfn6BWbTyUGZkr
 PCP7wq5nLukNXQyZHyZIhfdeYpt0ppijzYkRInwADPWPm5EJh/mdI5eHq3GZTA7iq7Mh
 YUdr3nECdGfAr9ekpUNCyDNm7Aptj2IOvKgUs3XVS9wu7c/t1dzfCHzkefFoojVkc1rX
 o1+GO2Bo1PZTX8N/i1EigjQltO7/uO12ECJVQC0BCPFIH45wl4593NxG9ekjD2KATw9N
 MQWGl6nO4++JJkpb+vZ845w2L/PzasWVvbESjQvRNqzN5Ktf7WMg765Ax+TTctWFAOPI
 /ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G4yDU+hUL+cuj6DpJEHrWPGvDff9Qw8iKrwsFRXi1zw=;
 b=p2IPk8r5yFcS0UzyONzi69uWhDB0/20dkUf25QVcYzb7d58rgs8nVL6wuexlsUn59z
 8pyxD8TIAi2BC/+WnUus3bPKa/inGNKOfxG2dAYLMCrTiel8LQ9BeSzCjTf8/x9CrLru
 4irdpeHcB78lMyvmWMcqDOyieujIXm7AjN1Ayoc3Ic8m0G3064H66in/91h6JehLKSdI
 dkb1fWFj17w1ySf36dLcG/oNTSvVSD9P5ZRGL/YK3enGeQ06vElspkzgtz1enXxQN3JD
 ZNxL/hP0oIrqw13IMoy9AZ4eGJAzNnroHjjGtFS1++orYHHnTRBq3EUV1OTPlaaIXhxZ
 P3uA==
X-Gm-Message-State: AHQUAubjtOkge7M5VmyPCZ3aZYrlCVti5+cPhw6FRLltCS3ZZygMGpln
 jVw5EdeyTH+G0sk0m49HUNCejDHwQ+PlH6/RZOLCDw==
X-Google-Smtp-Source: AHgI3IZurgQhEOK+TfyFADPqMafEVmczSCHE2QJq8H0RjEmIvpKswlxl4aSxnV9Ss/xw8xoMOK5r09KiUp/qQwKypUk=
X-Received: by 2002:a6b:6511:: with SMTP id z17mr1447769iob.173.1549969556183; 
 Tue, 12 Feb 2019 03:05:56 -0800 (PST)
MIME-Version: 1.0
References: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1548740978-28495-1-git-send-email-sumit.garg@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 12 Feb 2019 12:05:44 +0100
Message-ID: <CAKv+Gu_RJHb_FwTz+R1bXNQQMsoi0xxcKzn54NF5ib3z2xnH0w@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Introduce TEE bus driver framework
To: Sumit Garg <sumit.garg@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_030557_205832_7D456BD6 
X-CRM114-Status: GOOD (  20.71  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Michal Marek <michal.lkml@markovi.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 tee-dev@lists.linaro.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, mpm@selenic.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 29 Jan 2019 at 06:50, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> This series introduces a generic TEE bus driver concept for TEE based
> kernel drivers which would like to communicate with TEE based devices/
> services.
>
> Patch #1 adds TEE bus concept where devices/services are identified via
> Universally Unique Identifier (UUID) and drivers register a table of
> device UUIDs which they can support. This concept also allows for device
> enumeration to be specific to corresponding TEE implementation like
> OP-TEE etc.
>
> Patch #2 adds supp_nowait flag for non-blocking requests arising via
> TEE internal client interface.
>
> Patch #3 adds TEE bus device enumeration support for OP-TEE. OP-TEE
> provides a pseudo TA to enumerate TAs which can act as devices/services
> for TEE bus.
>
> Patch #4 adds OP-TEE based hwrng driver which act as TEE bus driver.
> On ARM SoC's with TrustZone enabled, peripherals like entropy sources
> might not be accessible to normal world (linux in this case) and rather
> accessible to secure world (OP-TEE in this case) only. So this driver
> aims to provides a generic interface to OP-TEE based random number
> generator service.
>
> Example case is Developerbox based on Socionext's Synquacer SoC [1]
> which provides 7 thermal sensors accessible from secure world only which
> could be used as entropy sources (thermal/measurement noise).
>
> [1] https://www.96boards.org/product/developerbox/
>
> Changes in v6:
>
> 1. Incorporate some nitpicks in patch #1 and #3.
> 2. Bundle all statics in a data structure in patch #4 and use dev_*
>    instead of pr_*.
> 3. Add reviewed-by tags for patch #1, #2 and #3.
>
> Changes in v5:
>
> 1. Add support in module device table for TEE bus devices.
> 2. Correct license for optee-rng module.
>
> Changes in v4:
>
> 1. Use typedef instead of single member tee_client_device_id struct.
> 2. Incorporate TEE bus nitpicks.
>
> Changes in v3:
>
> 1. Fixed bus error path in Patch #1.
> 2. Reversed order of Patch #2 and #3.
> 3. Fixed miscellaneous syntax comments and memory leak.
> 4. Added comments in Patch #2 for supp_nowait flag.
>
> Changes in v2:
>
> Based on review comments, the scope of this series has increased as
> follows:
>
> 1. Added TEE bus driver framework.
> 2. Added OP-TEE based device enumeration.
> 3. Register optee-rng driver as TEE bus driver.
> 4. Removed DT dependency for optee-rng device UUID.
> 5. Added supp_nowait flag.
>
> Sumit Garg (4):
>   tee: add bus driver framework for TEE based devices
>   tee: add supp_nowait flag in tee_context struct
>   tee: optee: add TEE bus device enumeration support
>   hwrng: add OP-TEE based rng driver
>

For this series

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

although I had to load optee.ko manually in order for the udev
autoload of optee_rng to trigger. Not sure where the discussion went
last time, but could we please add "linaro,optee-tz" as a DT modalias
to the optee.ko module in any case?

>  MAINTAINERS                        |   5 +
>  drivers/char/hw_random/Kconfig     |  15 ++
>  drivers/char/hw_random/Makefile    |   1 +
>  drivers/char/hw_random/optee-rng.c | 298 +++++++++++++++++++++++++++++++++++++
>  drivers/tee/optee/Makefile         |   1 +
>  drivers/tee/optee/core.c           |   4 +
>  drivers/tee/optee/device.c         | 155 +++++++++++++++++++
>  drivers/tee/optee/optee_private.h  |   3 +
>  drivers/tee/optee/supp.c           |  10 +-
>  drivers/tee/tee_core.c             |  67 ++++++++-
>  include/linux/mod_devicetable.h    |   9 ++
>  include/linux/tee_drv.h            |  38 ++++-
>  scripts/mod/devicetable-offsets.c  |   3 +
>  scripts/mod/file2alias.c           |  19 +++
>  14 files changed, 622 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/char/hw_random/optee-rng.c
>  create mode 100644 drivers/tee/optee/device.c
>
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
