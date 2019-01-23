Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBEC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:21:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCA221019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hOIiwYMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCA221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ea89xbHaMVXvHmyrLRCpsVVHEIbKybzwvNYdBVlwxME=; b=hOIiwYMOGhRfSP
	BjwwO2eNM/tiwgIQJJ9MS5t9/omHyTsWZJ63NreqVHCRhRj+PBt5y96Xa202DkTLB+OATjZTb3920
	PcbJ4gQfwELfvalgXx0YQLNKCglascsaI3R/Bj0e+bgfXprwrPbEHxubJmEIEirkJISRgi5ZyC5o/
	2+jXgLWFaeEb3AKS9S/vTGV2TxrpuNgWI8xOYE9j6O7bUSzC4GpKMgZpVkbyH6K2PUHctsga0e1VU
	R9yZh/4eW8ZlkjaR6EM1uMhrLNE+0gAPYHmg3i81WFYsbb9a4nBKriHYrUHQmCM2Bs1Yqo5bab5c0
	BymgFic7RgiN/NkhVTcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFeo-0006M7-F4; Wed, 23 Jan 2019 10:21:18 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFel-0006LR-AA
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:21:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C8BA78;
 Wed, 23 Jan 2019 02:21:12 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372783F5C1;
 Wed, 23 Jan 2019 02:21:10 -0800 (PST)
Date: Wed, 23 Jan 2019 10:21:06 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190123102104.GF15019@brain-police>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
 <20190122145522.GC52887@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190122145522.GC52887@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_022115_371851_013484BE 
X-CRM114-Status: GOOD (  26.02  )
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
Cc: "Wangkefeng \(Kevin\)" <wangkefeng.wang@huawei.com>,
 anshuman.khandual@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 chenwandun <chenwandun@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 02:55:22PM +0000, Mark Rutland wrote:
> On Tue, Jan 22, 2019 at 05:44:02AM +0000, Will Deacon wrote:
> > On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:
> > > On Sat, Jan 19, 2019 at 11:58:27PM +0000, Will Deacon wrote:
> > > > On Thu, Jan 17, 2019 at 07:42:44AM +0000, chenwandun wrote:
> > > > > Recently, I do some tests on linux-4.19 and hit a softlockup issue.
> > > > > 
> > > > > I find some CPUs get the spinlock in the __split_huge_pmd function and
> > > > > then send IPI to other CPUs, waiting the response, while several CPUs
> > > > > enter the __split_huge_pmd function, want to get the spinlock, but always
> > > > > in queued_spin_lock_slowpath,
> > > > > 
> > > > > Because long time no response to the IPI, that results in a softlockup.
> > > > > 
> > > > > As to sending IPI, it was in the patch
> > > > > 3b8c9f1cdfc506e94e992ae66b68bbe416f89610.  The patch is mean to send IPI
> > > > > to each CPU after invalidating the I-cache for kernel mappings.  In this
> > > > > case, after modify pmd, it sends IPI to other CPUS to sync memory
> > > > > mappings.
> > > > > 
> > > > > No stable test case to repeat the result, it is hard to repeat the test procedure.
> > > > > 
> > > > > The environment is arm64, 64 CPUs. Except for idle CPU, there are 6 kind
> > > > > of callstacks in total.
> > > > 
> > > > This looks like another lockup that would be solved if we deferred our
> > > > I-cache invalidation when mapping user-executable pages, and instead
> > > > performed the invalidation off the back of a UXN permission fault, where we
> > > > could avoid holding any locks.
> > > 
> > > Looking back at commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after
> > > invalidating the I-cache for kernel mappings"), the text implies that it
> > > should only do this for kernel mappings. I don't think we need this for
> > > user mappings. We have a few scenarios where we invoke set_pte_at() with
> > > exec permission:
> > 
> > Yes, I think you're right. I got confused because in this case we are
> > invalidating lines written by the kernel, but actually it's not about who
> > writes the data, but about whether or not the page table is being changed.
> 
> IIUC we may have a userspace problem analagous to the kernel modules
> problem, if userspace uses dlopen/dlclose to dynamically load/unload
> shared objects.
> 
> If userspace unloads an object, then loads another, the new object might
> get placed at the same VA. A PE could have started speculating
> instructions from the old object, and IIUC the TLB invalidation and
> I-cache maintenance don't cause those instructions be re-fetched from
> the I-cache unless there's a context synchronization event.
> 
> Do we require the use of membarrier when loading or unloading objects?
> If so, when does that happen relative to the unmap or map?

membarrier seems a bit OTT for this. Assumedly userspace is already having
to synchronise threads in this case so that (a) nobody is executing the old
object when it is unloaded and (b) nobody tries to execute the new
object until it has been successfully loaded. Squeezing in an ISB shouldn't
be too tricky, although I don't know whether it's actually done (especially
since the chance of this going wrong is so tiny).

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
