Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F6C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DC820879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HLQ+gfti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DC820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qYMA+h2WjdbZwjddLZrxMKq+NZCqMS0s9bSIFO7XCSs=; b=HLQ+gftiH2VtzDIWZDfzyuuw/
	8aUx2hTp6AE2jOlRcSEmFnuAr690F5GzwIxoOInkYbFUwaWbIzwr7W2CPFeROg8M7ZgNGWZEA3Gdr
	+laO5GhiFG0oBA9/+s2/KVjNRe92cEaQeBuuSqwX/xyY8TcADU5b5xcT/BmCbvZDs8YQI9AjaRwcS
	V+xl3cr4UwCjNKd+uB4eC5z/1AOabqBHo4tir7NntMb9LdEccR2fnCPqkD7jcoS1hErJGmwqTGwJc
	gnYDvu+i/4+Yy4XJLUZsN8aDB3zCkU4EE2sYcYo7UcWnohidvyXNQNXpTBMljT8kJlIjwfNtv9D/0
	cXloryyOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUns-0002D8-7Y; Thu, 13 Dec 2018 17:29:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUno-0002Cd-6H
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 17:29:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF9EA78;
 Thu, 13 Dec 2018 09:29:24 -0800 (PST)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38BCC3F575;
 Thu, 13 Dec 2018 09:29:24 -0800 (PST)
Subject: Re: [PATCH 0/6] add system vulnerability sysfs entries
To: Dave Martin <Dave.Martin@arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181213120726.GB3505@e103592.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <58ce38ff-c347-8cb7-ba79-9eea491e30e8@arm.com>
Date: Wed, 12 Dec 2018 09:48:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181213120726.GB3505@e103592.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_092936_235649_5A03FED6 
X-CRM114-Status: GOOD (  27.27  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shankerd@codeaurora.org, ykaukab@suse.de, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

Thanks for looking at this!

On 12/13/2018 06:07 AM, Dave Martin wrote:
> On Thu, Dec 06, 2018 at 05:44:02PM -0600, Jeremy Linton wrote:
>> Part of this series was originally by Mian Yousaf Kaukab.
>>
>> Arm64 machines should be displaying a human readable
>> vulnerability status to speculative execution attacks in
>> /sys/devices/system/cpu/vulnerabilities
> 
> Is there any agreement on the strings that will be returned in there?
> 
> A quick search didn't find anything obvious upstream.  There is
> documentation proposed in [1], but I don't know what happened to it and
> it doesn't define the mitigation strings at all.  (I didn't follow the
> discussion, so there is likely background here I'm not aware of.)
> 
> If the mitigation strings are meaningful at all, they really ought to be
> documented somewhere since this is ABI.

I think they are in testing? But that documentation is missing the 
"Unknown" state which tends to be our default case for "we don't have a 
complete white/black list", or "mitigation disabled, we don't know if 
your vulnerable", etc.

I'm not sure I like the "Unknown" state, but we can try to add it to the 
documentation.

> 
>> This series enables that behavior by providing the expected
>> functions. Those functions expose the cpu errata and feature
>> states, as well as whether firmware is responding appropriately
>> to display the overall machine status. This means that in a
>> heterogeneous machine we will only claim the machine is mitigated
>> or safe if we are confident all booted cores are safe or
>> mitigated. Otherwise, we will display unknown or unsafe
>> depending on how much of the machine configuration can
>> be assured.
> 
> Can the vulnerability status change once we enter userspace?

Generally no, for heterogeneous machines I think the answer here is yes, 
a user could check the state, and have it read "Not affected" then bring 
another core online which causes the state to change at which point if 
they re-read /sys it may reflect another state. OTOH, given that we tend 
to default to mitigated usually this shouldn't be an issue unless 
someone has disabled the mitigation.


> 
> I see no locking or other concurrency protections, and various global
> variables that could be __ro_after_init if nothing will change them
> after boot.

I think the state changes are all protected due to the fact the bringing 
a core online/offline is serialized.

> 
> If they can change after boot, userspace has no way to be notified,

Is checking on hotplug notification sufficient?


> 
> (I haven't grokked the patches fully, so the answer to this question may
> be reasonably straightforward...)
> 
> 
> Cheers
> ---Dave
> 
> [1] https://lkml.org/lkml/2018/1/8/145
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
