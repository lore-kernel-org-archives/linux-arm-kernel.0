Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E90C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:32:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4974121850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lHuIKt8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4974121850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Mime-Version:References:
	In-Reply-To:Date:To:From:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lfPBXrSdW/KuJ7/9cCQQyBlolCli8e0dUui0ENyeDXI=; b=lHuIKt8dMVViwW
	YNZ36M9IJx3J/5JfQQFJHfcVwnnVXGyeMQGD4u2gGPByGNkOR9JSU3RKs/XsmaRliIgIjL6qY3e8A
	tdbZKskOcbPomRkok1E72VcyjJZtPFQM8i789ey4ub+soWBIIT9PaAZGe7Ld+tiwwonC8HpJwCMhb
	vEeTkzQ7hy/r+LGTMeIpITRbVMq1bKoV9sljP+jKF+EuURHlH8brfBukHgiQY0rOZFpfx2uHOFrW6
	GPbMwSucmxfdBcOrDnqQbscZZm6LLWs9QWAoB0wLW2DOvdN8ZjdfX3utRjLWJbkg9W2lch7+UgIvZ
	lNkfDfTjeZv+MezJs2qg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gykLQ-0004jk-Oy; Tue, 26 Feb 2019 21:32:56 +0000
Received: from baldur.buserror.net ([165.227.176.147])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gykLD-0004Uy-0Z
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 21:32:46 +0000
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gykJ4-0007gX-TM; Tue, 26 Feb 2019 15:30:31 -0600
Message-ID: <9aef7eea60ccf4a4aaa65e46e17b615aa73b5caf.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Vabhav Sharma <vabhav.sharma@nxp.com>, "sudeep.holla@arm.com"
 <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
 "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
 "rjw@rjwysocki.net"
 <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
 "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, 
 "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, 
 "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>, 
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Date: Tue, 26 Feb 2019 15:30:29 -0600
In-Reply-To: <1551132245-6089-5-git-send-email-vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
 <1551132245-6089-5-git-send-email-vabhav.sharma@nxp.com>
Organization: Red Hat
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: vabhav.sharma@nxp.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
 sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux@armlinux.org.uk,
 adrian.hunter@intel.com, ulf.hansson@linaro.org, yogeshnarayan.gaur@nxp.com,
 andy.tang@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v1 4/4] clk: qoriq: Add clockgen support for lx2160a
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_133243_426200_CD6C37EC 
X-CRM114-Status: GOOD (  10.03  )
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Andy Tang <andy.tang@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-02-26 at 10:11 +0000, Vabhav Sharma wrote:
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> 
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/clk/clk-qoriq.c         | 12 ++++++++++++
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 13 insertions(+)

Acked-by: Scott Wood <oss@buserror.net>

-Scott



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
