Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E4C61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:31:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A15F2086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RzB5jQPM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWpGMpGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A15F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E6ykUHB9aeY6fYg3x9tzxpJjD7qSBYe5k7FZZhamyZs=; b=RzB5jQPMssJ66U
	jEsYsH9cA94FyFUTEHQVeKwsKOCCqnpOeU0/UoRNgLzhuM72lP0UDKNHCrLBox8sEPqg3cVKCASxj
	f8r1r9CsNLR+UV0YCUAyKbDFmHbWk8kxuuS8mWdV/aSJ7tXQ/F75qJ8CcaoUPOLXqXPNSwN6VsTKN
	5n/HpBVYvOwhmkuSDRb5KoLQZSw2Y+HCd5sY2oggaYqlwCwWN8EIl6h6f8cUNhmyNflAoL5edNy9J
	plfGDDhHRrpjwkbPBhtQiwfq70YBbjYGrSHOXOsFZNh4LkHIMpherWRlx7QLm5yAVyUGPmUzJlIiq
	XDD2ibfvkYTR9n5YgGzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkqim-0001YY-2i; Sat, 19 Jan 2019 13:31:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkqii-0001YB-EK
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 13:31:33 +0000
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBAA82086A;
 Sat, 19 Jan 2019 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547904691;
 bh=69JKOV4aZJgNkcHQhaXRUy/LvLRubnjjGz8b+joy6xg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=JWpGMpGgYrSJ1SYVCdWK2KR35Hl+lLtVPTNZ9mE64uCtu7UEB3zj6PQ9SCmO6ZfmV
 znxq3kbP9ixGV2mTPkbQJEJX9tviIGJcIE2R8osVWjyn87HZKhNotKTcORumLHrz3N
 G1R4EcQywDrJiKRl0LuKkxD/Cq8BNlalfWcuB3+Q=
Date: Sat, 19 Jan 2019 22:31:26 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 0/4] arm64: kprobes: Update blacklist checking on arm64
Message-Id: <20190119223126.6741b98ffae45b52f433a650@kernel.org>
In-Reply-To: <20190116134007.GA15255@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <20190116134007.GA15255@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_053132_509396_11538D1E 
X-CRM114-Status: GOOD (  19.61  )
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
Cc: Pratyush Anand <panand@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
 "David A . Long" <dave.long@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Wed, 16 Jan 2019 13:40:07 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Masami,
> 
> On Tue, Jan 15, 2019 at 03:23:39PM +0900, Masami Hiramatsu wrote:
> > Hello,
> > 
> > Here is the v2 series of update of the kprobe blacklist
> > checking on arm64.
> > 
> > I found that some blacklist checking code were mis-placed in
> > arch_prepare_kprobe() and arch_within_kprobe_blacklist().
> > Since the blacklist just filters by symbol, smaller than the
> > symbol, like extable must be checked in arch_prepare_kprobe().
> > Also, all function (symbol) level check must be done by blacklist.
> > 
> > For arm64, it checks the extable entry address in blacklist
> > and exception/irqentry function in arch_prepare_kprobe().
> > And, RODATA check is unneeded since kernel/kprobes.c
> > already ensures the probe address is in kernel-text area.
> > 
> > In v2, I updated [1/4]'s description and added James'
> > Reviewed-by. Also, in this version, I added a patch which
> > uses arch_populate_kprobe_blacklist() instead of
> > arch_within_kprobe_blacklist() so that user can see the full
> > list of blacklisted symbols under the debugfs.
> 
> Assuming these are targetting the arm64 tree, are you intending to get them
> merged for 5.0?

No, I don't rush it, since these are not bugfix but just enhancements.
(User can see the blacklisted symbols precisely) If you think you are
easy to pick this to arm64/next, it is OK to me.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
