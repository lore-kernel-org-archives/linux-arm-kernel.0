Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841A9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:16:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52218218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XZfr2pq8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YvIXg1rB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ezgdqh8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52218218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vdf8ZW9HtPvKaJvRYZlRfX5ZcioGWfuPxCB+67YIPag=; b=XZfr2pq8oODMc0G3AxDTFaykL
	gk5RyV8mTsMNvtaYylyoMdPjaF2+n0OBk7bPAyKd9WczHpGwQKNuflmMj4vidkPJBOmUL3DnNTHOb
	4oF/ydvWjX64qgCUdD0wF8Uo7KSgJIuMfGeqpjEm7iDjG/P3GK+kw3V5yhxqtbOTWqFBqQx2N8PkC
	fi+VJJJQCggUEjVmBOMAXEfKWXrqOKPs5SYTFJWp7XjbivYLS+KGSdvdc6Crt4j/HQ8jPjnNYaL9B
	U88qrP/K2wmXSPnAjrpZiTNPShp/4oXCogc8JJwRxTJK1PP3rT/hqZDkpvW6U9W7SBx7XMmTEfIFS
	yT1YeuBPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCDA-0002dt-48; Thu, 31 Jan 2019 13:16:56 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCD6-0002dY-Uj
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:16:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 4B74E60910; Thu, 31 Jan 2019 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548940612;
 bh=7j3uvsjDcR92+OTtXjcZ+22TSj38+BwxBrGrYSGDZ/4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=YvIXg1rBOcxjD3R20T2Wqd/xvphh2IZ6mV7IhdVf9jlBj7gEi7vzvyrgkVC0ktECH
 affdckBTY2vRUAkhC+4rnmeH+fs7BwqO+2tcr1m1mX6Z7+Ee5iDTZ548vb8e0o+IV7
 kBZVJI2Y3Dry201RVRVlZq+/YkUjM2DInP18V0c4=
Received: from [192.168.43.47] (unknown [27.59.108.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E01BF60909;
 Thu, 31 Jan 2019 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548940609;
 bh=7j3uvsjDcR92+OTtXjcZ+22TSj38+BwxBrGrYSGDZ/4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ezgdqh8dUfNdGMmtMWMxpQQgz58Sb6Rq/n6kAYzlJdBHI7JZfyvJm1NBwfqemUKj7
 adNEuVmd92DDHNv+jECV/bMpKEUXzy7Fp89AN5vrZ2iEeoozIdY9NnHvTimYcZJnv7
 f3BnvH9Pdd+bKya5TuXydlVuzND2QAbdUAmLpOSw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E01BF60909
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 1/7] arm64: dts: qcom: sdm845: Add Coresight support
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190130183723.GA19234@xps15>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <6ba118d5-5b54-8b91-d003-3f56fae5b925@codeaurora.org>
Date: Thu, 31 Jan 2019 18:46:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130183723.GA19234@xps15>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_051653_024457_1F2B562A 
X-CRM114-Status: GOOD (  17.18  )
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
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Leo Yan <leo.yan@linaro.org>,
 Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mike Leach <mike.leach@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/2019 12:07 AM, Mathieu Poirier wrote:
> On Tue, Jan 29, 2019 at 12:43:58AM +0530, Sai Prakash Ranjan wrote:
>> Add coresight components found on Qualcomm SDM845 SoC.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>
>> ---
>> Depends on AOSS QMP side channel patches and AMBA bus pclk change
>> by Bjorn Andersson [1][2].
>> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
>> and size cells for soc") [3].
>>
>> [1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
>> [2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
>> [3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
> 
> This patch still doesn't compile for me.  In the above [1] is a cover letter and
> [2] is a patch that is part of [1] - what do you want me to do?  Add all the
> patches in [1]?  And how do those related to the dependencies you've listed in
> the cover letter?
> 
> I can't continue reviewing your work until you provide me with a tree based on
> coresight-next [3] with all the depencendies to get this set applied and
> compiled.
> 

Hi Mathieu,

Sorry to have wasted your time. There were many dependencies
with some nesting and getting updated as well, so in the next version, I 
will have my patches rebased on top of coresight-next and also I will
give a tree based on the same with all dependencies applied.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
