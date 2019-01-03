Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28008C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D542073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FctvCm06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D542073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VqcmDFinQ0jRbvBpkphFJc/9nGHSk2/e+Ir5VGmToGQ=; b=FctvCm06UXkjWycq7S14VsMNa
	8FnKCeMQ5+7y8Odx50iNhQxf0yaCrIyqgt+aUm4f6m5OqT2vUxq2hXhYMLit6z+tOxernOLEr40k8
	H3FQFpTO5+R7vieS088n5lpaeljjzc6hTp0hyj7JHWEWPpjjXhlGHT0wZKKEFVP03A3jPqFOXK6S8
	eN0q7MsvYLBRIFo41YBQr2FmqOS7tDoWaowNXxMltYV33RdWyLR2M3SDg6so5t7hbjHIutF8Svt5v
	D+Ryxii0e8sAEk976PQiymNXRcXXyPSdiM0EPymJZiDH9Hq7ujiAMEnON8CmotEHNHPX9XD4fvr+c
	a4XI297BA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf60l-0004Ax-Qq; Thu, 03 Jan 2019 16:38:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf60i-0004Ab-Cu
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 16:38:21 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0303315AD;
 Thu,  3 Jan 2019 08:38:20 -0800 (PST)
Received: from [192.168.100.243] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC3C43F5D4;
 Thu,  3 Jan 2019 08:38:18 -0800 (PST)
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
 <20190103093858.GA10794@kroah.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c9e08010-3ca0-cb03-e5ad-ab19342ff63b@arm.com>
Date: Thu, 3 Jan 2019 10:38:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190103093858.GA10794@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_083820_437438_7C7884D1 
X-CRM114-Status: GOOD (  19.55  )
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
Cc: mark.rutland@arm.com, David Woodhouse <dwmw@amazon.co.uk>,
 mlangsdo@redhat.com, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com,
 Dave Hansen <dave.hansen@intel.com>, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 shankerd@codeaurora.org, ykaukab@suse.de, Thomas Gleixner <tglx@linutronix.de>,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 01/03/2019 03:38 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
>> There is a lot of variation in the Arm ecosystem. Because of this,
>> there exist possible cases where the kernel cannot authoritatively
>> determine if a machine is vulnerable.
> 
> Really?  Why not?  What keeps you from "knowing" this?  Can't the
> developer of the chip tell you?

There tends to be a few cases, possibly incomplete white/black lists, 
firmware that isn't responding correctly, or the user didn't build in 
the code to check the mitigation (possibly because its an embedded 
system and they know its not vulnerable?).

I would hope that it is an exceptional case.

> 
>> Rather than guess the vulnerability status in cases where
>> the mitigation is disabled or the firmware isn't responding
>> correctly, we need to display an "Unknown" state.
> 
> Shouldn't "Unknown" really be the same thing as "Vulnerable"?  A user
> should treat it the same way, "Unknown" makes it feel like "maybe I can
> just ignore this and hope I really am safe", which is not a good idea at
> all.

I tend to agree its not clear what to do with "unknown".

OTOH, I think there is a hesitation to declare something vulnerable when 
it isn't. Meltdown for example, is fairly rare given that it currently 
only affects a few arm parts, so declaring someone vulnerable when they 
likely aren't is going to be just as difficult to explain.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
