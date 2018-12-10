Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE378C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:02:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915ED2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cOah6Xmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915ED2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wl/d//Y36dP/pmyKJnjnnIR6L2/2Odahtd99n99DhIk=; b=cOah6XmhmVpqIm
	oIQtFB7XtfnGdUj1JaT77Tuc4q+R9dJoPuioTnH7xFi/xUvbM9zjyzApulxraqV/JTshY6qn4oWD2
	0NO7lMGwDeluxmDiu9hfvHXd0QEtu7KR1rBxqNBaTBGCqvXeWZai+rghQph1VVaueM3FQr8BhUjjh
	77/4XGGCOVamHNcR5FW7a52jkxew8XKVky3hXyoUqO+od1cHIwJl/N05WBRe8IWpy0ReaForyuC4u
	kDs1zpmRQx7EE8sFf2hZhYmfBipJk+1lFfABfL/Dtt0MB5VuaKfZNfHLxA6UwSzifxPJH7HPbg3ev
	BGIcc+mztgSZXH4EyQPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWHRx-0005xW-Rh; Mon, 10 Dec 2018 09:02:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWHRt-0005wu-RO
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 09:02:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E4B1596;
 Mon, 10 Dec 2018 01:01:47 -0800 (PST)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEB343F575;
 Mon, 10 Dec 2018 01:01:46 -0800 (PST)
Date: Mon, 10 Dec 2018 10:01:45 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v9 3/8] KVM: arm/arm64: Introduce helpers to manipulate
 page table entries
Message-ID: <20181210090145.GE30263@e113682-lin.lund.arm.com>
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-4-punit.agrawal@arm.com>
 <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <396402d5-fddf-ab72-01c4-80dd1a0d4d44@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_010157_886997_453359E5 
X-CRM114-Status: GOOD (  15.08  )
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
Cc: suzuki.poulose@arm.com, marc.zyngier@arm.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 punitagrawal@gmail.com, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 07:20:08PM +0530, Anshuman Khandual wrote:
> 
> 
> On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> > Introduce helpers to abstract architectural handling of the conversion
> > of pfn to page table entries and marking a PMD page table entry as a
> > block entry.
> 
> Why is this necessary ? we would still need to access PMD, PUD as is
> without any conversion. IOW KVM knows the breakdown of the page table
> at various levels. Is this something required from generic KVM code ?
>   
> > 
> > The helpers are introduced in preparation for supporting PUD hugepages
> > at stage 2 - which are supported on arm64 but do not exist on arm.
> 
> Some of these patches (including the earlier two) are good on it's
> own. Do we have still mention in commit message about the incoming PUD
> enablement as the reason for these cleanup patches ?
> 

Does it hurt?  What is your concern here?


Thanks,

    Christoffer

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
