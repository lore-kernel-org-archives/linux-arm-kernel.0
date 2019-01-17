Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCA1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:55:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C2E20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KhPnSS3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C2E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZMs8OS/SVho1wb1Oy2uaDBGz0gE84waPg2pFaAAD9QM=; b=KhPnSS3nVU5TGYtTzTeGPFSNF
	NzMAxKEKyNruNShlFGzW/5WQU+QHXmSM9x0EQ97y1/1vYBro5YAbF6sILOP4QyOLFkkpH8NBnq1rQ
	sEzzWqg+Z2GJcl0/eybphqyKFE4vtB8e80NtVETBMPYYr1Cin9Xs30JhQKZOF2N9qhcDj1G8Df6Wu
	0xAfI6TKEwNB42VKWIPUZBMAFUcNCekWjWKD1R00L6ijEgFA8VGEn95bkUNGq9E27YU7R9TbVnwu5
	0694u+od74ws5H3sFGwc6V4+MVGVs5YKf8vQMRa4ukaxkA0g+JPkDh8tdQ3IoTGs0NbtatQEBiimz
	8Nwc3RMZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk6Gp-0004so-W8; Thu, 17 Jan 2019 11:55:40 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk6Gj-0004rn-4f
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:55:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25EC980D;
 Thu, 17 Jan 2019 03:55:29 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 198753F557;
 Thu, 17 Jan 2019 03:55:25 -0800 (PST)
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To: mathieu.poirier@linaro.org
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
 <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
 <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a9f6be39-6914-4f32-0212-da016757dd72@arm.com>
Date: Thu, 17 Jan 2019 11:55:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANLsYky_1QxfNRnGi=3sONMrS6JCdjcwtdQBJqi9FtpQMvF_Zg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_035533_356395_9329F2EF 
X-CRM114-Status: GOOD (  23.71  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, peterz@infradead.org,
 gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com,
 acme@kernel.org, ast@kernel.org, alexander.shishkin@linux.intel.com,
 mingo@redhat.com, will.deacon@arm.com, hpa@zytor.com, schwidefsky@de.ibm.com,
 namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mathieu,

On 16/01/2019 23:43, Mathieu Poirier wrote:
> Good evening Suzuki,
> 
> On Wed, 16 Jan 2019 at 03:29, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>
>>
>> On 15/01/2019 23:07, Mathieu Poirier wrote:
>>> Add a "sinks" directory entry so that users can see all the sinks
>>> available in the system in a single place.  Individual sink are added
>>> as they are registered with the coresight bus.
>>>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

...

>>> +static ssize_t etm_perf_sink_name_show(struct device *dev,
>>> +                                    struct device_attribute *dattr,
>>> +                                    char *buf)
>>> +{
>>> +     /* See function coresight_sink_by_id() to know where this is used */
>>> +     u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
>>> +
>>> +     return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
>>> +}
>>> +
>>> +int etm_perf_symlink_sink(struct coresight_device *csdev)
>>> +{
>>> +     struct device *pmu_dev = etm_pmu.dev;
>>> +     struct device *pdev = csdev->dev.parent;
>>> +     struct device_attribute *dev_attr;
>>> +
>>> +     if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
>>> +         csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
>>> +             return -EINVAL;
>>> +
>>> +     if (!etm_perf_up)
>>> +             return -EPROBE_DEFER;
>>> +
>>> +     dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
>>> +     dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
>>> +     dev_attr->attr.mode = 0444;
>>> +     dev_attr->show = etm_perf_sink_name_show;
>>
>> I would have  added the attribute to the csdev (say, sink_attr),
>> and add that to the group, so that it is easier to remove the
>> attribute when the sink device is removed from the system (when
>> we get there). It would be good to have something in place to remove the
>> attribute.
> 
> My hope was to avoid introducing a new field in the already bloated
> coresight_device structure, and on top of things a component specific
> field.  I think it would be worth it if we'd envision making the

I agree. May be we could add a union for the fields specific to the "Type" of
the device.

> coresight drivers removable in a not so distant future.  But doing
> something like that is quite tricky (as Kim quickly found out) and
> skirts the bottom of the list of priorities, if on it at all.

> 
> I'll change it if you're really keen on it but it would be code that
> is never used.

Yes, I understand. But we would want to get there sometime in the future,
in order to allow using the Coresight out of the box on Enterprise systems.
So it would be good to prepare towards that as we go.


Also, it makes the failure handling easier.

Cheers
Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
