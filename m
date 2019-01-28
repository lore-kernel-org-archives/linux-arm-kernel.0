Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:18:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE44A20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aOXrN3FC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OgfZYls1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GVSd0MNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE44A20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8HaVGixLoNo2BiuVkmp0Tui1TsW96W45A9Fs7PG+jtk=; b=aOXrN3FCd5yeY8YqsJBFTC7hj
	Vv/fryUs80IhElc1N5wCU7ugWTKDt7f+cCVfWIogqogi31iRNYHYWunp3S8q2ZbPRpR2Qt6uQMzOL
	qPb9FQyNHjjjIBhU+7k/cuyxy6URYG8797fIB7IDpcFPtO35Y5l5kXGAMjJLnkulW5W1HWhNwy+jY
	PwoJvUZkCammwsCPKKTfwKNbJG1Y+5WuZrfxhzqgduecsrG/B0uPSC8sq+MdqA9aQNwVLhKWcIeyJ
	zKTi8rhGqk2LDtUPbw0coGfZXkQ2bdt6XAYzAwugAbR73tq12I2nEbzoBr7kKiSY3jEOo6Bobnwqr
	OA5yQITbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCQB-0002HU-Bf; Mon, 28 Jan 2019 19:18:15 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCQ2-0002Fu-JP
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:18:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 93D0E617DA; Mon, 28 Jan 2019 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548703085;
 bh=Kg7vvUwTktzmDpIqYZapRFXAV1l3wJ0DM/dbZeWt7EA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OgfZYls1pxplh+vVeXc1cFV3rXmE9d0Y38Bki/yeZXaR4dbpWJMCopYyssatYtBxg
 ckf2do08M3Uojc3Yh4hrcobIepg8UImveSSR5hPW1jwNQJbYiBaNPp5NiGYH2RQe01
 GCji1h9N4ezpO7cWYVZz25u3cGoBcIgkfm5BAWs8=
Received: from [192.168.43.47] (unknown [27.59.122.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 20FE76182C;
 Mon, 28 Jan 2019 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548703083;
 bh=Kg7vvUwTktzmDpIqYZapRFXAV1l3wJ0DM/dbZeWt7EA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GVSd0MNdP9hQcuV5UN1znOxxTpsAo4+Ck5QXvYYAyrlcO+y5vkYvw4Tbh//pqj9nX
 X0L8eH+OmjdTLiMaxFGQ/1xQSrsc9DhlZEMJzZ5IzyQSTUmQjrEO3eiVZ1TJGUqJhX
 k8IG//pcUCvR46wr2mQJjyqEnObe9eIBLtJ0YGqY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20FE76182C
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
 <18b70426-60fe-4871-6388-6e09fd5feb37@arm.com>
 <de6e021a-4f9a-8e2e-dff0-1e7c61ad8b2b@codeaurora.org>
 <CANLsYkxkTTfTMNNZZ1tmS=cjakcfveMDrW6wxXPXie8M9_VDOg@mail.gmail.com>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <eec64938-ef6a-a3d5-d93f-7a63df8b132f@codeaurora.org>
Date: Tue, 29 Jan 2019 00:47:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkxkTTfTMNNZZ1tmS=cjakcfveMDrW6wxXPXie8M9_VDOg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_111806_757833_1EA7E1F3 
X-CRM114-Status: GOOD (  13.90  )
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
 John Horley <John.Horley@arm.com>, Doug Anderson <dianders@chromium.org>,
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

On 1/28/2019 10:45 PM, Mathieu Poirier wrote:

>> For SDM845(A75 based):
>>
>> *0xB_B8_03* does indicate that the JEP106 identification
>> code is 0x3B and continuation code is 0x4 which is of ARM and not
>> QCOM(JEP106 ID is 0x70) which is expected.
>>
>> And the other values of PIDR0[0:7] and PIDR1[3:0] are *Implementation
>> defined part numbers* and can be different from ARM A75/A55.
>>
>> I think this clears up case for SDM845.
>>
>> As for MSM8996, it is not based on any ARM derivative and hence the
>> JEP106 ID is of QCOM(0x70) from the value of pid = *0xF_02_11*
>> based on PIDR1[7:4] and PIDR2[2:0]. This clears this as well.
>>
>> Please correct me if I am wrong and also let me know if I can
>> continue with PID addition to table.
> 
> Please proceed.
> 

Thanks Mathieu, posted the next version now.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
