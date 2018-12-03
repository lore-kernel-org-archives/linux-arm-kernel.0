Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:32:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B45820834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ALR8g9iI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B45820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9LcMM18/ybmJXbiGylp+eH1qHfn1KXlrB+3dD11NbF4=; b=ALR8g9iIYZKzsF
	ei/5SAtXJhIISN3FLdV2tWZKw4HxbMLOoAZWIDUnVNV4MogdzPctOQzKByyCahVpP/NjHz9N41dzC
	A1fCt+geIdbfZDXK8tvw5syMFNqFuC9FtR5EbhW3MEFe/ubQKnHclMuej4uS0128poDGFE3uly+SN
	hcfDIU8SceyYxhfzU7PFX5G7n0Bz9Ho8h20Zna9OT7pQu0MWEbg/qH2TAB79UePjFPDWc7RHxQX8P
	xMYPH6hXe6+lZ6dMh1z/Zf9fTipycTWnhIFQor35zGEr5VyfCJvKGnC9zGk55wcyvC4Mt/zIwdcaf
	c7uOjODvOdyJHfd90j/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqDN-0008EE-3K; Mon, 03 Dec 2018 15:32:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqDI-0008DA-Mp
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:32:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247ED1682;
 Mon,  3 Dec 2018 07:32:36 -0800 (PST)
Received: from localhost (unknown [10.1.38.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAA533F5AF;
 Mon,  3 Dec 2018 07:32:35 -0800 (PST)
Received: from cmarinas by localhost with local (Exim 4.89)
 (envelope-from <catalin.marinas@arm.com>)
 id 1gTqD2-0003GH-Qi; Mon, 03 Dec 2018 15:32:32 +0000
Date: Mon, 3 Dec 2018 15:32:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: Unexpected variation in SYS_ID_AA64MMFR0_EL1
Message-ID: <20181203153232.no5yiliofqtfelfu@localhost>
References: <e2130285-6e51-f1c9-7b91-6b0467a15de6@free.fr>
 <CAKv+Gu-cms32Vun16bdM+n_OkH7w7knf45S3eGhVjbG3VdFgbA@mail.gmail.com>
 <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44c18e70-e4d9-5e4d-1326-aa1f88a16315@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_073248_743981_80730AA5 
X-CRM114-Status: GOOD (  18.25  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, marc.w.gonzalez@free.fr,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Dave Martin <Dave.Martin@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 01:23:28PM +0000, Suzuki K. Poulose wrote:
> On 30/11/2018 13:12, Ard Biesheuvel wrote:
> > On Fri, 30 Nov 2018 at 13:15, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > > On an APQ8098-based system, for cores 4-7 (little cores?), the kernel prints:
> > > 
> > > [    0.179055] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1.
> > > Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
> > > 
> > > TGran16, [23:20]
> > >      Support for 16KB memory translation granule size:
> > >          0x1     Indicates that the 16KB granule is supported.
> > > 
> > > Since this is a pr_warn, I get the feeling something is not quite right.
> > > Is there something to fix? Is it a problem that the big and little cores
> > > don't support exactly the same granule sizes?
> > > 
> > 
> > That looks like a false positive to me. We should only care about the
> > page size we are running with.
> 
> Unless you run a VM, which is going to use 16K translation. But this may be
> fine with the current kernels, where we emulate the SANITISED registers
> for the guests.

I think that's sanitised now for KVM, so we could downgrade the feature
to FTR_NONSTRICT.

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
