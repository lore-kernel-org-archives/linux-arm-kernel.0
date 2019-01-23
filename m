Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:51:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A58217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 04:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kt0PBpE/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="USJlPe1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A58217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z915N9gOhLdI7JmkQx2n5PmTBssdgwp0w8g0AEJwuQ0=; b=Kt0PBpE/wDlnMO
	KFrbFqQZfZhkuZSnZfjcw9qrv3n0zVhSZYGO4SiMHQBhxs3fKN8ymE6xdioKGjsHHkqzjXe5O2Zr5
	bLzgh+UkHLFuzF2rcHTEqs/GQpyTjkUNi3v1Y75YJUSbeemNMCP/Ka6S3QTGFH30ZZwlsx1Y7l/ui
	AtjTEFNYKUKGpI/RlOMIPe5kCxgr3n97J+0wuYvd3gIxQh1M+/d7wl06NwWZVJNtG8PFN8+cxrG5A
	EllZ95aaJYhC/nqwdllIorQyQXASSsrKp4beOgTDnn9tPb8WWq+kg7j9oC7/vrFrx+LG4H2AkXxjS
	UFJ2DbwUD8mm28tLcNrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmAVV-0006tg-SP; Wed, 23 Jan 2019 04:51:21 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmAVS-0006tE-AO
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 04:51:19 +0000
Received: by mail-ot1-x344.google.com with SMTP id v23so807109otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 20:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h7AFpoW1OJISLjtuUgEaf+hEQBevXpMX4q7t19fZ9Wg=;
 b=USJlPe1wxD1C6SXpCm93y8NpbgWM07sGNXpWuJjtSnGbPsJ+wYZp3dC/a+kfvpFtUi
 NmkBrNZoABfM+unuOFIZUfiP3KZJZRFEYzPJ3hopBK1rdosSjIm8HxfElpsI4F9qzH1z
 bZRQ8MBMmcV3SY2Ab6S/Vn5gqN+8M7PL1wMpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h7AFpoW1OJISLjtuUgEaf+hEQBevXpMX4q7t19fZ9Wg=;
 b=oPjAhKrOOswSaR2EuZPy7F/60dRQG5p03FarmjPAetZIfwCjQa15gds8Bpf7EHRIxy
 buNzoOpRiruwpJH9IFps8dFpEksm3kPQQv/NEq/Qu+/2AtniKb3XIUYMk0d3rSeYxn/e
 A4UGsPGiiXWPzT0lrAyTH+wR4FC9QMsbBya/y8nFemzIxU29IMfUkAy0uT9RnwQ9GJbi
 Oa9IW6ZRxsM81/UOVf4r7twGtyoq4DR+yN12Y2lQ7Mg9aee9AKBTh63lHh/jYEqR22Tz
 jGlvhUr4pCCxSXAA+QrE8iXC718KsH/mFsSCjDsj0nwwvSVfEHEbDm+eiSM97EOyYxcO
 mbSA==
X-Gm-Message-State: AJcUukcUD8hCuhvjIMgC8u/hk1PB8zresWTLuY+FjpZT2cyIQqSMSfg8
 0D9CVktkn6Iq3Z/eXi4JjTudkmIoXr+5rwloG6Mlog==
X-Google-Smtp-Source: ALg8bN7efuFFPTz8RBWZw9yzvR1ezKo1h9zO8Ab+ROmmOp4w68TnEXlG5nNCPyTu0uw1dsckBkCoRKF0oh6R1RdGDwQ=
X-Received: by 2002:a9d:4:: with SMTP id 4mr519114ota.174.1548219076241; Tue,
 22 Jan 2019 20:51:16 -0800 (PST)
MIME-Version: 1.0
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin>
 <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <20190121112248.GA27784@e107155-lin>
In-Reply-To: <20190121112248.GA27784@e107155-lin>
From: Pramod Kumar <pramod.kumar@broadcom.com>
Date: Wed, 23 Jan 2019 10:21:05 +0530
Message-ID: <CAJ+tv6++eXwu7Ez-GW62Avgaj+h0aPhyL0K-n3mBgwM2RtXXjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_205118_367061_60FD1E89 
X-CRM114-Status: GOOD (  24.48  )
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
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks Sudeep for reviewing. Please see my comment inline below.

On Mon, Jan 21, 2019 at 4:52 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jan 21, 2019 at 11:28:27AM +0530, Pramod Kumar wrote:
> > On Fri, Jan 18, 2019 at 5:02 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
> > > > If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
> > > > call to stop the CPU. This call ensures L1/L2 cache flush,
> > > > CPUs cache-cohenrecy setting w.r.to interconnect.
> > >
> > > Firstly, this is not specific to PSCI and I don't see any PSCI calls as
> > > $subject claims.
> >
> > I had seen all the other cpu ops methods where only PSCI supports only
> > cpu_die features hence used PSCI reference in my subject line to be more
> > clear where this die gets converted in last.
> >
>
> OK, but since you are not directly dealing with PSCI APIs, it's misleading.
>

I can re-phrase my commit message which links explanation to PSCI.

> > > Next, you fail to explain why do you have to ensure
> > > caches are cleaned and why do you need that in ipi_cpu_stop ?
> > > What's the use case ?
> > >
> > Need comes from a specific use case where one Accelerator card(SoC) is
> > plugged in a sever over a PCIe interface.  This Card gets supply from a
> > battery, which could provide very less power for a very small time, in case
> > of any power loss. Once Card switches to battery, this has to reduce its
> > power consumption to its lowest point and back-up the DDR contents asap
> > before battery gets fully drained off.
> >
>
> OK, but I was expecting the complete call path for this use-case.

OK. Once power loss happens, Application processor gets interrupt and
it has to switch to MCU asap so that it can switch-off all irrelevant
power domain to reduce battery drain.
flow is like this-
Power loss interrupt --> interrupt handler -> send IPI to stop all
secondary CPUs-> switch primary CPU to ATF which ultimately transition
to MCU where all power off action is taken.

>
> > Since battery can provide limited power for a very short time hence need to
> > transition to lowest power. As per the transition process , CPUs power
> > domain has to be off but before that it needs to flush out its content to
> > system memory(L3) so that content could be backed-up by a MCU, a controller
> > consuming very less power. Since we can not afford plugging-out every
> > individual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs
>
> So, you are randomly using ipi_cpu_stop for something it's not supposed to
> be used. What do you exactly want to achieve in that context where you need
> to save power ?

Need to back-up DDR from MCU which will require L1/L2 content gets
flushed before CPUs getting shutdown.

>Why system off or reset not sufficient ?
System off or reset is not sufficient as we can not afford that much
delay in transition.

Flushing L1/L2 contents to System memory and Bringing out CPUs
Clusters out of coherency domain before shutting down Clusters puts
rest of system in sane state.  If cluster are not being taken out
properly from coherency domain before shutting down, it could lead
system un-reliable for rest parts.

> --
> Regards,
> Sudeep
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
