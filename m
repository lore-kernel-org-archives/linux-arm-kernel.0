Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A75C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:15:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C269A20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrFPZHT2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="elQvZusb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TD6RlVOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C269A20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dzlNBAIqJv8EFqBkAWxxhOweRhLJjSUWxcg/+hVDAWs=; b=GrFPZHT2LjLz0++cewYm/jx4E
	uAvR07uOSVcIBncb2Ol6ZyR209lW02XJBpFUEPv7Zo23JNMqvUUwTP6J2v2zGpBQ7AxIXBu6uq8f2
	STfVc6fP3Sfcj73oGdV4Erx579TFAjd6cbCuYhRGqaX78X1rMnPrqqtzzGrnduOJrYqZUW8zkLJiq
	jlJ5+mfJfSr8Kc3Thy0JR+TyiP/6tqDxCnGVevfsa+lfVZv4lrkPRbN+IOoJCzYR2HOrpajSK3A1k
	Ui6pcK11mKgTCLFDEp0UtjQnc1/IIvyvS6rWxjUEt0n3iO601+1E2UB5rBjARqkRRRmMHDdxBWrc3
	sUiRRyhQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gryV7-0000jI-BV; Fri, 08 Feb 2019 05:14:57 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gryV4-0000iy-H9
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 05:14:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id D614060A71; Fri,  8 Feb 2019 05:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1549602894;
 bh=BN+IwVB+jo/hG86eIynovwh2uHK3TLFHFAxCWtsZUWE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=elQvZusbf5zGevwpXW6D0IFzzPKDo+14mI+HDk43IszCMrNTxnVmRg6sprzxKFL45
 5qeNCDEjFer5O7YOhZhLif+5h1jzCEi3aclmt6MYWQWDR7BNOp4MNP9nh3AxjG9Je3
 wDbz0cvnSKO3y4E4J5g6c9yAwFmp8WITqEhNXOVI=
Received: from [192.168.43.47] (unknown [106.206.90.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 916B56090B;
 Fri,  8 Feb 2019 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1549602884;
 bh=BN+IwVB+jo/hG86eIynovwh2uHK3TLFHFAxCWtsZUWE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TD6RlVOS7AaF0Di7rtX+HrbpQipfx9LAjmXTPM8GmEaKIqoB8rH9Azx38oM/VoOK3
 H/Gy8h20m7m5T/e7ty0v9OY78IUzURlwNLXj9WBampyYD+ffnjYc5z2m2YKk96hbig
 sD1GRp5b+GguBcqq+a86/jZIoIXuqf136omo/V5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 916B56090B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv7 6/6] coresight: cpu-debug: Add support for Qualcomm Kryo
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <53cf9d9d3b14f503a6c842754f3c55413f5a3392.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <CANLsYky9ujRyftg3WoeSWK37=3_k5hw9x=DV34P_YrUXCLApXw@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <d6f568ca-be16-ef1a-b83b-83b9a613582d@codeaurora.org>
Date: Fri, 8 Feb 2019 10:44:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CANLsYky9ujRyftg3WoeSWK37=3_k5hw9x=DV34P_YrUXCLApXw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_211454_600703_544543AA 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Tingwei Zhang <tingwei@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Mike Leach <mike.leach@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/8/2019 1:58 AM, Mathieu Poirier wrote:
> On Thu, 31 Jan 2019 at 17:55, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> Add support for coresight CPU debug module on Qualcomm
>> Kryo CPUs. This patch adds the UCI entries for Kryo CPUs
>> found on MSM8996 which shares the same PIDs as ETMs.

[..]

> I have reviewed your work and things look good to me.  Once again
> there isn't much I can do with it right now.  Please re-submit when
> Mike's set has been merged.
> 

Sure, thanks.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
