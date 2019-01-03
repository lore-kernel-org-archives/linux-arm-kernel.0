Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90139C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:45:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC1420815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xq0aUC0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC1420815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N7ZPcWqbWTlJ4AcIRM0caLaRvn39CL0G8YnxbiY5r+I=; b=Xq0aUC0NQo2f71
	46N9iNEK3VTZMXF/nSA/6gPb2PNFqSzUHB1zn568NZh899naZxaCiYhczwMH6DUIdlI3hx3tXnOhK
	hRmX8YSBk2sav6a3UQ9zO6c6N9eJTE+Vdywxg64ISc6ISO0Acg8nptD0sKXMCgFEVkg31XsN3Gh4X
	PQsMGAKrbhDTH+AoOfENvM4dQsmPUTxszc6xHBhv51CKO/NRQmeXcjaBEmVB0hMnN8WE78oTr6Mp8
	P5lHOaKhiIa6p7ZOmmNvNx0/UpPH4YKS8wYkTqHHUutSv4HdToT7RfPVZtp6Fdgt5Eav1utzzBp2K
	VmT8bkM7lhoKch0ZaH9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf5BO-0001MB-L2; Thu, 03 Jan 2019 15:45:18 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5B9-0000NW-HZ
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 15:45:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932F915AD;
 Thu,  3 Jan 2019 07:45:02 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 619B13F575;
 Thu,  3 Jan 2019 07:45:02 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 8FA441AE0BD1; Thu,  3 Jan 2019 15:45:02 +0000 (GMT)
Date: Thu, 3 Jan 2019 15:45:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] arm64: smp: Fix compilation error
Message-ID: <20190103154502.GG16311@edgewater-inn.cambridge.arm.com>
References: <1546047797-48275-1-git-send-email-zhangshaokun@hisilicon.com>
 <CALAqxLWVBjRSihoVH=5rBtX5q7H37-4NFFfy4=MYcKqGtBG2qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLWVBjRSihoVH=5rBtX5q7H37-4NFFfy4=MYcKqGtBG2qQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_074504_615517_9AE1967F 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 02, 2019 at 02:28:38PM -0800, John Stultz wrote:
> On Fri, Dec 28, 2018 at 5:44 PM Shaokun Zhang
> <zhangshaokun@hisilicon.com> wrote:
> >
> > For arm64: updates for 4.21, there is a compilation error:
> > arch/arm64/kernel/head.S: Assembler messages:
> > arch/arm64/kernel/head.S:824: Error: missing ')'
> > arch/arm64/kernel/head.S:824: Error: missing ')'
> > arch/arm64/kernel/head.S:824: Error: missing ')'
> > arch/arm64/kernel/head.S:824: Error: unexpected characters following instruction at operand 2 -- `mov x2,#(2)|(2U<<(8))'
> > scripts/Makefile.build:391: recipe for target 'arch/arm64/kernel/head.o' failed
> > make[1]: *** [arch/arm64/kernel/head.o] Error 1
> > GCC version is gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
> 
> I hit this as well this morning!  Thanks for sending this out!
> 
> > Let's fix it using the UL() macro.
> >
> > Fixes: 66f16a24512f ("arm64: smp: Rework early feature mismatched detection")
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> 
> Looks like this fixes the build issue!
> 
> Tested-by: John Stultz <john.stultz@linaro.org>

Thanks, I'll pick this up with some minor tweaks so that we consistently
use UL() for all the shifts in this file that aren't guarded by #ifndef
__ASSEMBLY__.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
