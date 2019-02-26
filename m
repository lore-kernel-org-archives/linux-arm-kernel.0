Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0588217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZPHZMUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0588217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=giysoemfIb5iu8JNhpt/umBSRpVga5UEq3IrmpD5YnY=; b=sZPHZMUzMgBXJT
	H2rKmMEoXnig6AfywRfTuirz2CYLBGXHR6mni6xS8PKdwv/DUdt9DJwgN8enGSvqNuQDHXr+pVaYq
	EDxObvLkn2p9so8GFuvFQwFikTjEXWh0+I+bHW0Yv/Kl3c7HVaneaVAIS+UAFp5mlWbDJ7r9DpDOu
	V/F4bnhLZBELEYn70I+qlqxWcRB3IeNSWcmvJ3PFeiQso24QnePc+wy/0O7EORlgFnJJ+s8RhLny/
	Y3/YUBcZiQy0quswr0uU4K5Y5/DQJStSQFf/fKS1pMBILSipEIXLwbLeCsCowYwUMfdwYKSqQjGxt
	tpmGaF/FDc+cJn24RK3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybUj-0008CN-IE; Tue, 26 Feb 2019 12:05:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybUg-0008Bg-KV
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:05:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FDAF80D;
 Tue, 26 Feb 2019 04:05:50 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B221A3F71D;
 Tue, 26 Feb 2019 04:05:48 -0800 (PST)
Date: Tue, 26 Feb 2019 12:05:46 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [PATCH v5 01/26] KVM: Documentation: Document arm64 core
 registers in detail
Message-ID: <20190226120545.GE3567@e103592.cambridge.arm.com>
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-2-git-send-email-Dave.Martin@arm.com>
 <4086adbf-0a3f-bb44-5ec4-d6f92ed66a42@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4086adbf-0a3f-bb44-5ec4-d6f92ed66a42@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040554_672250_819CAF6D 
X-CRM114-Status: GOOD (  12.40  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 11:48:30AM +0000, Julien Grall wrote:
> Hi Dave,
> 
> On 18/02/2019 19:52, Dave Martin wrote:
> >Since the the sizes of individual members of the core arm64
> >registers vary, the list of register encodings that make sense is
> >not a simple linear sequence.
> >
> >To clarify which encodings to use, this patch adds a brief list
> >to the documentation.
> >
> >Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Reviewed-by: Julien Grall <julien.grall@arm.com>

Thanks
---Dave

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
