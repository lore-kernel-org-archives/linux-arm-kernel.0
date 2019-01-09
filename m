Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE037C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:56:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B586F21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kIqCxEKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B586F21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L4q32g9H/4xvnADkJh1wVu95j7c2y94Bke5VGR8Kibs=; b=kIqCxEKtoACKtN7SYFvcmQAuC
	96hdTaRotVXKQben4CZj14q8gmTlgWuuUGzX5s9r7SkgKjjkUBpi0/9fiIcWAPol6hDv3x0nk/P/U
	ZlbM7XUbjkCI2YcR+wT/Sxe/s38GBenw4PPupqghXWz8uIi3+0LtVvGNG+tIDlLmcl233L2mX+qwc
	DrpSu/e5Cs74RXqRJzuyf7liMIyCzl1YLYOAmolClEu+Gcr/hUbSxymZvGf9LkHqduYzi3k9jApai
	BFB2PS0KfxyuFlzs24GrIoYkQoSHMtm2HiIkjqT6kdCZKrzr31w24soJ5APcYUQCYniV+ozHCA4Df
	PjBbpQ2Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghAbT-0000oc-7A; Wed, 09 Jan 2019 09:56:51 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghAbP-0000o9-Vk
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 09:56:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82D5D80D;
 Wed,  9 Jan 2019 01:56:47 -0800 (PST)
Received: from [172.16.1.159] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 65C363F70D; Wed,  9 Jan 2019 01:56:43 -0800 (PST)
Subject: Re: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
 <20190108104204.GA14243@zn.tnic>
 <e1458b95-6d17-21be-5dd8-ee7ff8d8b3fb@arm.com>
 <20190108181206.GA3848@kroah.com>
From: James Morse <james.morse@arm.com>
Message-ID: <52dc5125-9213-9ee4-eca6-cc8ffbc869f7@arm.com>
Date: Wed, 9 Jan 2019 09:57:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190108181206.GA3848@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_015648_026520_7AB69A79 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "Sverdlin,
 Alexander \(Nokia - DE/Ulm\)" <alexander.sverdlin@nokia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "Wiebe,
 Wladislav \(Nokia - DE/Ulm\)" <wladislav.wiebe@nokia.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Greg,

On 01/08/2019 06:12 PM, gregkh@linuxfoundation.org wrote:
> On Tue, Jan 08, 2019 at 05:57:24PM +0000, James Morse wrote:
>>>> diff --git a/drivers/edac/cortex_a15_l2_async_edac.c b/drivers/edac/cortex_a15_l2_async_edac.c
>>>> new file mode 100644
>>>> index 000000000000..26252568e961
>>>> --- /dev/null
>>>> +++ b/drivers/edac/cortex_a15_l2_async_edac.c
>>>> @@ -0,0 +1,134 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2018 Nokia Corporation
>>
>> (boiler plate not needed with the SPDX header)
> 
> Not true at all.  Copyright is not the same thing as an SPDX license
> identifier in any way, shape, or form.  As-is, this is just fine.


This looks funny because I removed the GPL license text that was here, 
but left this comment when trimming the reply. I should have left a few 
lines of it for context.

(Originally: 
https://lore.kernel.org/lkml/20190108104204.GA14243@zn.tnic/T/#u)


Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
