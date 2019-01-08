Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:04:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C2020651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KV4eT0Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C2020651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V2YzbGxoEDZEcCpJTogtqOQcXDCqOibwHmqd/n+oHo0=; b=KV4eT0MrXu7MUM
	UX65jkv7QHGblrSGV+FsbKjUn10B5b9G7EXRu+PIzYyVLomwcZsAtFs52QIStsHuQNqAv9E5DKQFv
	0oALWJ1K1dMcSHqrImsQmtxB/T+fouzX5hkpY3H1xdQmtKQUessB2WGkicaEebigAXEr+JPhdsJal
	EaeSBvOGERsdNxn0eURcceHKGzm3iRQoNXNDNx9v7pnHdMFbBW7WAKpgOFR8k/3da7GTpuL858iqG
	txv8E/IXANNi1P0lfXU7mHJttNkLrYg77kdiZ0Bsy6pQy/7G0XAeWMrJCXUbYukD/a0WUVDGBrYov
	yXkpN8vYTVqaHYY/ENjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggq6z-0005FU-24; Tue, 08 Jan 2019 12:04:01 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggq6u-0005Ej-12
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 12:03:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408C31596;
 Tue,  8 Jan 2019 04:03:54 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB44C3F70D;
 Tue,  8 Jan 2019 04:03:53 -0800 (PST)
Date: Tue, 8 Jan 2019 13:03:52 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v8 4/5] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
Message-ID: <20190108120352.GN10769@e113682-lin.lund.arm.com>
References: <1544610573-28446-1-git-send-email-andrew.murray@arm.com>
 <1544610573-28446-5-git-send-email-andrew.murray@arm.com>
 <20181218120226.GC25383@e113682-lin.lund.arm.com>
 <20190104153205.GA31479@edgewater-inn.cambridge.arm.com>
 <20190108101843.GH10769@e113682-lin.lund.arm.com>
 <20190108112512.GA56789@e119886-lin.cambridge.arm.com>
 <868szvbc64.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <868szvbc64.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_040356_069434_4BF67C6C 
X-CRM114-Status: GOOD (  20.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Julien Thierry <julien.thierry@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, joro@8bytes.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Andrew Murray <andrew.murray@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 08, 2019 at 11:50:59AM +0000, Marc Zyngier wrote:
> On Tue, 08 Jan 2019 11:25:13 +0000,
> Andrew Murray <andrew.murray@arm.com> wrote:
> 
> Hi Andrew,
> 
> > My only doubt about this is as follows. If, on a KVM host you run this:
> > 
> > perf stat -e cycles:H lkvm run ...
> > 
> > then on the VHE host the cycles reported represents the entire non-guest cycles
> > associated with running the guest.
> > 
> > On a !VHE, the cycles reported exclude EL2 (with or without this patch) and
> > thus you don't get a representation of all the non-guest cycles associated with
> > the guest. However without this patch you could at least still run:
> > 
> > perf stat -e cycles:H -e cycles:h lkvm run ...
> > 
> > and then add the two cycle counts together to get something comparative with
> > the VHE host.
> > 
> > If the above patch represents the desired semantics, then perhaps we must count
> > both EL1 and *EL2* for !exclude_kernel on !VHE. In fact I think we should do
> > this anyway and remove a little complexity from armv8pmu_set_event_filter.
> > Thoughts?
> 
> I'm not sure we should hide the architectural differences between VHE
> and !VHE. If you're trying to measure what is happening at in the
> hypervisor, you can't reason about it while ignoring the dual nature
> of !VHE.
> 

How do you define hypervisor here?  Is that just the code that runs at
EL2 or also parts of KVM that runs at EL1?

It remains unclear to me why you'd want to measure a subset of KVM,
which happens to run in EL2, in your host (and hypervisor-enabled)
kernel, and you are even precluded from measuring a comparable portion
of your implementation on other Arm systems (VHE).

Admittedly, I'm not at export in using perf, but I find this EL1/EL2
distinction out of place as it relates to exlude_kernel, exlude_user,
and exlude_hv.  Will we have a fourth Arm-specific flag which takes the
place of exclude_hv on PowerPC, which excludes an underlying hypervisor
when running a guest, should we ever support counting that in the
future?


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
