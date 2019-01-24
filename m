Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F5DC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:31:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B74218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WWTtM7Vc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cdysyle/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bczxgM06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B74218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=adt7zdUPy42HD6OsA6VCe8wkWrakdZdN3DUCimGi/as=; b=WWTtM7Vcn2yHjq6Kd3d2a1yN5
	9vpD+KwId/fcUDuj6CF5yo3EfUnILCvXBfhOrs9ri1ihOE0PpdQrdJswVAYt4EkrIJNsKJ5o213Dt
	q0JV6nPYlRnIS92l6SNk60hz3GKfnHDsjMWpMMM0IytzSDczicFEHgJ+Q0aLRJB5tcgRb0tyokh0P
	Hw/32j9Ng6LDz6Qu7172VzSET2tigmutGEYy0A1xmlBGvZUvkPooaWiqKbWc9M3FWsNL2x5cCHQFq
	n59DdvkHtqfoepwKTKmLVeozIAPv925WCx04CPDAm6EsOFoZDdL7bm9mMAipqYGqt5MXJaBr9cUEZ
	8Gtks+Tig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmjmi-0004Jd-NB; Thu, 24 Jan 2019 18:31:28 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmjmf-0004Iy-PT
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 18:31:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B67D5608C6; Thu, 24 Jan 2019 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548354684;
 bh=xuCijXfAk1T6OPLysp/p8ggboqusyrHlNrRZbB6m2YU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cdysyle/c/eiwVAHkstE4W/F2FdYw5LpQCkoAz1SC9jh/QpEzYCnxctfMmMfkklY+
 oi7Crx1MshK2MA8y9n7SWyhub7VP9ptAVHVssyktPm0Zl/MSWRX6LwzasaPkhdZ4Hb
 AQQCFBWIAX8lymVO8V8eh4F3U+OK9Qi5l7/yMwS8=
Received: from [192.168.1.101] (unknown [157.45.230.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 47D62607DD;
 Thu, 24 Jan 2019 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548354681;
 bh=xuCijXfAk1T6OPLysp/p8ggboqusyrHlNrRZbB6m2YU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bczxgM06CzAj3VAkb4WKdTCBYr1skicRoHtFMgClfqu3IvwvFFE/Eix1/wbakfkLQ
 IWdSCkCczdR3JL7tb3joiy8gm4uE6QdJwczr2StwLlZpg+I/bCkSVWi7RmnEtcSPvw
 vvegSmzjQ1fKwbr1o+HD5qI/s1zRFRYdAvPhppY8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47D62607DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
 <1bd39862-0725-70ce-6535-fdb59569f683@arm.com>
 <75ed74af-6946-b86d-092e-42dc16e55308@codeaurora.org>
 <91a90daa-9e14-2d2e-e633-2ddfdc0955bf@arm.com>
 <3906faf1-abbd-9c28-ad55-ed3800f06352@codeaurora.org>
 <c03b63bf-aca8-ea46-70ad-ee4558f0319e@arm.com>
 <5b54c6e0-7d22-ecee-486f-31333f49f84a@codeaurora.org>
 <CANLsYkxLJS-N0V4eOHM5rfe8MXMZHQApZFsDQns+DAS7xhGCoQ@mail.gmail.com>
 <71ae9f41-50ff-742b-3e12-ca2ce84e0d3c@codeaurora.org>
 <CANLsYkyeG4mZTJbFPnAsTNpt_2OBy5JYP6g80rbmZv-F8KTrUA@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <1384cbbb-6e3e-f2e3-5ea4-8d0b237d64c7@codeaurora.org>
Date: Fri, 25 Jan 2019 00:01:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkyeG4mZTJbFPnAsTNpt_2OBy5JYP6g80rbmZv-F8KTrUA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_103125_862008_04F4C7AC 
X-CRM114-Status: GOOD (  16.23  )
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
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 John Horley <john.horley@arm.com>, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Good day Mathieu,

On 1/24/2019 9:37 PM, Mathieu Poirier wrote:
> Good day Sai,
> 
> On Wed, 23 Jan 2019 at 13:18, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
>> Hi Mathieu,
>>
>> On 1/24/2019 12:44 AM, Mathieu Poirier wrote:
>>> On Wed, 23 Jan 2019 at 05:12, Sai Prakash Ranjan
>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>> That depends on whether the ETMs have been modified at all, something
>>> Suzuki has asked to be clarified.  If ETMs have been modified then we
>>> need to understand how they differ from the driver's implementation.
>>
>> We had asked hardware team for clarification regarding this. Let me
>> poke them again. As for the driver, downstream implementation also
>> uses the same driver, so I am not sure what do you mean by differing
>> from the driver's implementation.
> 
> The driver has been implemented in accordance to ARM's coresight
> technical reference manual and expects the HW to behave in accordance
> to that specification.  Here we want to make sure the IP on your board
> is conformant to the same specification.  If not then the driver needs
> to be made flexible to handle both kind IPs.
> 

The HW does behave as per the specification. As discussed in reply to
Suzuki, Coresight peripherals do use JEP106 ID of ARM for SDM845 and for 
MSM8996, the ID is of QCOM(0x70) since it was not based on any ARM 
derivative.
And the etm4x driver handles it all well. Other values of PID registers
are implementation defined and can be different from standard ARM cpu
core types.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
