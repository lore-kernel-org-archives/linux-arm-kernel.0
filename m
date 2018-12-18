Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:22:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875C521841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jqMeiqJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875C521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pU8fe3tpTUjPzqyPj7yxzO7KGV/Pawh9r4YmXBhZh1g=; b=jqMeiqJ3hHK1Jh
	kfV5fec4pJviP8Rtf6kiXy+uwO/juVyGKOG3hPT+gwmaO6/O7lLiKrwSoLs6ard/DjOwTij7rQIXs
	6TUXvf8zVUj3eY+qin7vQ2g0D9exTLMD0D7UO0BLOPqkl2hFlcPtAVwLEJfFQE0XD1uzy7bhT2lRI
	qTCrtCcisFtEP4dp/xNpMWujm8o8ZgpuicuAd+0jXoSFzP5BGpIghmiUtkVkngROzxckQVvPuW59n
	mULuFT7ohBddUnWWsWKZ4FrNxfzVAHVhQH/+znmhKVtVeJ8yqVE6mFhxJIVimXvE5TyvHpQiM++g5
	+4cN6RLJFvpAFCpJj/lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZFK1-0004DR-VC; Tue, 18 Dec 2018 13:22:05 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZFJy-0004Cb-Vt
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 13:22:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D96D780D;
 Tue, 18 Dec 2018 05:21:50 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5D0223F575; Tue, 18 Dec 2018 05:21:49 -0800 (PST)
Date: Tue, 18 Dec 2018 13:21:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko]
 undefined!
Message-ID: <20181218132146.GA20197@arrakis.emea.arm.com>
References: <20181218093630.io6p4ovl36hnxalk@laureti-dev>
 <20181218100908.GL26090@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218100908.GL26090@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_052203_030940_7D5EA9DC 
X-CRM114-Status: GOOD (  12.93  )
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
Cc: Juergen Gross <jgross@suse.com>, Helmut Grohne <helmut.grohne@intenta.de>,
 Will Deacon <will.deacon@arm.com>, Paul Durrant <paul.durrant@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Ben Hutchings <ben@decadent.org.uk>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 10:09:09AM +0000, Russell King wrote:
> On Tue, Dec 18, 2018 at 10:36:32AM +0100, Helmut Grohne wrote:
> > During a compile test of v4.20-rc7 for armhf (cross build), I
> > encountered:
> > 
> > ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> > 
> > Some searching brought up c5157101e77 ("arm64: mm: Export
> > __sync_icache_dcache() for xen-privcmd"), which fixes a very similar
> > problem for arm64. Is that commit maybe also needed for arm?
> 
> I would rather not export that function for drivers to abuse.

I think that's a lower risk than the other cache maintenance functions.
This function only deals with the cache maintenance to PoU while
drivers, in general, are more interested in the PoC.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
