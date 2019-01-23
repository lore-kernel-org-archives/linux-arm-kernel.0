Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90658C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:18:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4F521855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAtT2UTK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EUDQ0uM2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="amC/oJNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4F521855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nid8uP0BMKABtRKIMmwvKYJDBuSmlaPEYNn7CU1TQ6c=; b=YAtT2UTK1vrGRTLAVa3Txs6AX
	q+N0V20lE+3mcDLOBBLLl3ZOPvabFdj9AB1ZqM/pbHl9l5mTuwjEGYKziWex5ni+dgtAFvAxsNaZJ
	8t9A63eSxNbAvEb+bc91lvAAuDMFd7eTYjgACLXBmkqc4C+0Bk1/LtMnwtQQ4qL3i+3GZBt8UKOGS
	Szx28x5wZX9JVc/i84I1ONa2cCieQoD9P015L0ZOoieO3IcA7ihMnroteDudnMFSKE4x6wbUPJpRc
	Qa8W74ZH1RkIyFObKeo4mCIoRw7AdwfrYQmVW7XPjpz/x0Hu9f213vXMbcMK6GLkUjVv5Qw2tJ+fh
	R7/lJSQ/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmOyT-0006ek-9S; Wed, 23 Jan 2019 20:18:13 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmOyQ-0006X3-39
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 20:18:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id C0EFA608D2; Wed, 23 Jan 2019 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548274688;
 bh=bwlsh6JqLJpEtXi+NJKYQn4LeIj58d2W7GMwAqEFXr8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=EUDQ0uM2bVrhHk5F2Qj2QUV4FYXtrhYMaIeN2OM0+M/bmQRoe8vKxLavQZf/zUACA
 w+IYnFZL+XMU1gkvDXkYqlQVlRsBaBjZJpSlopKnVaQZSTRA7OT2ycUMVxHyt2mjJ9
 khqkSqpKffD6JldGXaLk4K4YLGt1IDwt/zy54mdA=
Received: from [192.168.43.47] (unknown [223.227.14.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E10AF60850;
 Wed, 23 Jan 2019 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548274686;
 bh=bwlsh6JqLJpEtXi+NJKYQn4LeIj58d2W7GMwAqEFXr8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=amC/oJNu4Cz/MLnw+j9r0X59y1TNT/PYk/rywVnihcbuvToCoHCsMGOo9iu7fYNnm
 4UVWXbeY9vZzxSrjUYzSw213FvPAWhZi/zJSL7QvuQJF9VRRUkTWfkGQcIreMU4lPZ
 dYISzhHMSBgZsCFjsDSTUIz5EwJzTtkRhiu7DYt8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E10AF60850
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
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <71ae9f41-50ff-742b-3e12-ca2ce84e0d3c@codeaurora.org>
Date: Thu, 24 Jan 2019 01:47:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkxLJS-N0V4eOHM5rfe8MXMZHQApZFsDQns+DAS7xhGCoQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_121810_177360_D82D2AD7 
X-CRM114-Status: GOOD (  25.02  )
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

Hi Mathieu,

On 1/24/2019 12:44 AM, Mathieu Poirier wrote:
> On Wed, 23 Jan 2019 at 05:12, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
> 
> That depends on whether the ETMs have been modified at all, something
> Suzuki has asked to be clarified.  If ETMs have been modified then we
> need to understand how they differ from the driver's implementation.

We had asked hardware team for clarification regarding this. Let me
poke them again. As for the driver, downstream implementation also
uses the same driver, so I am not sure what do you mean by differing
from the driver's implementation.

> If the implementations are the same:
> 
>>
>> @@ -1079,6 +1079,10 @@ static const struct amba_id etm4_ids[] = {
>>           ETM4x_AMBA_ID(0x000bb95a),              /* Cortex-A72 */
>>           ETM4x_AMBA_ID(0x000bb959),              /* Cortex-A73 */
>>           ETM4x_AMBA_ID(0x000bb9da),              /* Cortex-A35 */
>> +       ETM4x_AMBA_ID(0x000f0211),              /* Qualcomm Kryo */
>> +       ETM4x_AMBA_ID(0x000f0205),              /* Qualcomm Kryo */
> 
> What version of the Kryo CPU?  And the above will need to be in a
> separate patch with the modifications to address the problem you
> mentionned below.
> 

There is no Kryo version for MSM8996 (its only given as Kryo), MSM8998
onwards we have Kryo versions like Kryo 280 and so on. Hence I skipped
for this one and added the version for SDM845.

>> +       ETM4x_AMBA_ID(0x000bb803),              /* Qualcomm Kryo 385
>> Cortex-A75 */
>> +       ETM4x_AMBA_ID(0x000bb802),              /* Qualcomm Kryo 385
>> Cortex-A55 */
> 
> Please add them in chronological order.
> 

Sure, will do it.

>>           {},
>>    };
>>
>> For msm8996, cpu debug module pid returned is same as ETM
>> which is causing the probe failure for cpu debug coresight module
>> as shown in below logs.
>> For this case, I tried adding these ids to cpu debug driver, but it
>> splits some errors (coresight-cpu-debug: probe of 3840000.etm failed
>> with error -16) since the ids are same. Can we override for this case
>> or there is something else we can do here?
> 
> That is another problem.  See this patchset [1] from Mike Leach for a
> description of the problem and how to fix it.
> 
> [1]. https://lkml.org/lkml/2018/12/7/784
> 

Thanks a lot for this link. I will check this out.

- Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
