Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54902C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:42:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2670920B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pm4nFSN4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CU4KYip1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2670920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RO3+LKTcaW3P4R9YLz7B2HMRfIup+qLE1MT5wRfYYnk=; b=pm4nFSN48ElO+QGD5/gSgrQws
	uXvf3R7yDrnMS72hdfxz/Eo/Eu7dub08Xm5TppTcDjIbXJMkfWa3FOxFieh1jDmUp5qoj3Q3EA9bh
	12Ub10b3ib5ITLD9gwgiYqbnLuF0eP488/hoWkYqmg5RaCd993crYW92zMJCLD5Q/wezJfTUMZP79
	+GWvwx0rOYsRyhHF81RvJpDZchbDqzxpzZmmF3SNf+l3QX3j/PyiQwjUNN1HZAnRYoOf6Z9BCVFMV
	/sHmv79wrGh4UyYqZ+S5LtmZokXEvRrGcY/wtdcGlyLCP6XuSSqyKzWHIBJ47voRbRyiupI8FAkjd
	Y1DS/w0Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpNqz-0005hZ-SM; Fri, 01 Feb 2019 01:42:49 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpNqw-0005hA-51
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 01:42:47 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c53a3eb0000>; Thu, 31 Jan 2019 17:42:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 31 Jan 2019 17:42:45 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 17:42:45 -0800
Received: from [10.19.108.132] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 01:42:43 +0000
Subject: Re: [PATCH] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
To: Sudeep Holla <sudeep.holla@arm.com>
References: <20190131022749.19046-1-josephl@nvidia.com>
 <20190131103823.GA19907@e107155-lin>
From: Joseph Lo <josephl@nvidia.com>
Message-ID: <fc49e8b2-cc32-3074-9aa7-04bbc561dfe6@nvidia.com>
Date: Fri, 1 Feb 2019 09:42:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131103823.GA19907@e107155-lin>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1548985324; bh=kajs44y47x/hymVRwUhzh7iHdJc/oH126Cqtxv/IoV4=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=CU4KYip1DKLf0+bld/PL6jFEy2vzGh4bDdVMdRv2TMFIk0fkLmZuRtTDIeJ00l2Wh
 xCAlV1XmaLUioJJPH9cBmMgNuqw1gZ+WQklzUnVw4TjYSHCHVsALck7lA5P5d33taD
 1qcjuhx+20wnyZI+K9CJQcakyMIlCxtYC3IxfMSHfoIP3aWLphTbljdUTupM6Rik4e
 MtRK7zHIy9xJqPKrtkFhAd/q/fP9OXVpCUG+neRxINa3C1z1TYexRWfb0rEPiLXcBp
 5sN6QpS+DXlR7JTuZXFRA8I8MPe2CFtqlNJaBXV4RDyeOr7rQ3bwWD28iXv6922C5H
 Tn/V6taxlqRRg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_174246_259203_B3E61376 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/31/19 6:38 PM, Sudeep Holla wrote:
> On Thu, Jan 31, 2019 at 10:27:49AM +0800, Joseph Lo wrote:
>> Currently, the DT of the idle states will be parsed first whether it's
>> compatible or not. This could cause a warning message that comes from if
>> the CPU doesn't support identical idle states. E.g. Tegra186 can run
>> with 2 Cortex-A57 and 2 Denver cores with different idle states on
>> different types of these cores.
>>
>> We fix it to check the compatible string before the parsing procedures.
>> So it can make sure it only goes through the idle states that the CPU
>> supported.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   drivers/cpuidle/dt_idle_states.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
>> index 53342b7f1010..4a528908abb3 100644
>> --- a/drivers/cpuidle/dt_idle_states.c
>> +++ b/drivers/cpuidle/dt_idle_states.c
>> @@ -180,6 +180,11 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
>>   		if (!state_node)
>>   			break;
>>
>> +		if (!of_device_is_compatible(state_node, matches->compatible)) {
>> +			err = -EINVAL;
>> +			break;
>> +		}
>> +
> 
> Does it make sense to use of_match_node to get the matching device id and
> just pass that to init_state_node instead of the complete array to find the
> match.

Yes, that would be even better.

Thanks,
Joseph

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
