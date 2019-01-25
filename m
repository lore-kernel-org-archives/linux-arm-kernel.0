Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F814C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:21:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2754218D2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZqV15OMC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nLhckvrE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gVjTnLoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2754218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VuMyIXlJYFn2yLN7kdPyVHVTPd0se8l2rDF2ipg8kMg=; b=ZqV15OMCox2hcg7aLn/UrWHkU
	3KSb+WBHBSPzDdynK72QoIoiMeTdtn6cBpstqLn6KXHYg5gpjZ6TSiDxTH9HBeTkYLOILDoA6XB8W
	XXJa0Ia8HMFpB186Qxz2Fg2bzWk3ntOrFUCxBjyzA8baqgUL1xSIP6CTDhPemZXjsU0e+LEAk5+DX
	0tCgg8uMGh3odJBniuxLJ84GkF0I3cke1CeAmZZG2GYlzeOlD8YXDe9qVrqlwPvZm2JMbO8ZVdt2C
	R3zA8+gpXmB0KEM7K7wjiQ4UX5ELv6/Qqj1Bybhbi9GD0tzDeUmEtWiaIO0YCJu3/5y3WikMwkdnw
	2Ydf3A1HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmvnP-0003zn-6z; Fri, 25 Jan 2019 07:20:59 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmvnM-0003zT-1Z
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 07:20:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 25CAD60735; Fri, 25 Jan 2019 07:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548400855;
 bh=8JLDzK7/igH177ZVH3VATrYgg/5oll7iVUf3eezsxdw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nLhckvrEemRDHJ+5F17fbz8s9uGBssdsv+oNf6LdFT+mUjGk87dqAjCiGITp4JtK2
 /jGzxwRj5ZpUT/e6xppJppsXVet7H9T47m+BxMODyTX0OLf1nS9BXm4ttOLEOKNlJb
 nk2AfnvqFyyA+jegz1kFzQ8NeoHkh1dDN/9S9QFM=
Received: from [10.79.129.250]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 86EDD60312;
 Fri, 25 Jan 2019 07:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548400854;
 bh=8JLDzK7/igH177ZVH3VATrYgg/5oll7iVUf3eezsxdw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gVjTnLoLQa4Maa5qkF3rBBJeqg/BIRlKy+I1s3vyu/T9/0H0WXQ90hu3FkJqdiNFR
 mRnkvWBzH4SoGSFNXO6r21RYOQA2tzrA9NGGkiZuO480Gj3F39TNz9KcfmPvWQ2q8a
 iBoXx04/AM+ThK/ZH4feS56z/qziy6kPLse+Vte8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86EDD60312
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RESEND PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
To: Mike Leach <mike.leach@linaro.org>, linux@armlinux.org.uk
References: <20181218215944.2444-1-mike.leach@linaro.org>
 <20181218215944.2444-2-mike.leach@linaro.org>
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <353c8f4b-f48f-863c-7149-342b764a02c0@codeaurora.org>
Date: Fri, 25 Jan 2019 12:50:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181218215944.2444-2-mike.leach@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_232056_120416_28B734BF 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, mathieu.poirier@linaro.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mike,

Thanks for the patch.

BTW somehow I can't find the latest series in my inbox, so commenting
on this here.

Mathieu pointed me to this patch series.This solves CPU debug module
sharing same PID as ETM on MSM8996. I will be posting patch for CPU
debug UCI table soon.

But please find my one comment inline.

On 12/19/2018 3:29 AM, Mike Leach wrote:
> The CoreSight specification (ARM IHI 0029E), updates the ID register
> requirements for components on an AMBA bus, to cover both traditional
> ARM Primecell type devices, and newer CoreSight and other components.
> 
> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> cases to uniquely identify components. CoreSight components related to
> a single function can share Peripheral ID values, and must be further
> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> PMU and Debug hardware of the A35 all share the same PID.
> 

[..]

> +static const struct amba_id *
> +amba_lookup(const struct amba_id *table, struct amba_device *dev)
> +{
>   	while (table->mask) {
> -		ret = (dev->periphid & table->mask) == table->id;
> -		if (ret)
> -			break;
> +		if (((dev->periphid & table->mask) == table->id) &&
> +			((dev->cid != CORESIGHT_CID) ||
> +			 (amba_cs_uci_id_match(table, dev))))

Shouldn't the check be (dev->cid == CORESIGHT_CID) ?
Without this STM fails to probe on both SDM845 and MSM8996.

With this,

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
