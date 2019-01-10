Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFEEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:42:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7DC20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PkrWHW1M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XbP+bcl4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WVBVz5nl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7DC20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e9J/lwasHulDbYIMG6WPdf47McL9jDz1W9pw3yHP7OA=; b=PkrWHW1MR/db6Zb2AmCo1XRMf
	ILfy7sEiXIbVgFmPGsEH+HDd7hzhdlAEvctWUbZgN5qMdJvVcVTPbuDuh+HgzOZe34DgLsd6huiqj
	5ooilpMreG7Qe/CIQbzkJ6x1uv6O9TmfeJXXN4Phi/9tDXLqG6zXQcMHClo3pGrr2iAW4TBXgovq1
	lVdg3UcU/zzFGSpihjpcFbOVutKrdEMtpQMXoTrH8gqgVh8KBRfQsawTtUsCT7FuqIZt4l1ZUmt+C
	liztECrzIuVGLF7s2CrOgoF2qXJICUsoudJ0cDHer+eTfnAtmyHDzRJUNHTfPJWGVTmtFEVYizPuv
	w99byhFdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghSBF-0007IH-Uc; Thu, 10 Jan 2019 04:42:57 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghSBC-0007Hv-AE
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 04:42:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 6BAAC6055A; Thu, 10 Jan 2019 04:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547095373;
 bh=yKZxbKxuH76RPO64h06mP584lP5CvpNQXbQHIafW3a8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XbP+bcl4uac0j+ATjJpgnQZPmeo3V8FSZmKvkYrdH7JOYnuX+/m1B38mLzJfxNUTS
 09EidbkJAgxFsGxVo+rAjclBdlI0S8cW6KwoXEeJgyoOyqhcIx3EDlS7asc+p7qeQx
 5m12iFyEb0s6qf7pUUIoT6d6xXQ973xshwlj9P94=
Received: from [10.79.129.145]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 112CD60386;
 Thu, 10 Jan 2019 04:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547095372;
 bh=yKZxbKxuH76RPO64h06mP584lP5CvpNQXbQHIafW3a8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WVBVz5nlRsrquHn9hKBAwhVd4b8rLJGNaThbLpHisUSDpP4QeNbGHcmDdDwiINFwb
 i5FxAcTbKCfOYDgABrD2+0ev+2XRU9svK5vyY71UYwMj9zN9v24zEgCartFaTTTMVT
 vjCuqyVQgMecsw49j5F1j0/dyDOrLgFW640sPR/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 112CD60386
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845: Remove the duplicate header
 inclusion
To: Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Andy Gross <andy.gross@linaro.org>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <5f400b3a15cab5dd071e4a129d38cb21e7123b78.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <b8762c0d-45f2-7f32-2d13-ce1bd1274e0a@codeaurora.org>
Date: Thu, 10 Jan 2019 10:12:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_204254_372770_CAB59235 
X-CRM114-Status: GOOD (  13.85  )
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
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, David Brown <david.brown@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Doug,

On 1/10/2019 4:27 AM, Doug Anderson wrote:
> 
> This was on my TODO list, but you beat me to it.  This could land any
> time and is completely separate from the other patches in this series.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 

Thanks for the review. Sorry I missed keeping you and Bjorn in CC.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
