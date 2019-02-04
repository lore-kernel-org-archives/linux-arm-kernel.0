Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A2C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:45:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3642081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yiu4ymVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3642081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mCCsvj35ItXbfmGjQIf4AOLpAmEwS0ADC0015iYPlgM=; b=Yiu4ymVUvM0aqT
	jhg/vwa7HJkymf+vD2V2dvCyKrTmd75xhO+4VoLOrQAtw+4XVlEDLTWuyyvZaNGEFUYDQA1T/4tlo
	vkKKutH3f259f8v8T+LB3vvGQ+rzG3XHBD+Jnz0+WQPl4C1QDUQjZh0bKLJUk9sbPWMj1zm6vThz0
	Uh+Gqbhy1Oe/QGy+R7Ignw8cLQi63bSRGcJ1lzJDPpAc6iLZAToaP/tniMewQCx2JnalTqSBgOcwn
	9P3565Y+HxEQ5olWJIsgHzZLOurhz75NS2Z52lpIM1L0LSWX2FPew4pxJYoYhBynuPVSQCFkVdYQ+
	9SwY9489XeCtcoPk5S+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeYR-0000ju-5Q; Mon, 04 Feb 2019 13:44:55 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeYN-0000jb-Sv
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:44:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FCDAA78;
 Mon,  4 Feb 2019 05:44:51 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADBF03F557;
 Mon,  4 Feb 2019 05:44:49 -0800 (PST)
Date: Mon, 4 Feb 2019 13:44:45 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] efi/arm: Don't expect a return value of
 ptdump_debugfs_register
Message-ID: <20190204134445.GA22170@fuggles.cambridge.arm.com>
References: <20190201192001.6495-1-natechancellor@gmail.com>
 <CAKv+Gu9tcpZvMZdbD0D+EUCTbdnszv3+MHM68utLZssuMcxyZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9tcpZvMZdbD0D+EUCTbdnszv3+MHM68utLZssuMcxyZw@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_054451_932693_46C5FC92 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 11:18:22PM +0100, Ard Biesheuvel wrote:
> On Fri, 1 Feb 2019 at 20:21, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > As of commit e2a2e56e4082 ("arm64: dump: no need to check return value
> > of debugfs_create functions") in the arm64 for-next/core branch,
> > ptdump_debugfs_register does not have a return value, which causes a
> > build error here:
> >
> > drivers/firmware/efi/arm-runtime.c:51:9: error: returning 'void' from a
> > function with incompatible result type 'int'
> >         return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> >
> > The arm version is still awaiting acceptance [1] but in anticipation
> > of that patch being merged, restructure this function to call
> > ptdump_debugfs_register without expecting a return value.
> >
> > [1]: https://lore.kernel.org/lkml/20190122144114.9816-3-gregkh@linuxfoundation.org/
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> 
> Catalin, Will,
> 
> Could you please apply this directly?

Sure, we'll pick it up.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
