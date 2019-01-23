Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF8C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A603A21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o3WSO8iJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z10F3bFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HnWvJA3UPGPQvBBqfoDQKES0FLtb2SWLplCsuxz9FIc=; b=o3WSO8iJs0XCFS
	VpxyMmnjdbcvOEicZXtqXvGKvaZs3lLbvtaa6HOUybAtYoi8r72VtA4KSo+9v+bQs1hLrCG/hoXIa
	vDWXjR04AFGuPI543ArqrFJjJErA4Zddx7ZGNmFTYsvLmCxinqjGB3iYgvSFjQ8sMEcIH+pOAorfS
	H/nvvJgJR+zNcPAIqlgkC5IWEE+226jrcDvLZIb1roWCSkz9FPii/6Bww7au+JKPz1joMJV/il/Mf
	IBdlEOi8RsKyshDguD0kwRulzU1UV0l6JwYq0CduNoK7MNkJh50tTer/clnNBKpWvdCFC+o8UWxge
	TBIzE0pBZPrF2vPhDf3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFWt-00029R-Mw; Wed, 23 Jan 2019 10:13:07 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFWo-000296-Dw
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:13:05 +0000
Received: by mail-io1-xd41.google.com with SMTP id m19so1237672ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ciig/pZbs/m2T6PuwnFmh59A/zSXQ7i7i4st490pqUs=;
 b=Z10F3bFetGpfirbxDL1f109oTywBxm8u/HSaKAqHS4gyQ+PdY7powf4UaEj5DMKxcT
 nojfcZQ5v1JDg2/YIZqiE0hVzD67n28DtgX9cHuvWFzZth2PlB62uDd4ZlyvTXSbfRf1
 m6npjl5+124fKY6eO2/nAw8xzSximI4n2AgMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ciig/pZbs/m2T6PuwnFmh59A/zSXQ7i7i4st490pqUs=;
 b=gKEQhO+rbcP8uxvZJAaFlNYbkCP6xUxd4qjbSCQUJ18L8RMqmSCqIKOw+KX360iDvN
 Rxg+mZAx64OdgExd8IScdzEOsCQzo7HhkSAY8BYJ0E1F7pDtExRgB5okFEm0JM2K0Wsw
 BYc0mJC3uiXT28j3zZvikTn2947dauq2NwGdNcTYyIMY2dUFsg1c2Gzwk8yK8AtJPiL1
 F+1znApVM3XSWwA28x07Zv8+TwvYMbCNiiPAQdyun5vwmi51VA7R4XhZe1cco9lHW08u
 skqELyQV2t7cw4pvZY73k7BicY1yN2GbTv7MQ/HqTJEkaeJd0YJPgp1tJ8L2bgXtOmNM
 h/LA==
X-Gm-Message-State: AHQUAuazOKE3n8l28HOEMOSyP22GOtWXo6mVxbllcb5muq2wa9lbKLB0
 LI7xkpch19TmouTSPUSGAm5WYfJDnCyxUgd+niO/pA==
X-Google-Smtp-Source: AHgI3IZl2EPGZnrKj2if3lE9V+3tYjucG4hB+IeP9STBdUNuBLP5w9PjWy5McihLR/G7KW5AQlds1fcAN0XyQfAtKaw=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr857083iop.60.1548238380924;
 Wed, 23 Jan 2019 02:13:00 -0800 (PST)
MIME-Version: 1.0
References: <0B66524E-5E31-4B9A-BFA5-B7F77264C967@linaro.org>
In-Reply-To: <0B66524E-5E31-4B9A-BFA5-B7F77264C967@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 23 Jan 2019 11:12:49 +0100
Message-ID: <CAKv+Gu-Tp7YV2YMXozEMXDwfc5o6cXaQ9RbVrrYLg6JDabu_ZA@mail.gmail.com>
Subject: Re: [BUG] Linux-next fails to link on ARM in allyesconfig
To: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_021302_467205_6502DBC3 
X-CRM114-Status: GOOD (  19.25  )
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
Cc: Mark Brown <mark.brown@linaro.org>, Eran Ben Elisha <eranbe@mellanox.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 23 Jan 2019 at 11:09, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org> wrote:
>
> Hi Eran,
>
> It seems that your commit 880ee82f0313453ec5a6cb122866ac057263066b causes a link failure for ARM in allyesconfig.  This happens for at least gcc-8 and gcc-master compilers.
> ===
> arm-linux-gnueabihf-ld: net/core/devlink.o: in function `devlink_health_buffers_create':
> devlink.c:(.text+0x4eac): undefined reference to `__aeabi_uldivmod'
> ===
>
> Would you please investigate?  Below is diagnostics from Linaro's automated bisection job.
>
>
> Successfully identified regression in CI configuration gnu-release-arm-next-allyesconfig for linux between bad_rev 5b22549b8c0011b8cc81b6f4fcd082e5545c3225 and baseline_rev a37d50ca3b837c19a297f349365d11a20c1087d0 .
>
> Culprit:
> <cut>
> commit 880ee82f0313453ec5a6cb122866ac057263066b
> Author: Eran Ben Elisha <eranbe@mellanox.com>
> Date:   Thu Jan 17 23:59:11 2019 +0200
>
>    devlink: Add health reporter create/destroy functionality
>

That code uses u64 for quantities that can just fit into an 'int', and
we end up with 64-bit division using support code, since ARM cannot do
it natively.

Does the change below help at all?

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 60248a53c0ad..341dd14c13a6 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -3644,8 +3644,8 @@ static struct devlink_health_buffer **
 devlink_health_buffers_create(u64 size)
 {
        struct devlink_health_buffer **buffers_list;
-       u64 num_of_buffers = DEVLINK_HEALTH_SIZE_TO_BUFFERS(size);
-       u64 i;
+       int num_of_buffers = DEVLINK_HEALTH_SIZE_TO_BUFFERS(size);
+       int i;

        buffers_list = kcalloc(num_of_buffers,
                               sizeof(struct devlink_health_buffer *),



>    Devlink health reporter is an instance for reporting, diagnosing and
>    recovering from run time errors discovered by the reporters.
>    Define it's data structure and supported operations.
>    In addition, expose devlink API to create and destroy a reporter.
>    Each devlink instance will hold it's own reporters list.
>
>    As part of the allocation, driver shall provide a set of callbacks which
>    will be used the devlink in order to handle health reports and user
>    commands related to this reporter. In addition, driver is entitled to
>    provide some priv pointer, which can be fetched from the reporter by
>    devlink_health_reporter_priv function.
>
>    For each reporter, devlink will hold a metadata of statistics,
>    buffers and status.
>
>    Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
>    Reviewed-by: Moshe Shemesh <moshe@mellanox.com>
>    Signed-off-by: David S. Miller <davem@davemloft.net>
> </cut>
>
> Results regressed from (for last_good == cb5ccfbe73b389470e1dc11061bb185ef4bc9aec)
>
> <cut>
> reset_artifacts:
> -10
> build_abe binutils:
> -9
> build_abe stage1:
> -8
> linux_n_obj:
> all
> </cut>
>
> to (for first_bad == 880ee82f0313453ec5a6cb122866ac057263066b)
>
> <cut>
> reset_artifacts:
> -10
> build_abe binutils:
> -9
> build_abe stage1:
> -8
> linux_n_obj:
> 17403
> </cut>
>
> Artifacts of last_good build: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/build-cb5ccfbe73b389470e1dc11061bb185ef4bc9aec/
> Artifacts of first_bad build: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/build-880ee82f0313453ec5a6cb122866ac057263066b/
>
> Reproduce builds:
> <cut>
> mkdir investigate-linux-880ee82f0313453ec5a6cb122866ac057263066b
> cd investigate-linux-880ee82f0313453ec5a6cb122866ac057263066b
>
> git clone https://git.linaro.org/toolchain/jenkins-scripts
>
> mkdir -p artifacts/manifests
> curl -o artifacts/manifests/build-baseline.sh https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/manifests/build-baseline.sh
> curl -o artifacts/manifests/build-parameters.sh https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/manifests/build-parameters.sh
> curl -o artifacts/test.sh https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/test.sh
> chmod +x artifacts/test.sh
>
> # Reproduce the baseline build (build all pre-requisites)
> ./jenkins-scripts/tcwg_kernel-build.sh @@ artifacts/manifests/build-baseline.sh
>
> cd linux
>
> # Reproduce first_bad build
> git checkout --detach 880ee82f0313453ec5a6cb122866ac057263066b
> ../artifacts/test.sh
>
> # Reproduce last_good build
> git checkout --detach cb5ccfbe73b389470e1dc11061bb185ef4bc9aec
> ../artifacts/test.sh
>
> cd ..
> </cut>
>
> History of pending regressions and results: https://git.linaro.org/toolchain/ci/base-artifacts.git/log/?h=linaro-local/ci/tcwg_kernel/gnu-release-arm-next-allyesconfig
>
> Bisect log: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/bisect.log/*view*/
> Artifacts: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/artifact/artifacts/
> Build URL: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/
> Build log: https://ci.linaro.org/job/tcwg_kernel-bisect-gnu-release-arm-next-allyesconfig/12/consoleText
>
> --
> Maxim Kuvyrkov
> www.linaro.org
>
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
