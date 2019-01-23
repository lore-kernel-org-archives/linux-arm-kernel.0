Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80953C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500D721726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gV/KpOwf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/dbaVXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500D721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:Subject:Mime-Version
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zvfB7St4bld0UNvOP5J8bjYPOI1MFJFlqOP7hC4coUg=; b=gV/KpOwfRnUk5j
	xxPd0XB3P5/OJsdmTZOzL67DHHlDS8yGiKHx1/Hb1bed9qXK3LggtFv5CQ/OpKIfNSvHsGnXTEsjj
	GR+584cPOAsaZkJboUILzOf+94AdEdQjuQzJri50jpZ6VTQPevwg9Bssqe37CUBB/lNIcD3txnFsM
	sMenxOKdRlmqFcUfsxc3rHqBNJFr7WVIKFgxZSCT3vA8zjkUcrRWT6DCl88TsgR95HQMqOHnZPNZH
	KNKFNkTe6xqxwYys+KX+tFFiTa8EaTWjdvQIAWAGb3QlQmufjlRu9+YH5ffn/Xrd5vqHd7lSb+P6o
	mQm6f85wsnyjFydPAEog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFTR-0000WQ-I6; Wed, 23 Jan 2019 10:09:33 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFTN-0000W1-O1
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:09:31 +0000
Received: by mail-lj1-x22b.google.com with SMTP id l15-v6so1376989lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:content-transfer-encoding:mime-version:subject:message-id:date
 :cc:to; bh=jms5qnqxAq1xZU07QOG5j89zrljQhF+ZTehMWMHVKSE=;
 b=V/dbaVXdWVTYSXMhs85SFOBAsC/kzTjXxkPvhfL/hSMmbN8Bu2vSQEP01gUOYKyz+7
 eJ68ysmzAfj4coXhkuu0J3ZXOQXGw9i79SrJ8BEnzLQv8dwEXUpOqKHKX89PZQ0D6PVa
 t8aMR28uXuHB6codAMHQ0bw8t0tI8kUOlYzbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=jms5qnqxAq1xZU07QOG5j89zrljQhF+ZTehMWMHVKSE=;
 b=MXS1PyFHNBIZBi+T3Xge0CbFB8tsMsDwF/90toUo3WbywYe76m/H6okNq/G6mPtGhQ
 CjOh88jE/8xpZNZ7Kr0p1wDrYvAO0XtBNW//cDw1phn6ACjjanZHbVq+rWREwHWjoHq7
 TkUByRZu0GmTUjbUazAEDCXcgzsFCDj0Imzn9e2urfWZB9NzPioV12sZigRTFBPANGjq
 RheliEME5yBKly7OeS2NaquQ0kt2AHmItxx4zEYnXMlY8FXRUtY5y9q00pp6Vu7n8sX/
 THX/uNR2mv5W3mmyoT1g4mkzXHD/GI31HHeM83PsFQFSlZEss3oTQMaqPESQLZE7eCnc
 yedQ==
X-Gm-Message-State: AJcUukck8VKWeHlP5kkVYGadliALICaNeuqaXkUi+MMM6q52fc5fiveo
 VjrZnsSuEVZslyCOIHZpYQ8D
X-Google-Smtp-Source: ALg8bN6BrY5RcGe//C7GtqWRweU8SLpG+z+OfgmcZVUs679Lff70xbzQtAeqi60QegsCFXBkHYXkbw==
X-Received: by 2002:a2e:6595:: with SMTP id
 e21-v6mr1356929ljf.123.1548238167320; 
 Wed, 23 Jan 2019 02:09:27 -0800 (PST)
Received: from ?IPv6:2a00:1370:8116:154:7542:1ebf:5f75:980b?
 ([2a00:1370:8116:154:7542:1ebf:5f75:980b])
 by smtp.gmail.com with ESMTPSA id c15-v6sm425415ljf.76.2019.01.23.02.09.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 02:09:26 -0800 (PST)
From: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [BUG] Linux-next fails to link on ARM in allyesconfig
Message-Id: <0B66524E-5E31-4B9A-BFA5-B7F77264C967@linaro.org>
Date: Wed, 23 Jan 2019 13:09:25 +0300
To: Eran Ben Elisha <eranbe@mellanox.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_020929_781954_EE439E2B 
X-CRM114-Status: UNSURE (   7.26  )
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
Cc: Mark Brown <mark.brown@linaro.org>, Arnd Bergmann <arnd@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Eran,

It seems that your commit 880ee82f0313453ec5a6cb122866ac057263066b causes a link failure for ARM in allyesconfig.  This happens for at least gcc-8 and gcc-master compilers.
===
arm-linux-gnueabihf-ld: net/core/devlink.o: in function `devlink_health_buffers_create':
devlink.c:(.text+0x4eac): undefined reference to `__aeabi_uldivmod'
===

Would you please investigate?  Below is diagnostics from Linaro's automated bisection job.


Successfully identified regression in CI configuration gnu-release-arm-next-allyesconfig for linux between bad_rev 5b22549b8c0011b8cc81b6f4fcd082e5545c3225 and baseline_rev a37d50ca3b837c19a297f349365d11a20c1087d0 .

Culprit:
<cut>
commit 880ee82f0313453ec5a6cb122866ac057263066b
Author: Eran Ben Elisha <eranbe@mellanox.com>
Date:   Thu Jan 17 23:59:11 2019 +0200

   devlink: Add health reporter create/destroy functionality

   Devlink health reporter is an instance for reporting, diagnosing and
   recovering from run time errors discovered by the reporters.
   Define it's data structure and supported operations.
   In addition, expose devlink API to create and destroy a reporter.
   Each devlink instance will hold it's own reporters list.

   As part of the allocation, driver shall provide a set of callbacks which
   will be used the devlink in order to handle health reports and user
   commands related to this reporter. In addition, driver is entitled to
   provide some priv pointer, which can be fetched from the reporter by
   devlink_health_reporter_priv function.

   For each reporter, devlink will hold a metadata of statistics,
   buffers and status.

   Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
   Reviewed-by: Moshe Shemesh <moshe@mellanox.com>
   Signed-off-by: David S. Miller <davem@davemloft.net>
</cut>

Results regressed from (for last_good == cb5ccfbe73b389470e1dc11061bb185ef4bc9aec)

<cut>
reset_artifacts:
-10
build_abe binutils:
-9
build_abe stage1:
-8
linux_n_obj:
all
</cut>

to (for first_bad == 880ee82f0313453ec5a6cb122866ac057263066b)

<cut>
reset_artifacts:
-10
build_abe binutils:
-9
build_abe stage1:
-8
linux_n_obj:
17403
</cut>

Artifacts of last_good build: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/build-cb5ccfbe73b389470e1dc11061bb185ef4bc9aec/
Artifacts of first_bad build: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/build-880ee82f0313453ec5a6cb122866ac057263066b/

Reproduce builds:
<cut>
mkdir investigate-linux-880ee82f0313453ec5a6cb122866ac057263066b
cd investigate-linux-880ee82f0313453ec5a6cb122866ac057263066b

git clone https://git.linaro.org/toolchain/jenkins-scripts

mkdir -p artifacts/manifests
curl -o artifacts/manifests/build-baseline.sh https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/manifests/build-baseline.sh
curl -o artifacts/manifests/build-parameters.sh https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/manifests/build-parameters.sh
curl -o artifacts/test.sh https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/test.sh
chmod +x artifacts/test.sh

# Reproduce the baseline build (build all pre-requisites)
./jenkins-scripts/tcwg_kernel-build.sh @@ artifacts/manifests/build-baseline.sh

cd linux

# Reproduce first_bad build
git checkout --detach 880ee82f0313453ec5a6cb122866ac057263066b
../artifacts/test.sh

# Reproduce last_good build
git checkout --detach cb5ccfbe73b389470e1dc11061bb185ef4bc9aec
../artifacts/test.sh

cd ..
</cut>

History of pending regressions and results: https://git.linaro.org/toolchain/ci/base-artifacts.git/log/?h=linaro-local/ci/tcwg_kernel/gnu-release-arm-next-allyesconfig

Bisect log: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/bisect.log/*view*/
Artifacts: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/
Build URL: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/
Build log: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/consoleText

--
Maxim Kuvyrkov
www.linaro.org




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
