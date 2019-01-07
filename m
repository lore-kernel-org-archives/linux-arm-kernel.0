Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33DBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:46:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A267B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MdI0z/Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A267B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GH6TRNy1QfWbufD7VvOnBCfIYu+0dtGNxdeTJnTq92o=; b=MdI0z/PjpMenGQ
	6jZjIKWEuzMy0JiAli35jGlW45eXFqdSbESBDCqI242mkxJLnyLfYt5Qzjjp2xJJyE/N3oCDuoeYG
	5fYlkCqb9CVPmjSmYa0W1LpR+veOQgi5chWpxMz6tfk7q7IPRUQ1OnD/1F+OEYliWJXPNO/EvBeb+
	elx+E62cRRbrwc3PMGJAkEfjBUWjUL4srUNhIhut9x322C5XYiS1JHxOLo3mwEV5PeCdGQ2zb/Shd
	8To6P0I+Ma0gRIHDhKj6q+U82dmxX2N/HQ98bPgqnCJmbhlUGSm+O7Q+ML9KdQjLm3opYXad2iwiZ
	a+bwwQq9TZly579O7qnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggYyr-0003ii-15; Mon, 07 Jan 2019 17:46:29 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggYyn-0003iC-Qk
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 17:46:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C2C780D;
 Mon,  7 Jan 2019 09:46:23 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55EFA3F5A0;
 Mon,  7 Jan 2019 09:46:22 -0800 (PST)
Date: Mon, 7 Jan 2019 17:46:17 +0000
From: Will Deacon <will.deacon@arm.com>
To: Shijith Thotton <sthotton@marvell.com>
Subject: Re: performance regression of migrate_pages system call
Message-ID: <20190107174617.GA22911@fuggles.cambridge.arm.com>
References: <DM6PR18MB2460C36E0501F0ACF9493ADBD98C0@DM6PR18MB2460.namprd18.prod.outlook.com>
 <DM6PR18MB2460B4DD47FA23A0F091B351D9890@DM6PR18MB2460.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR18MB2460B4DD47FA23A0F091B351D9890@DM6PR18MB2460.namprd18.prod.outlook.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_094625_872046_9E3E2961 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
 Ganapatrao Kulkarni <gkulkarni@marvell.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 anshuman.khandual@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 07, 2019 at 08:44:47AM +0000, Shijith Thotton wrote:
> On 01/02/2019 07:22 PM, Shijith Thotton wrote:
> > Observed migrate_pages03 of LTP is failing on ARM with v4.19 kernel. Test was
> > run on ThunderX2 99xx with 2 sockets. migrate_pages syscall was taking 1+
> > seconds and caused a timeout in the test.
> > 
> > strace output:
> > <...>
> > [pid 35146] 14:11:14 migrate_pages(0, 64, [0x0000000000000001],
> > [0x0000000000000002]) = 0 <1.099427>
> > [pid 35146] 14:11:15 migrate_pages(0, 64, [0x0000000000000002],
> > [0x0000000000000001]) = 0 <1.145143>
> > <..>
> > 
> > Git bisect points to following change as the cause of regression.
> > commit 3b8c9f
> > arm64: IPI each CPU after invalidating the I-cache for kernel mappings
> > 
> > Regression happens with 4K page size and not with 64K pages.
> > Please let me know if anyone is experiencing similar issue.
> > 
> 
> Please comment if a solution like below (by modifying sync_icache_aliases) is 
> possible for fixing the regression.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-December/618866.html
> 
> Function trace:
> migrate_pages()
>    + unmap_and_move()
>      + __unmap_and_move()
>        + remove_migration_ptes()
>          + set_pte_at()
>            + __sync_icache_dcache()
>              + sync_icache_aliases()
>                + flush_icache_range()
>                  + kick_all_cpus_sync()

Unfortunately, we can't drop the IPI in this case because we really do need
to ensure that other CPUs have drained any instructions previously fetched
from the new physical page.

Adding Anshuman to cc, since I think he's been looking at other ways to
improve this.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
