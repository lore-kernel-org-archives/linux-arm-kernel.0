Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C3AC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C935B20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxGGN79C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C935B20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WfJlmI4S0MbwWjMmS050eLxR6S2zUT57OiNlQkjp6+c=; b=qxGGN79Clb4pCvDldNqRVXDIQ
	Qt7PCZWv0Gsf0AWXu/uTGMJii+l/SMOJSBcUzuqg8aRssRTOdmWfcvuJ+K9C7TqNyvrIKjKEjROo1
	AXSBoBoShVhJ/ZewtinI5EgUmIVlePGefdXeOsCphlscxFPs9W6j1UT2k1rgD3VWbWqezmVx0BMIe
	ubFXUaEqRgA1QJD0SS0QEN/tnB2NBt1GcDUFNcDgovObpEDBTA9n9m8TsBXHzTZruaKvfPB700W6j
	QdXpGlzCXoYEgh2KJlOia3vGstOOFOwxoxpUgZju0Z9vNIzjQXJoM9m9yI7IyqtErLNUPJCD5ggoh
	vhh0+LwhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjW9j-0007sf-ED; Tue, 15 Jan 2019 21:21:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjW9g-0007sH-7m
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 21:21:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23CF780D;
 Tue, 15 Jan 2019 13:21:48 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6683F917;
 Tue, 15 Jan 2019 13:21:46 -0800 (PST)
Subject: Re: [PATCH v3 0/7] arm64: add system vulnerability sysfs entries
To: Stefan Wahren <stefan.wahren@i2se.com>,
 linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <884332236.499392.1547581848222@email.ionos.de>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c99f5da9-259c-3fc5-6150-7327ba0ff429@arm.com>
Date: Tue, 15 Jan 2019 15:21:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <884332236.499392.1547581848222@email.ionos.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_132152_285930_70FA64B1 
X-CRM114-Status: GOOD (  17.83  )
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
Cc: mlangsdo@redhat.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 01/15/2019 01:50 PM, Stefan Wahren wrote:
> Hi Jeremy,
> 
>> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
>>
>>
>> Arm64 machines should be displaying a human readable
>> vulnerability status to speculative execution attacks in
>> /sys/devices/system/cpu/vulnerabilities
>>
>> This series enables that behavior by providing the expected
>> functions. Those functions expose the cpu errata and feature
>> states, as well as whether firmware is responding appropriately
>> to display the overall machine status. This means that in a
>> heterogeneous machine we will only claim the machine is mitigated
>> or safe if we are confident all booted cores are safe or
>> mitigated.
>>
> 
> i applied this v3 series and Marc's v2 series.
> 
> Now i'm getting the following on a Raspberry Pi 3 B+ :
> 
> meltdown:Not affected
> spec_store_bypass:Not affected
> spectre_v1:Mitigation: __user pointer sanitization
> 
> So the entries l1tf and spectre_v2 disappeared.

Yes, the l1tf entry should be gone.

I believe there is a problem with the "1/2 advertise.." patch in that 
the 'arm64_requested_vuln_attrs |=' line needs to be hoisted  to the top 
of check_branch_predictor() and the '__spectrev2_safe = false' line 
needs to be hoisted 6 lines immediately above "/* Fallback to firmware 
detection*/"

That should re-enable the spectre_v2 entry.




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
