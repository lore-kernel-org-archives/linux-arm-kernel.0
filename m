Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670B8214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VItjGOY/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fkyS88A0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RVwrDDvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670B8214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QWrOTPbFv8zIcc0MEcIUCMZAbRVYXEd1WpFPK70VO54=; b=VItjGOY/ixYWSUA1xOOebABDx
	qaBz+ux+iwHWrvHbqHXFB5nWMVsA09BASfzenu9P8EfRB222fFFQRYVApQGgjtU3BPOdx91iQmd7F
	+9/Wp1u9pBAA4XmxOZJ2cG6TSkV69xVP30yuFKfowwulAhOWNCNtKRXBQyiXBXfMIAp/3cJZA6W3P
	o0hLbkoa2r/QAatXe+G5iUgLXeYp5/t+c+jpd/Qttbet7AdHwgENc+gboyvZp+7rKYypSc5AEt4fg
	aQMz0rQtU3nVgEc3LIShRFnPzCRT+OhdWCIrkjO84snlvtgSuEvY3GvS0b/XJGl1IyjL65oAJHD8K
	JUiuXyR0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geydl-0004l8-Dk; Thu, 03 Jan 2019 08:46:09 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geydh-0004ka-Lk
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 08:46:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id F3BCE6087F; Thu,  3 Jan 2019 08:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1546505162;
 bh=v3/XmxYKS9nlth/LrbPm47Nzcl5F/8USVNeQz2p8Gx8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fkyS88A0gkVJX0cWDKGV/UaMPFjFodRVmONaDujkRJqfnmVMJrgwgkZ9oaInHfAyx
 2Qa+cMm9CCyipd/fqfAToD3Qg2SvfOXtjg5n6nsv/AGoTSxmhEHP4OdQXiVf3G2Fed
 lB7xgw9ODfMqW8LOg1mm/CMULWCe9gp5UOLRjPk0=
Received: from [10.79.129.4]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: rnayak@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 592446081B;
 Thu,  3 Jan 2019 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1546505159;
 bh=v3/XmxYKS9nlth/LrbPm47Nzcl5F/8USVNeQz2p8Gx8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RVwrDDvKp4gMxexIaV7zgfUCvviBI19JO8ZRCU8bQO0/o3K4/Jnfo4N+tdbywySdy
 Vem2jZO+VGByXH9+aYdT9B9sdHU/iJgPxDCst2CG5knbCLanSjsLYZV8cIexpKr2PJ
 CUreUfBMJYNo7ICUzdoJqebVNRUPLMAkt8rP/r9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 592446081B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu device nodes
To: Stephen Boyd <sboyd@kernel.org>, Doug Anderson <dianders@chromium.org>,
 Rob Herring <robh@kernel.org>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
 <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
 <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
 <154604698217.179992.9966831118584978893@swboyd.mtv.corp.google.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <dcb3e046-d0bd-af68-e42d-1db0db3bf2df@codeaurora.org>
Date: Thu, 3 Jan 2019 14:15:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154604698217.179992.9966831118584978893@swboyd.mtv.corp.google.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_004605_748119_8A0A22A2 
X-CRM114-Status: GOOD (  13.77  )
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
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <vireshk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 12/29/2018 6:59 AM, Stephen Boyd wrote:
>> So I am guessing the conclusion is to use a fallback "operating-points-v2"
>> compatible*only*  when we do have opp-hz along with qcom,level (as in the
>> case with gpu) and not have a fallback compatible in cases when we don't
>> have opp-hz (as in the case of rpm power domains)?
>> That seems a little inconsistent, and given Rob said either way is fine,
>> just do one way or the other and not both, I am inclined to think we should
>> just have a "operating-points-v2-qcom-level" and no fallback compatible.
>> Does that make sense?
>>
> Are you going to update the skip table to not create platform devices?
> Or introduce some generic property to indicate that this is just data
> and not a device node?

Is any of it really needed, given the bindings specify that the OPP table
should actually be a child node of the device/power domain supporting
it? I don't see who would end up creating platform devices for them.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
