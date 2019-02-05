Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F3C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:34:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A11520844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ICHyzLRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A11520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fGU1WK7zliH0fFmqR5X+yYpR7U0OyX52m8UUjJoSceg=; b=ICHyzLRwXBsoB9
	/c/+BwBDkaS+HvaBogPYmY7aKZf29NEnHsImsraTbiuWulUqB3u/ly++Y1in+qmTj683ghjFJtUMH
	D05dXhK9/hTLg6Np7AemiyFQgaDzCuavGyIvR6s+kUgrt5FbaaJ3fLaPegtQdrTUuhI/koWZ8VC5c
	RhDcX1TkSMn/xBwkUg3Eh6Jpdutg0QNdJvOdz7qDy24sw5KcwvHrgi27j6PYR7i3/dAfWdvwpQSE5
	NK2Av5TQIvVSPdDSoWDtyigzIZ+7MQSNAQ1NeTltc9YOMYEMh+QQJ8GJi+GV1JWhkA4DUVo0Ywft+
	YyedhduIPW42KoA0aG3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqx7O-0002SR-Ob; Tue, 05 Feb 2019 09:34:14 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqx7L-0002Rz-6v
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:34:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 222C9EBD;
 Tue,  5 Feb 2019 01:34:09 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D7B3F71E;
 Tue,  5 Feb 2019 01:34:08 -0800 (PST)
Date: Tue, 5 Feb 2019 09:34:03 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH] arm64: kexec_file: handle empty command-line
Message-ID: <20190205093403.GA25601@fuggles.cambridge.arm.com>
References: <20190201162608.20815-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201162608.20815-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_013411_260865_F64FFB1C 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 04:26:08PM +0000, Jean-Philippe Brucker wrote:
> Calling strlen() on cmdline == NULL produces a segfault. Since having a
> NULL cmdline is valid, handle this case explicitly.

By "segfault" you mean kernel oops, right? If so, I'll pick this up as a
fix, thanks.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
