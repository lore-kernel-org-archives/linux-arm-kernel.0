Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA79C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:43:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B7F20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zdv/sXAp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PYYzwo0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B7F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UDBN4twTdbZElmfAN9VDGrs5sGtaykgq1NIUg7ElOYw=; b=Zdv/sXApQem6hv
	pm//to8Ib3Cl8GtoYaT6SieS3mhn2i+IAr/4Gdpm61gw1louPyrvjTBbBz3cFiHN/wBqLO+T2TTVX
	k7APtC7EhKJb1vMUN9LL6iGz9kYr1Ux47Bb2l92pqJp4FNztlwe6Ho54A1bBlkOuNK5tpuHGol3ID
	fKOZ1Wt88CkwJqlvMWfOB3vVdAH0rjILDGYqwXjF0ycxoZL0uWG7jAGpPgBcqVCXQnqWoPp5UnSeU
	XUDvpToRG7BK7WvTFMc0twE/QcF2FxYK8ieqldFJ9BVz+RGMgZEv02Ann0/PQnGvVvmgjbcnb6G5W
	a2vPL/J+/ppqwTLBnUxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSohc-0001wX-5b; Fri, 30 Nov 2018 19:43:52 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSohY-0001vR-VB
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 19:43:50 +0000
Received: by mail-lj1-x236.google.com with SMTP id v15-v6so5987315ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0fFziNXyQiaQ1gvrUPztS5FG34FXTL1N9RRdX0cNN0I=;
 b=PYYzwo0tMsYcbfvIwf5RJHUWXOgcVNaoJMWTqvQHUXo6niteO0eX+YGc9YbavQQZ4o
 A3xhEHVVs3h8icNVlNAfkkD18bgt6X8F/+ZxJmD6Dohzfq+w2vLdqOs3NbA9JWYuqqhV
 ggiiYzO4IlKiR7LYTtwCRapGsYtr1FAz+wjs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0fFziNXyQiaQ1gvrUPztS5FG34FXTL1N9RRdX0cNN0I=;
 b=PZBoftm370Nb2LdUnfgPtFXJmdpHnlW5LKDRTy6I5LhcHhV5x51U/R76bVN/amlq8L
 mV+wM093JZK29l9LZAy4PD0NZraBGquDCOtp68G7tIEP3tCJJDy0R2UYZODhxnR4bSgr
 cRHcMUQQ/xwcikOxk6XA/pNVojFcT7Ok2rf+61Tre6UELp94LhEwWko27Ilq0l01Fivy
 QqzzpU3NvHoZT/y/YYNSvjJePYHUlJIMI3O1/OPxtAMTzhaajkPYNzQEV0ICM7sYZ/WH
 HgoCcDMnH6qn+SG8FA/NiQmHaK50zscixppsec/4lHinJmS4YAHKnQ+sEnqMqHJrkwfY
 2GTA==
X-Gm-Message-State: AA+aEWbT5Xe2f/+dIrin8jDS/QAfpYIXgQXEzi9yBLNHpN57E4R6N7Vm
 YqBqiAL7+V1uEMetktvYaqMSk9QbHPE=
X-Google-Smtp-Source: AFSGD/UZtDQnLb+w+T6w41VzMhGU7VyaFjDefSIdRIAQHgUHCukWrXckHuipzqRcwLBnfBBhjeZBxQ==
X-Received: by 2002:a2e:681a:: with SMTP id
 c26-v6mr4586091lja.175.1543607016108; 
 Fri, 30 Nov 2018 11:43:36 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id e82sm973808lfg.34.2018.11.30.11.43.34
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Nov 2018 11:43:35 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id z13so4926108lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 11:43:34 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr4584103lfg.117.1543607014101; 
 Fri, 30 Nov 2018 11:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20181130132231.16512-1-hch@lst.de>
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Nov 2018 11:43:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia7wykuDu-mzbhF+rL1M9FnJfnoidsvkz5TPMPHUep7g@mail.gmail.com>
Message-ID: <CAHk-=wia7wykuDu-mzbhF+rL1M9FnJfnoidsvkz5TPMPHUep7g@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_114349_008232_9609B395 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jdmason@kudzu.us,
 xen-devel@lists.xenproject.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 5:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Error reporting for the dma_map_single and dma_map_page operations is
> currently a mess. [..]

I don't see anything objectionable there, but it's not like I checked
any of the context of the patches. For all I know there are odd corner
cases where some zero vs DMA_MAPPING_ERROR confusion lurks, but I
guess we'll find out..

So you can add my acked-by, fwiw.

                Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
