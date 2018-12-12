Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669ACC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273642086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mb7lHRfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273642086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VgRh0Aj5OGV4ZA+nHzxF1cIIm96O9OWAlT/AAuJWzd4=; b=mb7lHRfq+zZ16M
	/c3zfuzf7pBmvyAVU2Ixfudt76Yj2VzDutL4uRTQ+v+MNLGek9K+pkKx+hev3oCym+0tEP1UkHYv9
	DxhsYJ3cghWRFUDcZWAbk2Zg62kdWx4lOWrQataBhxGYsr8+OPY2Xa+rD3/vwG6s7VqEV+sn2izw2
	tlJxpQMNXvtOiDYgjiM/lKP2Z7pv7I89OYuyZPAf2QPJdZpsnfD5DMAdDoR5T6FwRotTE/qJ/XCwx
	csRthoEMz4yTToeTlDlE2elBSqjSovm/4rAqMPVv2K1ujFd49LNHo5VyMdBkPLRZsaaULNsWZ5Yvs
	2F3fR2FBZ3mjzhesdS3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXABU-0004E0-1r; Wed, 12 Dec 2018 19:28:40 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXABQ-0004DJ-MO
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 19:28:37 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A7280D;
 Wed, 12 Dec 2018 11:28:21 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48A193F59C;
 Wed, 12 Dec 2018 11:28:21 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id C59B91AE0BDC; Wed, 12 Dec 2018 19:28:44 +0000 (GMT)
Date: Wed, 12 Dec 2018 19:28:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] arm64: enable per-task stack canaries
Message-ID: <20181212192844.GA22013@edgewater-inn.cambridge.arm.com>
References: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
 <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_112836_730887_676B9668 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-hardened@lists.openwall.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Laura Abbott <labbott@fedoraproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 09:50:37AM -0800, Kees Cook wrote:
> On Wed, Dec 12, 2018 at 4:08 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > This enables the use of per-task stack canary values if GCC has
> > support for emitting the stack canary reference relative to the
> > value of sp_el0, which holds the task struct pointer in the arm64
> > kernel.
> >
> > The $(eval) extends KBUILD_CFLAGS at the moment the make rule is
> > applied, which means asm-offsets.o (which we rely on for the offset
> > value) is built without the arguments, and everything built afterwards
> > has the options set.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

I've bitten the bullet and queued this for 4.21. We can always revert it
if the compiler support falls apart, but at this point the worst I can see
happening is that we have to change the name of an option.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
