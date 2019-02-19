Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BF4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966072183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZPISXb06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966072183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hIEpyCEROOWknhkx9zNzZ0FerRlVc4v93QJMJ4yrnK8=; b=ZPISXb06YHXi4M
	qsp2i2KnN21PNmhpZ+jslP0G7GqgpYX8szxWSlMRO+z4crSOCmP/0hP96T4ByNhWpAjI4fyZ1T4oq
	WVKf1v2LirObTRI1K/rp/kM3XrsM1eZ/H9mQhAh7paHZlV5sn4iPVkSOVVtehEaBFcJg1ad1SJ4pS
	nWLRrY1N8THtnVc+QtxlVjCQE8AcAgy+RPWWkW9zUXyLwe/OyXPCY379a56Opu/iUjuEofK3K6m+r
	K0vcTetqoLxg+kf0ElLIrKElWcR2LbQjm2kjfINCEq/VfbqVd2nBRiubbtULbh9H/b7smh7+kq9nW
	LUdL0myQvrOJg5kWM5Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw4pG-0007FF-Mb; Tue, 19 Feb 2019 12:48:42 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw4pD-0007Ee-LL
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 12:48:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAE8915AB;
 Tue, 19 Feb 2019 04:48:38 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84DE83F720;
 Tue, 19 Feb 2019 04:48:27 -0800 (PST)
Date: Tue, 19 Feb 2019 12:48:25 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/9] 52-bit kernel + user VAs
Message-ID: <20190219124825.GH8501@fuggles.cambridge.arm.com>
References: <20190218170245.14915-1-steve.capper@arm.com>
 <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_xOFXLwKsrFo-rBXdgk4O6zm6xPHB+tv1XjDjzyrjhEA@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_044839_706940_F849F7D1 
X-CRM114-Status: GOOD (  25.05  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, crecklin@redhat.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Steve Capper <steve.capper@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 19, 2019 at 01:13:32PM +0100, Ard Biesheuvel wrote:
> On Mon, 18 Feb 2019 at 18:05, Steve Capper <steve.capper@arm.com> wrote:
> >
> > This patch series adds support for 52-bit kernel VAs using some of the
> > machinery already introduced by the 52-bit userspace VA code in 5.0.
> >
> > As 52-bit virtual address support is an optional hardware feature,
> > software support for 52-bit kernel VAs needs to be deduced at early boot
> > time. If HW support is not available, the kernel falls back to 48-bit.
> >
> > A significant proportion of this series focuses on "de-constifying"
> > VA_BITS related constants.
> >
> > In order to allow for a KASAN shadow that changes size at boot time, one
> > must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> > start address. Also, it is highly desirable to maintain the same
> > function addresses in the kernel .text between VA sizes. Both of these
> > requirements necessitate us to flip the kernel address space halves s.t.
> > the direct linear map occupies the lower addresses.
> >
> > One obvious omission is 52-bit kernel VA + 48-bit userspace VA which I
> > can add with some more #ifdef'ery if needed.
> >
> 
> Hi Steve,
> 
> Apologies if I am bringing up things that have been addressed
> internally already. We discussed the 52-bit kernel VA work at
> plumber's at some point, and IIUC, KASAN is the complicating factor
> when it comes to having compile time constants for VA_BITS_MIN,
> VA_BITS_MAX and PAGE_OFFSET, right?
> 
> To clarify what I mean, please refer to the diagram below, which
> describes a hybrid 48/52 kernel VA arrangement that does not rely on
> runtime variable quantities. (VA_BITS_MIN == 48, VA_BITS_MAX == 52)
> 
> +------------------- (~0) -------------------------+
> |                                                |
> |            PCI IO / fixmap spaces              |
> |                                                |
> +------------------------------------------------+
> |                                                |
> |             kernel/vmalloc space               |
> |                                                |
> +------------------------------------------------+
> |                                                |
> |                module space                    |
> |                                                |
> +------------------------------------------------+
> |                                                |
> |                BPF space                       |
> |                                                |
> +------------------------------------------------+
> |                                                |
> |                                                |
> |   vmemmap space (size based on VA_BITS_MAX)    |
> |                                                |
> |                                                |
> +-- linear/vmalloc split based on VA_BITS_MIN -- +
> |                                                |
> |    linear mapping (48 bit addressable region)  |
> |                                                |
> +------------------------------------------------+
> |                                                |
> |    linear mapping (52 bit addressable region)  |
> |                                                |
> +------ PAGE_OFFSET based on VA_BITS_MAX --------+
> 
> Since KASAN is what is preventing this, would it be acceptable for
> KASAN to only be supported when you use a true 48 bit or a true 52 bit
> configuration, and disable it for the 48/52 hybrid configuration?
> 
> Just thinking out loud (and in ASCII art :-))

TBH, if we end up having support for 52-bit kernel VA, I'd be inclined to
drop the 48/52 configuration altogether. But Catalin's on holiday at the
moment, and may have a different opinion ;)

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
