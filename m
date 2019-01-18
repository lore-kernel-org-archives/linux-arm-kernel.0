Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFBEC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:00:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEE62087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GFTyIgh6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hckWqWdg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hckWqWdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEE62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jzo6pEpdQD651FIwQIIdwNCRj7UwEZ1XTjHSB+FXMmc=; b=GFTyIgh6l8wVEATJlQX8sqYye
	1JsRvCar7mVb4ytzRhWEGGt9RRfvshMtGmHn52rLuD52PXbvKtxbVbpGgOOl3O+9b7+I28LJUtaae
	AMly91YuU3rc1nJnuiYzRCdscW9pvdQzwHAuHWS9u3KRIpRdBZ1+bBxEaegl+dMKBMmd6fnFNgv4n
	3g625uUrPGXcyyHYJUEOQsYGpO58BBo9JmiqnkDLP0oaR5EHQ8yS4xGk/95KalvDCaVILkL25Tb1E
	mFaW+Uoot7nBiEFvxurKtd9N+8S9AygvgwX04eqncgNDtVun5cTNm1zAR4cqwaWLL2PVjycMWbD13
	iINfqbK/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkKOO-0003OT-TY; Fri, 18 Jan 2019 03:00:24 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkKOM-0003OA-1L
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 03:00:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B18FB607F4; Fri, 18 Jan 2019 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547780421;
 bh=Kmvy6jmyxSGe+B72xwSc13kkWmiV6lSKDp4kebtGVJ4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hckWqWdgfYwfwLvwqSGWza7/stYyIoEqaxCFU+Ppg4r1LNzmM9PQkh4tbuSjcxCTw
 CJdWh55xasiY37a+87aWTbRQ9oB8eVfkSW9QCGHuoxSdU6393Q6VxOr7NJc/bTjBPf
 0AAdukb77/fM6xemB4hct4fb7sgF6YWwnjlJyIgI=
Received: from [10.79.129.0]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E7D1605A0;
 Fri, 18 Jan 2019 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547780421;
 bh=Kmvy6jmyxSGe+B72xwSc13kkWmiV6lSKDp4kebtGVJ4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hckWqWdgfYwfwLvwqSGWza7/stYyIoEqaxCFU+Ppg4r1LNzmM9PQkh4tbuSjcxCTw
 CJdWh55xasiY37a+87aWTbRQ9oB8eVfkSW9QCGHuoxSdU6393Q6VxOr7NJc/bTjBPf
 0AAdukb77/fM6xemB4hct4fb7sgF6YWwnjlJyIgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E7D1605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190113072319.GB28907@builder>
 <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
 <20190117195027.GA12955@builder>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c7c33640-ae2c-eacf-0c91-a7537b5f16c1@codeaurora.org>
Date: Fri, 18 Jan 2019 08:30:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117195027.GA12955@builder>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_190022_098446_8CFFFFF9 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rajendra Nayak <rnayak@codeaurora.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/18/2019 1:20 AM, Bjorn Andersson wrote:
> 
> There seems to be some variations of this, but we try to keep everything
> sorted in sdm845.dtsi to avoid having to jump around between the various
> files. So please merge it into sdm845.dtsi (sorted by address).
> 

Sure will do it.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
