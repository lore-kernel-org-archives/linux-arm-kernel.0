Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:22:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968C9218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y3yzJ85v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968C9218A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ncEvhj1nBrPyKD3bZghLehW2LhqaXFiG2lIuImGVToA=; b=Y3yzJ85vE9GyYq
	4EueW3c26IUdAU4kJmVrQCGgnvTTJmeaoBMITxF6Yqo9R7xW7dX0b/yOaHFbZhzibV3Kg0PPcNSca
	nPslXg2+RkkGWx83kODl416PMdoj8O96b912Gmwu/ruUYimSFN/2Yx+EuHlyf2F7LfqpnSFRggHYK
	YibLnq4lO7MfR49y/yjaO/ac6u4hfvG4SvjL2GTgspKp2d3XLLiaUzQdPKgd0p96ESKphsXkHH/is
	jPkikoBo07QMrIcMcUzsUe81/w+34Ee6HjgF0nUrnfkurKcJfBZuhZG/Gj1kOKMLt/HMnu9Nx1jy+
	dGCSrC++TxgWl08Pw+mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHCI-0003Yt-Hm; Tue, 18 Dec 2018 15:22:14 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHC9-0003Io-0K
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:22:08 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Dec 2018 07:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,368,1539673200"; d="scan'208";a="102462626"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
 by orsmga008.jf.intel.com with ESMTP; 18 Dec 2018 07:21:47 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, acme@kernel.org,
 peterz@infradead.org, gregkh@linuxfoundation.org
Subject: Re: [RESEND PATCH v5 4/6] coresight: Use PMU driver configuration for
 sink selection
In-Reply-To: <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-5-git-send-email-mathieu.poirier@linaro.org>
 <48afc315-d4ed-8779-a808-757fa4203bb7@arm.com>
Date: Tue, 18 Dec 2018 17:21:47 +0200
Message-ID: <87va3qeu7o.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072205_485881_7A8190CE 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: mark.rutland@arm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
 will.deacon@arm.com, adrian.hunter@intel.com, ast@kernel.org, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, hpa@zytor.com, schwidefsky@de.ibm.com,
 namhyung@kernel.org, tglx@linutronix.de, suzuki.poulosi@arm.com,
 jolsa@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>> +	/*
>> +	 * The HW mapping of a component is unique.  If the value we've been
>> +	 * given matches the component's start address, then we must have found
>> +	 * the device we are looking for.
>> +	 */
>
> To be frank, I don't quite like the idea of passing the base address of the
> component as the key to locate a device, (even though that is unique and readily
> available). I would rather prefer a programmable way to map the keys to the
> "sink" devices, which works platform agnostic (e.g, ACPI support, where the base
> address is not obvious from the name). Also if we decide to use a platform
> agnostic naming scheme, it becomes even more complex.
>
> We could assign a static "id/key" exported either via the device sysfs dir or
> the "pmu" dir. I prefer the latter.
>
> Thoughts ?

So, my understanding is that we have a bunch of trace sources and a
bunch of trace sinks to choose from when we set up the perf event. The
current model basically treats trace sources as PMUs and relies on the
sink configuration process to be done via sysfs, which is not ideal as
an API.

The first thing that comes to mind is: can then the sinks be made their
own PMUs, so the above can be done via the existing SET_OUTPUT ioctl?

Regards,
--
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
