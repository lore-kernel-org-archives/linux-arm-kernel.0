Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7615C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7140B2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r5LKy3y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7140B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Sd3GcUy5X8lPU0qBfVWTAvcIkNT1GAfE+zc9/h6f+o=; b=r5LKy3y9YinOHc
	598D4i96AYOP/n2UOx+HNtjxwFgNjycLjiDIBH8q/l+4gN42SCuutEN1P1fODROmHutK24eWkd0hi
	Ny3TVSiUM4PP/FxdSIg8eUjoKeZ0acv0FIpC5EiJ0QKF2GFt+4wPLfDb4y4oi6pC8k5zSf+3Z1qUv
	3t0tq8/C2EF6A8uotKeU49hbZt0Fa2nV2I1ZUEM9nCj5hrb3a2+zBH1h1Pm1joQeCVTyAfMhMhEBI
	//3jns++PMPhWHioKRhIkTDC23QbRQNPp09riXGRO9E8BHfa0G1779d7c7ldo7X8uBQxIQIDLBk4F
	StZGEUdsuec+jRraeqYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqf22-0005wW-Ji; Mon, 04 Feb 2019 14:15:30 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqf1z-0005w9-3h
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 14:15:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8412180D;
 Mon,  4 Feb 2019 06:15:26 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749693F557;
 Mon,  4 Feb 2019 06:15:25 -0800 (PST)
Date: Mon, 4 Feb 2019 14:15:20 +0000
From: Will Deacon <will.deacon@arm.com>
To: Qian Cai <cai@lca.pw>
Subject: Re: kernel_page_tables issue with CONFIG_ARM64_USER_VA_BITS_52=y
Message-ID: <20190204141520.GA22521@fuggles.cambridge.arm.com>
References: <fe7fa86a-42ed-ee58-be26-4d8ae45fadab@lca.pw>
 <20190201134847.GC29903@fuggles.cambridge.arm.com>
 <1549054142.6911.25.camel@lca.pw>
 <20190204102715.GA11645@capper-debian.cambridge.arm.com>
 <1549288674.6911.27.camel@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549288674.6911.27.camel@lca.pw>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_061527_156602_D3ED579E 
X-CRM114-Status: GOOD (  12.76  )
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, nd <nd@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Steve Capper <Steve.Capper@arm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 08:57:54AM -0500, Qian Cai wrote:
> On Mon, 2019-02-04 at 10:27 +0000, Steve Capper wrote:
> > On Fri, Feb 01, 2019 at 03:49:02PM -0500, Qian Cai wrote:
> > > On Fri, 2019-02-01 at 13:48 +0000, Will Deacon wrote:
> > > > Hi Qian Cai,
> > =

> > [...]
> > =

> > > Unfortunately, although this takes care of kernel_page_tables, it bre=
aks
> > > efi_page_tables.
> > > =

> > > # cat /sys/kernel/debug/efi_page_tables
> > > BUG()
> > > =

> > > # ./scripts/faddr2line vmlinux walk_pgd+0x84/0x254
> > > walk_pgd+0x84/0x254:
> > > __read_once_size at include/linux/compiler.h:193 (discriminator 1)
> > > (inlined by) walk_pgd at arch/arm64/mm/dump.c:345 (discriminator 1)
> > > =

> > > 344:=A0=A0=A0=A0=A0=A0=A0=A0do {
> > > 345:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pgd_t pgd =3D REA=
D_ONCE(*pgdp);
> > > 346:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0next =3D pgd_addr=
_end(addr, 0);
> > > =

> > > kernel BUG at arch/arm64/mm/dump.c:332!
> > > =

> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0BUG_ON(pud_bad(pud));
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0walk_pmd(st, pudp, addr, next);
> > > =

> > =

> > Hi Qian Cai,
> > Apologies for missing the efi_page_tables.
> > =

> > Does the following (applied to Will's fix) help?
> > =

> =

> Yes, it works great!

Thanks for testing this so quickly. I'll fold the change (minus the sentinel
entry) into my patch and queue up as a fix.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
