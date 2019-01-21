Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA3FA3729
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F43C20663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eL1ocrmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F43C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t9WnZyrbq+XiaYaEFDV4RjEMFb+QWLhb327ckeS1L2M=; b=eL1ocrmYH0nEo1
	SBxnSr+zbupRE638Ws7nAyOXZBqKE6IsufomU2H00O2dmSx7VxKybyXlCY6oxAfNVeCobiQGsgqVH
	67DNcmWiQxuz00ZP+u0UWG0Hq3SLR/pZtZ4FnZzBjN95OzmjOwt/xlc0cBfKP5eVAo+mPYrih0fam
	YA8rZRa1TQy72j8uGFGmz9Q90ntdJA9uyIFxrHIrrwCwCdkZdfjvylaRD0lA0Eax+aJLdu+Qo1Waa
	TbGGpq54xSGpMs9aCurmXoA6qgReFd+2YPkdCOLgPAX68vjwATP/sslWKvdO1tufLNmDc7dzSZT/l
	d2wp/WOPfxxWlgyWYBkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glXfT-0000zO-EA; Mon, 21 Jan 2019 11:23:03 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glXfQ-0000z0-75
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 11:23:01 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFAA6EBD;
 Mon, 21 Jan 2019 03:22:57 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7EEE3F5C1;
 Mon, 21 Jan 2019 03:22:55 -0800 (PST)
Date: Mon, 21 Jan 2019 11:22:48 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190121112248.GA27784@e107155-lin>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_032300_260277_3DC8341A 
X-CRM114-Status: GOOD (  23.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Steve Capper <steve.capper@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 11:28:27AM +0530, Pramod Kumar wrote:
> On Fri, Jan 18, 2019 at 5:02 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> > > If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> > > call to stop the CPU. This call ensures L1/L2 cache flush,
> > > CPUs cache-cohenrecy setting w.r.to interconnect.
> >
> > Firstly, this is not specific to PSCI and I don't see any PSCI calls as
> > $subject claims.
>
> I had seen all the other cpu ops methods where only PSCI supports only
> cpu_die features hence used PSCI reference in my subject line to be more
> clear where this die gets converted in last.
>

OK, but since you are not directly dealing with PSCI APIs, it's misleading.

> > Next, you fail to explain why do you have to ensure
> > caches are cleaned and why do you need that in ipi_cpu_stop ?
> > What's the use case ?
> >
> Need comes from a specific use case where one Accelerator card(SoC) is
> plugged in a sever over a PCIe interface.  This Card gets supply from a
> battery, which could provide very less power for a very small time, in case
> of any power loss. Once Card switches to battery, this has to reduce its
> power consumption to its lowest point and back-up the DDR contents asap
> before battery gets fully drained off.
>

OK, but I was expecting the complete call path for this use-case.

> Since battery can provide limited power for a very short time hence need to
> transition to lowest power. As per the transition process , CPUs power
> domain has to be off but before that it needs to flush out its content to
> system memory(L3) so that content could be backed-up by a MCU, a controller
> consuming very less power. Since we can not afford plugging-out every
> individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs

So, you are randomly using ipi_cpu_stop for something it's not supposed to
be used. What do you exactly want to achieve in that context where you need
to save power ? Why system off or reset not sufficient ?

--
Regards,
Sudeep


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
