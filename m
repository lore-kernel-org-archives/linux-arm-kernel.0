Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:27:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE8F2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pJli6uvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE8F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GQw2vaZwCIz9q//SIq66lBboN62b9mk5SZFp9JLeUlo=; b=pJli6uvYg70y4z
	Cnyv18N5OkleXGmNWFYMmlsGKe2FaB7Tyu9tQ56UNXtLDVnUFCSOBce6UQ7CuWb9MwY9CrmOy/6NG
	Uad4Y80PB/Kbu2EWqG/ngMd0UzwUWUqTf9HAfM8fhG6tN5gDu5yUKvwShUXG/9jnvTbFNF8VQ4jVD
	Pnzz8TmtQDciP8jB6KgLc4wWuiicet+peUNc0jfDD2Vj0XTeUSw68phcFmGf9V2a0DboUI/Bj8F0e
	5KJXOxlRJd1toBDi/t7Urs8MtdqinMwJNbnEIl6kxAMSpwN5v+F5Tbwm0OsU47cAyl6LzQUrmZsD8
	XQTXT048/QaKAGhY7tWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt8oZ-00033P-Hx; Mon, 11 Feb 2019 10:27:51 +0000
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt8oV-00032Y-77; Mon, 11 Feb 2019 10:27:49 +0000
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 03D4F426; Mon, 11 Feb 2019 11:27:35 +0100 (CET)
Date: Mon, 11 Feb 2019 11:27:35 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu: Allow io-pgtable to be used outside of
 drivers/iommu/
Message-ID: <20190211102735.GA32526@8bytes.org>
References: <20190205163731.17864-1-robh@kernel.org>
 <20190205165528.GA20157@infradead.org>
 <CAL_JsqLYC6OStkM+bcwhM5cA3fBcXQCiL_pVUE=sPoLrPHoVvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqLYC6OStkM+bcwhM5cA3fBcXQCiL_pVUE=sPoLrPHoVvQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_022747_409702_48C037E6 
X-CRM114-Status: GOOD (  11.37  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@infradead.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 05, 2019 at 11:20:30AM -0600, Rob Herring wrote:
> On Tue, Feb 5, 2019 at 10:55 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Feb 05, 2019 at 10:37:31AM -0600, Rob Herring wrote:
> > > Move io-pgtable.h to include/linux/ and export alloc_io_pgtable_ops
> > > and free_io_pgtable_ops. This enables drivers outside drivers/iommu/ to
> > > use the ARM page table library. Specifically, some ARM Mali GPUs use the
> > > ARM page table formats.
> >
> > Maybe rename it to arm-io-pgtable.h to make the usage a little more
> > clear?
> 
> I should drop the first 'ARM' in the commit message.

Dropped and applied, thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
