Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D7EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:04:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252F02086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XTY71VLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252F02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AOmRPtYee9QpDIKF3FNJiMR6GM1UMc+kPrAJYtMkGeA=; b=XTY71VLCTDSR4eygjkqAt1cOS
	U2iLRL1AF83D7YE85hGhdc2JElU5BOcOXfUReobHryzRPodnDKD39RQYZ1vLsQRC1LW6grfbWcSG0
	QFmBJdd/P5aZ0JTLOUG+dsq9eadaiELO2TTRyqz83OkkXdrX6ncAfbMCgAJSoLpNdmU6sug3QUzjH
	rIy5SizlzbGeFVG0qrKatWyyspJAvJWKdnH0QIVFVfiPbdw22+z5y5uIwLUuuhVfsTEu/mFVEer/j
	KHd4z1NmMHF5izMxFWY3gUI1eJ9GHFmPcPJJI0YhN6PYI7pXfwYi5M6quJNvJHkaKLl5+v20JjaDW
	FuB89+lAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkSsz-0007o1-MT; Fri, 18 Jan 2019 12:04:33 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkSsw-0007nK-J2
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 12:04:31 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59CED80D;
 Fri, 18 Jan 2019 04:04:25 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4E43F557;
 Fri, 18 Jan 2019 04:04:22 -0800 (PST)
Subject: Re: [PATCHv2 2/4] arm64: dts: qcom: msm8996: Add Coresight support
To: saiprakash.ranjan@codeaurora.org, robh+dt@kernel.org,
 mathieu.poirier@linaro.org, leo.yan@linaro.org,
 alexander.shishkin@linux.intel.com, andy.gross@linaro.org,
 david.brown@linaro.org, vivek.gautam@codeaurora.org, dianders@chromium.org,
 sboyd@kernel.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com
References: <cover.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <552e408950525b1bac39d05b8b4f2ae1975397e0.1547798966.git.saiprakash.ranjan@codeaurora.org>
 <1311e78a-21f6-6470-7861-39b3499974ce@arm.com>
 <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1b7d4c2f-98f7-4b80-4e32-6e0fe5c906ce@arm.com>
Date: Fri, 18 Jan 2019 12:04:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6543ad5c-bbcf-b3ec-332c-115e8e3d0825@codeaurora.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_040430_634720_E592318B 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org, sibis@codeaurora.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 18/01/2019 11:48, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 1/18/2019 4:27 PM, Suzuki K Poulose wrote:
>>
>> If you want to use the scatter-gather mode, you must add
>> "arm,scatter-gather"
>> property to the node here.
>>
>> Have you tested the scatter-gather mode on the chip ? Does that work at
>> all ?
>> Note: You could try this by setting a buffer_size > 1M for the ETR and use
>> it as a sink from the sysfs mode.
>>
> 
> Yes the chip supports scatter-gather mode[1]. But is it required in
> dt node since it's an optional property?

If you would like to use the scatter-gather mode, you must specify it
explicitly. We have had some other boards with broken scatter-gather
mode integration which causes mysterious issues when used. So we have
a white-list approach for enabling the scatter-gather mode in the driver.

So, if you have tested to make sure that the mode works fine with a recent
kernel version (v4.19 onwards), you may want to add the property.

Suzuki


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
