Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406EC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:35:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110CA2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RG5q7aB6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZbVEfgnV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G8e36OFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110CA2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NTEsEZIC8qMQZvJfsYe5z/xDskCQo99Gk0WEXZXn/bM=; b=RG5q7aB68h58ajdpPQ1nBr243
	951lNcQ6XeCWFFbd/dBUtIZJVPOFEYaa8BDKoWH/6H84jbPSp96F6QL3VqG7r/5NL4cgbU+WL1YTM
	clVOnF/r5XzMiy2OPY+Ag4sbmmYDePrZ1/nb0cq8+2oc1QrF0fq1JnCQh2PhM6QBQAOV6tpzciNsX
	www0tb1ZggI5dFTJQTTminTo6b0EEFV6EaL2fpvjTt8OxoQalmnscuPdSY3+UaYYsCXY20W0ocU9e
	cKBqneNN1KCiijiEjXiwCX9q1AmDbNS1LaQZ6Cyal2XRpeq1aapbm1UazrCx3PRmeDnqA9pdSufQZ
	fHsuEJw0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goL7j-00056V-1X; Tue, 29 Jan 2019 04:35:47 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goL7g-00055q-O2
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 04:35:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 5160360881; Tue, 29 Jan 2019 04:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548736541;
 bh=5u4g+WUouOUxOpqRHhxuGu7sPHEixJtAN83EGTCKbF8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZbVEfgnVlTAELlKyPRkW5NMpofuOLPrKiuzsN1r1Xi+f6W/LDFYOhZZtu95C71QGO
 QUFcmGRCpOyeBSlgJAwuxxwOgRIlLdIWaqoT47Kxi8ZNWNuyaBaDhidRQU+o9J+IZk
 quNJUJsYV1kz9MHfUGMWgB6JfeJeW6bkP8avIl4o=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 by smtp.codeaurora.org (Postfix) with ESMTP id 58A216055A;
 Tue, 29 Jan 2019 04:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548736540;
 bh=5u4g+WUouOUxOpqRHhxuGu7sPHEixJtAN83EGTCKbF8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=G8e36OFbejBun8UviwuPp+PhFtIvDA1JORd2YC5gwpFISZC38fXnhaFHrHKac9lAk
 208v/talaupLJqY2+xxfnf8c7A855d77IlCXkrt26L1NYZ/LYVwxzE11pKiy22ew1t
 f4Kxd68WQjvIFXPSvmcqYlQWmZjPJEUpdin1yawU=
MIME-Version: 1.0
Date: Tue, 29 Jan 2019 10:05:39 +0530
From: saiprakash.ranjan@codeaurora.org
To: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCHv5 7/7] arm64: dts: qcom: sdm845: Remove the duplicate
 header inclusion
In-Reply-To: <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <d0370bc569491d11827a6eb12a75a236c3d60a0e.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
Message-ID: <21171aed64071e5c83376de5a280b134@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_203544_805437_0300FAB8 
X-CRM114-Status: UNSURE (   6.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Sibi Sankar <sibis@codeaurora.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-msm-owner@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
 devicetree@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Leo Yan <leo.yan@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Doug,

On 2019-01-29 00:54, Doug Anderson wrote:
> Hi,
> 
> You can probably stop sending this one.  It's in Andy's tree now.  See
> commit ea0edd7e63f4 ("arm64: dts: qcom: sdm845: Remove the duplicate
> header inclusion").

Sorry, missed this one.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
