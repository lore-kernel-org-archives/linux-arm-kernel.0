Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E64C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:27:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E3B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i0PNCWeG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XZyRw0Hw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="icKgFDVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E3B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6wHbEW071jISCPm72v4i9+Ng6stGaDIVcrvZyMXDjQ8=; b=i0PNCWeGWweBa0TWN1Y1x7La2
	3hVMtLRHzK/xpcdV5IN8e/ehagxRAYMQvgGBCW+L3N2i78JZF+HL+3mIUkCWCjMWYUjoDnXtQARmG
	q8ffWLJhxRyUAbWAczfNn7fk/m98TjAxym005k+M7RHHTp5cR8LdYk44mn1b7oMgnTFEdShwbY+yr
	Z06viKLo6CCWpgLRo+z+WX7Jy2Bm3BfINemdF2OGQTptBYtLBql1cVeUIUBQUAlIclbXVQsQrkQSN
	qoO2c2z6TvdsQeAQZ68aiyrDWhJu2rm/I+UYnwTzMu4m1kOZiHH8Jk0gda4y1vTaakFWbVqmYxzXm
	NpDseZpLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRYd-0002Ad-T6; Tue, 15 Jan 2019 16:27:19 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRYb-0002AB-31
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 16:27:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 16FFC60866; Tue, 15 Jan 2019 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547569636;
 bh=HibyisDaHH+itZajGqpTFCELahWNFmaTiYbQu9hM7FY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XZyRw0HwGlkGX+NKCQPDFWwjiZIn6Yu4Ty1dt3egrSEX3vnQ1QMV9Vkrbtu+oElFZ
 58lSX5WVNhKe/PJp79IvKvmjm8kOemmIaoa8CbZaCxOBko1Rbxaj3OefTYShyQqIAq
 bBlV33PPd+SvC99eRTyoYZOfDS73eTLZODJf15ig=
Received: from [192.168.43.47] (unknown [223.237.252.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2037D605A0;
 Tue, 15 Jan 2019 16:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547569635;
 bh=HibyisDaHH+itZajGqpTFCELahWNFmaTiYbQu9hM7FY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=icKgFDVkm2h7YYOaslP8B2s4fVCTrNTKphOfbokzvWdy34SiB4+w8P20RsvJ79vTF
 V6B8mbzAfad4WEn6S3mcLt7htAN816oLVXOFn8DMjnjrDNrBHd7svVCtNk/1wkFEog
 jJ+4jNmMtKc/6VuMaR7dlBf3OwbPyN2MsK3MA8/g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2037D605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190113072319.GB28907@builder>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
Date: Tue, 15 Jan 2019 21:57:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190113072319.GB28907@builder>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_082717_186160_2A0DA428 
X-CRM114-Status: GOOD (  17.64  )
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

Hi Bjorn,

Thanks for the review. Please find my comments inline.

On 1/13/2019 12:53 PM, Bjorn Andersson wrote:
> On Wed 09 Jan 09:46 PST 2019, Sai Prakash Ranjan wrote:
> 
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Hi Sai,
> 
> The content of this patch looks good, but please fold it into
> sdm845.dtsi (keep the nodes sorted by address).
> 

I had looked at the sample from hi6220 for coresight and
decided to keep sdm845 coresight dtsi in separate file as it
would look much cleaner than mixing it with main dtsi file.
Also I guess it would make coresight topology more understandable
if we keep it separately (plus there are about 400+ lines of coresight
dt entries). Is there any reason for wanting coresight entries merged
into sdm845.dtsi file? If you still prefer it, I can make the
change in the next version.

> And mention below the --- that this depends on my AMBA bus pclk change
> and include the URL:
> 
> https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> 

I had mentioned this dependency in the cover letter. But I suppose
I can mention it here as well.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
