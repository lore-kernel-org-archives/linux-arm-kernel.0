Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19600C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:32:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC25520672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txIWNTzI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HpeA0cz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC25520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LEqggngkPq5N0m1sPv+ACZSFaqNWxI5zB3K+/nlbY7M=; b=txIWNTzITjihjS
	4YZplbzMm7Lz3tHrOF2f7Xb9GXumZv25gj0d4F02gCCPVQQFmGj0fPK9XvDIvXah4q8GzKb33OjnH
	iJPnoroJ2IRutWdLyDdA+svMrM8PeTNpFPueSNa7tGjkNsWW1HzwnJPYXwQwNO06ajEhzwY9dbHdh
	DQaZviVaS7LYLxdIQA5E/kewXjOYrZD//7aEdMnbjb+ibfszeaTqSPF4TNzrORDneofXiU2l2D0fg
	turAxckR7nRA470E6cMSUkT/NDYi86U97/wXjeK6TtuSHS0rHI/lG9IcUuDPzWcTB/oopRyETPuMB
	W93G5LBXNF6huP9u6YNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVI7E-0008S7-O2; Fri, 07 Dec 2018 15:32:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI68-0007bo-7L
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 15:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kX5cRM6rOkUVf/ABh7gNtlRi+Yl3G43Ak9za0HMI41g=; b=HpeA0cz8szKT4ZE/QoccNxc3/
 LiNOTYZiFWN9N+OIMu9eLs85h9RRQShTtkH0BqiGFZRPgEpDl4Cg4JT3VIo+CAJA9DGT1PgOuyf5g
 8QHV+N1vl6V3KanYGtk/N+CIPiF1eSSGoZyTXcYD41GfX4EnxK9Nrxkt7lEgw7elvGmcz3W60NskE
 GCBY8ZRpMHhDmvyrm9sFtLf90/cXumfIBUfcO5XdUgGzMlM29Vn+zDOZeiTlv1yiWLXC8fA9LxQ6e
 /0rvXJItARzqgVb8A2/cFVvl21nVnkWtnS/sx8k/IXtE5Wr+UXHBvcCJVlMmJnig4dPq7lEfcGVf/
 Nduz5oFOw==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVI64-0007Bc-RA
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:31:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB99515AB;
 Fri,  7 Dec 2018 07:31:09 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB1823F575;
 Fri,  7 Dec 2018 07:31:09 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 36CA41AE0BFF; Fri,  7 Dec 2018 15:31:31 +0000 (GMT)
Date: Fri, 7 Dec 2018 15:31:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] arm64: enable per-task stack canaries
Message-ID: <20181207153130.GA2835@edgewater-inn.cambridge.arm.com>
References: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_153121_039555_71CC449C 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: mark.rutland@arm.com, linux-hardened@lists.openwall.com,
 keescook@chromium.org, arnd@arndb.de, Ramana.Radhakrishnan@arm.com,
 linux-arm-kernel@lists.infradead.org, labbott@fedoraproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 03, 2018 at 06:03:43PM +0100, Ard Biesheuvel wrote:
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of sp_el0, which holds the task struct pointer in the arm64
> kernel.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Note that the cc-option invocation below relies on the fact that Ramana's
> current implementation of the GCC support permits -mstack-protector-guard=sysreg
> to appear without defining the register name or offset.
> 
> The $(eval) extends KBUILD_CFLAGS at the moment the make rule is applied,
> which means asm-offsets.o (which we rely on for the offset value) is built
> without the arguments, and everything built afterwards has the options set.
> 
>  arch/arm64/Kconfig                      |  5 +++++
>  arch/arm64/Makefile                     | 10 ++++++++++
>  arch/arm64/include/asm/stackprotector.h |  3 ++-
>  arch/arm64/kernel/asm-offsets.c         |  3 +++
>  arch/arm64/kernel/process.c             |  2 +-
>  5 files changed, 21 insertions(+), 2 deletions(-)

This looks really good to me, but I'm not sure what we should do next.
Ramana -- is your implementation stable, or are we likely to see changes
to the way the options are passed?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
