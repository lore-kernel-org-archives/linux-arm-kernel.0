Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA27C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695BD20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UwWxOtzF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mqov6+qj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mqov6+qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695BD20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HPdQr4RDV7+tpzWqgk8AFw8eryJ4kTTQztq23owJvmU=; b=UwWxOtzFa7T4o/986Rum64Poc
	ghfF4Hg8ylLbmrVWou2CmAgFFJqKVaBCiwBijmF4dNU7myZmXRgTer3veEy2/fRMNW78A/yWRx5k1
	CrViFxal9wDnHmDKjILvSF6r42aBlL13VMfHkffZsQG1ct9+NYMThB/iPnB9afr28t2kDebXkeEZk
	AQ1sc55sZF7RQHGveZ4+qoTGsAryWoc3qg9PM8zC3BQnEud343hSMeI/Vhp4qbKmOseV2nlJ0u8wn
	dLhCdCO4+sckq4VDYbvEax8u0fOL1yApFr2V/8hRUGETBr8CI1m+WQ8yXIAjzXn7lv3sgkj72972o
	6OmR0c9VQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRaq-0002un-TB; Tue, 15 Jan 2019 16:29:36 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRae-0002l5-Eh
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 16:29:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id CD45360995; Tue, 15 Jan 2019 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547569763;
 bh=UvXAVr5rAfYcmmPYgTtQFy9MuZWOaQi5am+NVzDZMm4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Mqov6+qjpmZKrAZcajDHX1ZW1s6UIdGD+XFxYXOQ7iPk3f6PGCMBGiVyewCv5WIzk
 10HJsWb56XciJCE+OyXx41wGZwm5yHC0ZiVSp5Kj3jAwe67gRPJjbFoLkXs7C8m2p1
 tr3qN2UekdJ0gtEo77WTDRgBy3RgzkJw5/SMyIwI=
Received: from [192.168.43.47] (unknown [223.237.252.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AFE6A605A0;
 Tue, 15 Jan 2019 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547569763;
 bh=UvXAVr5rAfYcmmPYgTtQFy9MuZWOaQi5am+NVzDZMm4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Mqov6+qjpmZKrAZcajDHX1ZW1s6UIdGD+XFxYXOQ7iPk3f6PGCMBGiVyewCv5WIzk
 10HJsWb56XciJCE+OyXx41wGZwm5yHC0ZiVSp5Kj3jAwe67gRPJjbFoLkXs7C8m2p1
 tr3qN2UekdJ0gtEo77WTDRgBy3RgzkJw5/SMyIwI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFE6A605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To: Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111184643.GA22691@xps15>
 <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
 <20190114153509.GA29374@xps15>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <f792b36a-4357-49f2-f242-8a7c8ed464a8@codeaurora.org>
Date: Tue, 15 Jan 2019 21:59:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114153509.GA29374@xps15>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_082925_437893_D578B4DE 
X-CRM114-Status: GOOD (  15.81  )
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
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-msm-owner@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On 1/14/2019 9:05 PM, Mathieu Poirier wrote:
> On Sat, Jan 12, 2019 at 06:21:00PM +0530, saiprakash.ranjan@codeaurora.org wrote:
>> Hi Mathieu,
>>
>>>> +
>>>> +	etm@7040000 {
>>>> +		compatible = "arm,coresight-etm4x", "arm,primecell";
>>>> +		arm,primecell-periphid = <0x000bb95d>;
>>>
>>> I'm a little curious as to why you need to bypass the normal AMBA bus
>>> discovery
>>> method by forcing the peripheral ID.  Tracers don't show up the way
>>> other
>>> coresight devices do at boot time?
>>>
>>
>> Yes on some Qcom SoC's like SDM845 and also on some previous ones, for
>> ETM(only) amba bus discovery method fails because of wrong pid read from the
>> registers. So we have to force this primecell peripheral ids to probe etm.
> 
> Ok, if that is the case please add a comment to explain the situation.
> Otherwise someone will assuredly ask again in the future.
> 

Sure, will add it in the next version.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
