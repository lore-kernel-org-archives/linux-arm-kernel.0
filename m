Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C08C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:27:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF83321855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GKMOFBp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF83321855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fef+dXXgD5bT4+HdU+IusmWHWzVGdaLaYY8s1IWPH1M=; b=GKMOFBp7gl6zc/
	dgGPkkOA6J5kdG0y583smNP0z639wBV8QUY0+Wnvv66IzzulK31atV/jFBnedCfXqQGVA+SG2/ycm
	yYYVKi3VdlR+yfiSQX3lC4c81J8IOCKimywoB+H4Cgyf5WbID4wXQMUbz2s+DLKqx+GwFX2ZkXqFm
	l8o+s8p+A5aOTX6a+HejRpKiAtBHOORKDEHpU5dvImWIcDZ69P5KNqO0jSvDD1tjg2wWoTIggKAfB
	X67odM7DvKZwhc90jcKsn1z1G4nNVv7mgef7KXHWJhyN9HFv8Hl5HU2ndUd0Q3Z7iALuELQ4ZeKhj
	oz3cKrl1kbEaP+NcRfFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmLN0-0001rl-8O; Wed, 23 Jan 2019 16:27:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmLMx-0001qa-A8
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:27:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF1E3A78;
 Wed, 23 Jan 2019 08:27:10 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963F53F237;
 Wed, 23 Jan 2019 08:27:08 -0800 (PST)
Date: Wed, 23 Jan 2019 16:27:03 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
Message-ID: <20190123162514.GA22147@e107155-lin>
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <20190121112248.GA27784@e107155-lin>
 <CAJ+tv6++eXwu7Ez-GW62Avgaj+h0aPhyL0K-n3mBgwM2RtXXjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ+tv6++eXwu7Ez-GW62Avgaj+h0aPhyL0K-n3mBgwM2RtXXjQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_082715_359131_8A1CA521 
X-CRM114-Status: GOOD (  24.02  )
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

On Wed, Jan 23, 2019 at 10:21:05AM +0530, Pramod Kumar wrote:
> Thanks Sudeep for reviewing. Please see my comment inline below.
>
> On Mon, Jan 21, 2019 at 4:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> >
> > OK, but I was expecting the complete call path for this use-case.
>
> OK. Once power loss happens, Application processor gets interrupt and
> it has to switch to MCU asap so that it can switch-off all irrelevant
> power domain to reduce battery drain.
> flow is like this-
> Power loss interrupt --> interrupt handler -> send IPI to stop all
> secondary CPUs-> switch primary CPU to ATF which ultimately transition
> to MCU where all power off action is taken.
>

So does the entire AP domain get powered off or is that the intention ?
If so, just stopping secondaries through IPI is not sufficient. What
happens to all the running tasks and other operations going on in the
system.

> >
> > > Since battery can provide limited power for a very short time hence need to
> > > transition to lowest power. As per the transition process , CPUs power
> > > domain has to be off but before that it needs to flush out its content to
> > > system memory(L3) so that content could be backed-up by a MCU, a controller
> > > consuming very less power. Since we can not afford plugging-out every
> > > individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
> >
> > So, you are randomly using ipi_cpu_stop for something it's not supposed to
> > be used. What do you exactly want to achieve in that context where you need
> > to save power ?
>
> Need to back-up DDR from MCU which will require L1/L2 content gets
> flushed before CPUs getting shutdown.
>

Understood.

> >Why system off or reset not sufficient ?
> System off or reset is not sufficient as we can not afford that much
> delay in transition.
>

But who will save the system state ? You may corrupt data at the cost
of saving transition delay. So IMO, you don't have a valid use-case or
you are failing to present one properly.

> Flushing L1/L2 contents to System memory and Bringing out CPUs
> Clusters out of coherency domain before shutting down Clusters puts
> rest of system in sane state.  If cluster are not being taken out
> properly from coherency domain before shutting down, it could lead
> system un-reliable for rest parts.
>

Looks like you are concerned only with CPUs in this scenario, but what
about other devices in the domain. So suspend-to-{ram,idle} are only
sane options to make sure you don't loose/corrupt any data/state.

Further point me to the code either part of this series or upstream
handling the "Power loss interrupt" explained above.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
